# 小黄 PPT 与文章配图

> 把文章、课程笔记、产品说明或一个想法，做成由小黄解释的中文轻手绘 PPT-style 页面图，或文章封面与正文配图。
>
> 16:9 标准页面 / 正文图｜21:9 封面｜PNG 输出｜统一小黄身份｜适合知识内容、教学、产品讲解与文章写作

## 这是什么

小黄 PPT 是一个 Codex Skill。它会先理解内容：做演示时建立叙事和逐页 blueprint；做文章时识别认知锚点并输出 shot list。之后将页面或配图逐张生成可直接交付的 PNG。

它不是传统 PPT 模板，也不是可编辑 PPTX 生成器。它的核心是让固定品牌角色“小黄”通过筛选、连接、修复、点亮、搬运等动作，解释内容中最关键的判断、关系与转折。

工作顺序是：

1. 从素材中提炼必须让读者理解的主线。
2. 为每一页选择合适的语义版式，而不是重复套版。
3. 锁定暖白底、黑色轻手绘线条、小黄 DNA、标题与页码位置。
4. 逐页生成完整 PNG，并用 contact sheet 检查整套一致性。

## 适合谁用

- 想把文章、公众号、博客、Newsletter 或 Notion 做成小黄封面与正文配图的人。
- 想把文章、公众号、Notion 或课程提纲变成小黄风格课件的人。
- 需要一套有固定角色人格的产品介绍、工作流说明或知识内容的人。
- 希望 AI 先想清楚“每一页讲什么”，再生成视觉页面的人。
- 需要可快速审阅和发布的图片型演示稿，而不是可编辑的 PowerPoint 文件的人。

不适合：可编辑 PPTX、复杂架构图、数据仪表盘、密集表格、逐字讲稿，或需要复杂动效与交互的内容。

## 默认产出

- 16:9 PNG 标准页面（推荐 1920×1080）
- 文章模式默认的 1 张 21:9 封面（推荐 2520×1080）与 3–6 张 16:9 正文图
- 多页 contact sheet
- deck 的简短 slide-by-slide blueprint，或文章的 shot list

默认不产出：可编辑 PPTX、图片型 PPTX、PDF、HTML、SVG、Canvas 或程序化矢量图。

## 小黄的视觉 DNA

小黄是“有温度”的固定角色，而不是通用黄色卡通：暖黄色、不规则、微倾斜的种子形身体，顶部细弯天线末端是空心暖橙爱心，黑色竖椭圆眼、腮红和细黑四肢。

整套 PPT 使用暖白背景、自然轻微抖动的黑色手绘线、克制的红橙/蓝色状态标记和大量留白。小黄必须完成画面中关键的解释动作，不能只是角落装饰。

![小黄角色参考](cs-xiaohuang-ppt/assets/reference-xiaohuang.png)

## 示例效果

这些示例用于校准小黄的身份、留白与“用动作解释概念”的方式。真正生成 deck 时，每页会按语义重新选择构图，不复制既有画面。

| 一个核心动作 | 把关系画出来 | 抽象变成看得见 |
| --- | --- | --- |
| ![一个核心动作](examples/images/01-cognitive-anchor.png) | ![把关系画出来](examples/images/03-relation-reveal.png) | ![抽象变成看得见](examples/images/05-metaphor-translation.png) |

## 安装

下载或克隆本仓库后，进入仓库根目录，只把 `cs-xiaohuang-ppt/` 安装到 Codex skills 目录：

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R ./cs-xiaohuang-ppt "${CODEX_HOME:-$HOME/.codex}/skills/"
```

Windows PowerShell：

```powershell
Copy-Item -Recurse .\cs-xiaohuang-ppt "$env:USERPROFILE\.codex\skills\cs-xiaohuang-ppt"
```

## 怎么用

### 文章变成一套小黄课件图

```text
Use $cs-xiaohuang-ppt 把下面文章做成 10 页小黄轻手绘 PPT-style 页面图。
面向刚接触这个主题的中文读者；先给 slide blueprint，再逐页生成 16:9 PNG 和 contact sheet。
小黄必须承担解释关键关系的动作，文字保持短。

<粘贴文章>
```

### 文章封面与正文配图

```text
Use $cs-xiaohuang-ppt 为下面文章生成 1 张 21:9 封面图和 4 张 16:9 正文配图。
先识别最值得被理解的认知锚点并输出 shot list；每张图只解释一个关系。
正文配图默认不要页码或 PPT 标题，小黄必须完成关键动作；最后输出 contact sheet。

<粘贴文章>
```

### 产品或工作流说明

```text
Use $cs-xiaohuang-ppt 将这个产品工作流做成 8 页小黄 PPT 图。
目标是让潜在用户理解：旧方法卡在哪里、系统如何处理、最终获得什么。
先规划叙事；不要做可编辑 PPTX，不要使用卡片墙或正式流程图。

<粘贴素材>
```

### 只要规划，不生成图片

```text
Use $cs-xiaohuang-ppt 先不要生图。
把下面内容规划为一套 6 页左右的小黄 PPT-style deck。
逐页给出标题、主旨、archetype、小黄动作、可见中文和图像 brief。

<粘贴素材>
```

更多提示词可见 [examples/prompts.md](examples/prompts.md)。

## 工作流

1. 读取素材并判断受众、目标、核心论点与素材充分度。
2. 选择教学、说服、产品解释、复盘或知识卡片叙事。
3. 做 deck 时用语义选择“对比、转化、筛选、阻塞、分叉、循环、搭建、总结”等页面结构；做文章时先从全文挑出 3–6 个认知锚点。
4. 锁定同一套角色身份、画布、线条、颜色与留白；deck 固定标题和页码，文章正文图默认不使用它们。
5. 为每页 / 每张图输出精准的图像 brief 和 `Required text only`。
6. 逐张生成并校验：中文、比例、身份、构图和风格。
7. 生成 contact sheet，修复不一致页面或配图后交付。

## 目录结构

```text
.
├── README.md
├── LICENSE
├── NOTICE.md
├── examples/
│   ├── images/
│   └── prompts.md
└── cs-xiaohuang-ppt/               # 安装此目录
    ├── SKILL.md
    ├── agents/openai.yaml
    ├── assets/
    │   ├── reference-xiaohuang.png
    │   └── theme-tokens.json
    └── references/
        ├── character-dna.md
        ├── article-illustrations.md
        ├── intake.md
        ├── narrative-planning.md
        ├── output-quality.md
        ├── prompt-patterns.md
        ├── slide-archetypes.md
        └── visual-dna.md
```

## 注意事项

- 图片模型最容易在中文长文字上出错；标题与标签越短越稳定。
- 多页创作不能只复用一个构图。保持同一母版，改变中间的语义动作与物件。
- 小黄的天线、空心爱心、种子轮廓和细黑四肢是身份锚点；两个以上锚点出错时，应重做而非将错就错。
- 生成图片模型可能出现错字、虚假标签或物件关系错误。请在 contact sheet 之外逐页查看最终图。

## 致谢

本仓库的“内容 intake → 叙事 → 页面 archetype → 风格锁定 → 逐页提示词 → 交付 QA”结构，参考了 [Ian Handdrawn PPT](https://github.com/helloianneo/ian-handdrawn-ppt) 的公开工作流思路；没有复制其图片素材或其视觉风格。小黄角色、视觉 DNA 与原始品牌资产来自 [CS Skills](https://github.com/ChenShuo2004/cs-skills)。

## License

MIT License，见 [LICENSE](LICENSE)。小黄形象与品牌相关使用请遵守品牌方的授权和使用规范。
