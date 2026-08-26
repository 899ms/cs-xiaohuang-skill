# 逐页提示词模式

## Deck style lock

多页生成前写一次，下列内容在每一页原样复用：

```text
Complete 16:9 Chinese PPT-style illustration, final raster page.
Clean warm-white background (#FFF9EF), no paper texture, gradient, shadow, full-page frame, or realistic UI.
Small handwritten page number in the upper-left; short restrained Chinese title centered at the top with one thin hand-drawn underline. Keep body-page title size optically consistent.
Abundant negative space. Minimalist black hand-drawn pen lines with slight natural wobble; warm-yellow recurring character 小黄 is the only yellow subject.
小黄 identity is fixed: an asymmetric soft warm-yellow seed-shaped body, slightly leaning with fuller lower-left and narrower upper-right; a curved thin antenna ending in a hollow orange heart; wide-spaced black vertical oval eyes, tiny smile, peach cheeks, and thin black stick limbs. Never a pear, egg, raindrop, animal, generic mascot, or 3D toy.
小黄 performs the key conceptual action, never decorates. Red-orange only marks a warning/result; blue only marks feedback/system state. Use no more than six short handwritten Chinese labels. Avoid dense infographic cards, formal flowcharts, giant title, childish mascot style, fake English, URLs, watermark, or extra text.
```

## 完整页面模板

```text
Create page <number>/<total> of one coherent 小黄 deck.
Asset type: one complete Chinese PPT-style illustration, final raster page.
Canvas: 16:9, preferred final size 1920x1080 if supported.
Page number exactly: <03 / 10>
Title exactly: <short Chinese title>
Archetype: <one semantic archetype>
Main point: <one sentence>

Apply the deck style lock: <paste it verbatim>.

Composition:
<describe one central action: Xiaohuang's placement, action, one or two props, spatial relationship and result. Keep the subject 40–60% of the canvas and leave at least one third blank.>

Required text only:
<list every visible Chinese text item exactly; keep it short>

Avoid:
extra labels, full paragraphs, formal flowchart, dense cards, shadow, gradient, paper texture, realistic UI, large colorful blocks, oversized title, English filler, watermark, copied composition.
```

## 封面变体

用户明确需要文章 / 活动封面时，改为 21:9（推荐 2520×1080），省略页码，标题可略大但克制。保留同一暖白、线条、角色身份和一个主隐喻；不把它做成商业海报。

## 中文文字修复

只有页面的构图与角色身份已通过、但中文仍错时使用：重新生成或复用接受的视觉，并为每个准确标签预留干净空白区域；不生成占位文字。然后只叠加 `Required text only` 中的文字，并重新检查是否出现重复、错字或额外伪文字。
