[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string]$PptxPath,

  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string]$OutputDir,

  [switch]$Force
)

$ErrorActionPreference = "Stop"

function Get-EntryText {
  param([Parameter(Mandatory = $true)]$Entry)

  $stream = $Entry.Open()
  $reader = [System.IO.StreamReader]::new($stream)
  try {
    return $reader.ReadToEnd()
  } finally {
    $reader.Dispose()
    $stream.Dispose()
  }
}

function Get-ZipRelativePath {
  param(
    [Parameter(Mandatory = $true)][string]$BaseEntry,
    [Parameter(Mandatory = $true)][string]$Target
  )

  $baseUri = [Uri]::new("https://pptx.local/" + $BaseEntry)
  $resolvedUri = [Uri]::new($baseUri, $Target)
  return $resolvedUri.AbsolutePath.TrimStart("/")
}

function Copy-ZipEntry {
  param(
    [Parameter(Mandatory = $true)]$Entry,
    [Parameter(Mandatory = $true)][string]$Destination
  )

  $parent = Split-Path -Parent $Destination
  [System.IO.Directory]::CreateDirectory($parent) | Out-Null
  $input = $Entry.Open()
  $output = [System.IO.File]::Create($Destination)
  try {
    $input.CopyTo($output)
  } finally {
    $output.Dispose()
    $input.Dispose()
  }
}

function Get-ImageRelationshipTargets {
  param(
    [Parameter(Mandatory = $true)]$SlideXml,
    [Parameter(Mandatory = $true)]$RelationshipsXml,
    [Parameter(Mandatory = $true)][string]$SlideEntryName
  )

  $relationshipMap = @{}
  foreach ($relationship in $RelationshipsXml.SelectNodes("//*[local-name()='Relationship']")) {
    $relationshipMap[$relationship.Id] = [string]$relationship.Target
  }

  $imagePaths = [System.Collections.Generic.List[string]]::new()
  foreach ($blip in $SlideXml.SelectNodes("//*[local-name()='blip']")) {
    $embedId = $blip.GetAttribute("embed", "http://schemas.openxmlformats.org/officeDocument/2006/relationships")
    if ([string]::IsNullOrWhiteSpace($embedId)) {
      $embedAttribute = $blip.Attributes | Where-Object { $_.LocalName -eq "embed" } | Select-Object -First 1
      if ($null -ne $embedAttribute) {
        $embedId = $embedAttribute.Value
      }
    }

    if (-not [string]::IsNullOrWhiteSpace($embedId) -and $relationshipMap.ContainsKey($embedId)) {
      $imagePaths.Add((Get-ZipRelativePath -BaseEntry $SlideEntryName -Target $relationshipMap[$embedId]))
    }
  }

  return @($imagePaths | Select-Object -Unique)
}

function Get-SlideParagraphs {
  param([Parameter(Mandatory = $true)]$SlideXml)

  $paragraphs = [System.Collections.Generic.List[string]]::new()
  foreach ($paragraph in $SlideXml.SelectNodes("//*[local-name()='p']")) {
    $runs = $paragraph.SelectNodes(".//*[local-name()='t']") | ForEach-Object { $_.InnerText }
    $text = ($runs -join "").Trim()
    if (-not [string]::IsNullOrWhiteSpace($text)) {
      $paragraphs.Add($text)
    }
  }

  if ($paragraphs.Count -eq 0) {
    $runs = $SlideXml.SelectNodes("//*[local-name()='t']") | ForEach-Object { $_.InnerText }
    $text = ($runs -join " ").Trim()
    if (-not [string]::IsNullOrWhiteSpace($text)) {
      $paragraphs.Add($text)
    }
  }

  return @($paragraphs)
}

$source = (Resolve-Path -LiteralPath $PptxPath -ErrorAction Stop).Path
if ([System.IO.Path]::GetExtension($source).ToLowerInvariant() -ne ".pptx") {
  throw "PptxPath must point to a .pptx file."
}

$output = [System.IO.Path]::GetFullPath($OutputDir)
if (Test-Path -LiteralPath $output) {
  $existingItems = Get-ChildItem -LiteralPath $output -Force -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($null -ne $existingItems -and -not $Force) {
    throw "OutputDir already contains files. Choose an empty folder or pass -Force to overwrite extracted files."
  }
} else {
  [System.IO.Directory]::CreateDirectory($output) | Out-Null
}

$assetsDir = Join-Path $output "assets"
[System.IO.Directory]::CreateDirectory($assetsDir) | Out-Null

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$archive = [System.IO.Compression.ZipFile]::OpenRead($source)

try {
  $entries = @{}
  foreach ($entry in $archive.Entries) {
    $entries[$entry.FullName] = $entry
  }

  $mediaEntries = @($archive.Entries | Where-Object { $_.FullName -like "ppt/media/*" -and -not $_.FullName.EndsWith("/") })
  foreach ($mediaEntry in $mediaEntries) {
    $assetName = [System.IO.Path]::GetFileName($mediaEntry.FullName)
    Copy-ZipEntry -Entry $mediaEntry -Destination (Join-Path $assetsDir $assetName)
  }

  $slideEntries = @(
    $archive.Entries |
      Where-Object { $_.FullName -match "^ppt/slides/slide([0-9]+).xml$" } |
      Sort-Object { [int]([regex]::Match($_.FullName, "slide([0-9]+).xml$").Groups[1].Value) }
  )

  $slides = [System.Collections.Generic.List[object]]::new()
  foreach ($slideEntry in $slideEntries) {
    $slideNumber = [int]([regex]::Match($slideEntry.FullName, "slide([0-9]+).xml$").Groups[1].Value)
    [xml]$slideXml = Get-EntryText -Entry $slideEntry
    $relationsEntryName = "ppt/slides/_rels/slide" + $slideNumber + ".xml.rels"
    [xml]$relationshipsXml = "<Relationships />"
    if ($entries.ContainsKey($relationsEntryName)) {
      [xml]$relationshipsXml = Get-EntryText -Entry $entries[$relationsEntryName]
    }

    $paragraphs = @(Get-SlideParagraphs -SlideXml $slideXml)
    $sourceImagePaths = @(Get-ImageRelationshipTargets -SlideXml $slideXml -RelationshipsXml $relationshipsXml -SlideEntryName $slideEntry.FullName)
    $images = @(
      foreach ($sourceImagePath in $sourceImagePaths) {
        if ($sourceImagePath -like "ppt/media/*") {
          "assets/" + [System.IO.Path]::GetFileName($sourceImagePath)
        }
      }
    )
    $title = if ($paragraphs.Count -gt 0) { $paragraphs[0] } else { "Untitled slide " + $slideNumber }

    $slides.Add([pscustomobject][ordered]@{
      number = $slideNumber
      title = $title
      paragraphs = $paragraphs
      images = $images
      sourceSlide = $slideEntry.FullName
    })
  }

  $manifest = [pscustomobject][ordered]@{
    source = [System.IO.Path]::GetFileName($source)
    extractedAt = (Get-Date).ToString("o")
    slideCount = $slides.Count
    mediaCount = $mediaEntries.Count
    slides = $slides
  }
  $manifest | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $output "manifest.json") -Encoding utf8

  $markdown = [System.Collections.Generic.List[string]]::new()
  $markdown.Add("# Extracted PPTX content")
  $markdown.Add("")
  $markdown.Add("Source: " + [System.IO.Path]::GetFileName($source))
  $markdown.Add("Slides: " + $slides.Count)
  $markdown.Add("Extracted media files: " + $mediaEntries.Count)
  foreach ($slide in $slides) {
    $markdown.Add("")
    $markdown.Add("## Slide " + $slide.number + " — " + $slide.title)
    if ($slide.paragraphs.Count -eq 0) {
      $markdown.Add("- No editable text detected.")
    } else {
      foreach ($paragraph in $slide.paragraphs) {
        $markdown.Add("- " + $paragraph)
      }
    }
    if ($slide.images.Count -gt 0) {
      $markdown.Add("")
      $markdown.Add("Images:")
      foreach ($image in $slide.images) {
        $markdown.Add("- " + $image)
      }
    }
  }
  $markdown | Set-Content -LiteralPath (Join-Path $output "slides.md") -Encoding utf8

  Write-Output ("Extracted " + $slides.Count + " slides and " + $mediaEntries.Count + " media files to " + $output)
  if ($Force) {
    Write-Output "Force overwrote extracted files but did not remove stale assets from the output folder."
  }
} finally {
  $archive.Dispose()
}
