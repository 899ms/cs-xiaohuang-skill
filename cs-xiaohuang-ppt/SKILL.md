---
name: cs-xiaohuang-ppt
description: "将中文文章、课程笔记、演讲提纲、产品说明、工作流或粗略想法，转成以小黄（有温度）为叙事主角的中文轻手绘 PPT-style 整页图像 deck。用户提到小黄 PPT、小黄课件、小黄演示稿、小黄幻灯片，或希望把内容做成统一风格的 PNG 页面图时使用。默认输出 16:9 PNG 页面、contact sheet 与 slide blueprint；不输出可编辑 PPTX。"
metadata:
  author: "陈硕"
  collection: "CS Skills"
  source: "https://github.com/ChenShuo2004/cs-skills"
  compatibility: "Codex and any agent that supports SKILL.md"
---

# 小黄 PPT

把内容整理成一套统一、可交付的小黄轻手绘 PPT-style 页面图。目标不是套模板，而是让小黄用一个个具体动作解释观众真正需要理解的判断、关系和变化。

## 交付边界

- 默认交付是完整 raster PNG 页面图；标准页面为 16:9，推荐 1920×1080。
- 文章或活动封面仅在用户要求时制作 21:9，推荐 2520×1080。
- 本 skill 中的“PPT / 幻灯片 / deck”均指最终视觉页面图，不是可编辑 PPTX、图片型 PPTX 或 PDF。
- 不使用 HTML、SVG、canvas、脚本绘图或 `python-pptx` 作为主要视觉生成手段。用图像生成模型逐页生成；仅可在方向已确认后，对错误中文做确定性文字叠加。
- 复杂架构图、数据仪表盘、正式流程图、密集表格不适合本 skill；应转用可编辑演示文稿或图表工作流。

## 先读什么

所有生产任务都必须查看 `assets/reference-xiaohuang.png`，它是小黄的唯一身份锚点。按当前任务按需加载：

- `references/intake.md`：输入判断、默认值与何时追问。
- `references/narrative-planning.md`：选择叙事骨架和生成 slide blueprint。
- `references/slide-archetypes.md`：按内容语义选择页面结构。
- `references/character-dna.md`：小黄不可改变的形态与颜色规则。
- `references/visual-dna.md`：整套页面的构图、文字、色彩和角色规则。
- `references/prompt-patterns.md`：多页 style lock 与逐页图像提示词。
- `references/output-quality.md`：最终交付和质量验收。

使用 `assets/theme-tokens.json` 写紧凑的风格锁定。当前图像工具支持本地参考图时，必须把小黄参考图作为身份参考传入；不支持时，使用角色 DNA 的文字锚点，并在交付中说明是 prompt-matched。

## 工作流

1. **读懂素材。** 读取文章、Markdown、PDF、DOCX、既有 PPTX、课程大纲、讲稿或粗略想法。既有 PPTX 只提取内容与视觉意图，不在本 skill 内编辑或包装它。
2. **做 intake。** 判断主题、受众、场景、交付长度、核心论点、可视化关系与证据充分度。只有缺少会改变结构的关键信息时，才问 1–3 个简短问题。
3. **先定叙事。** 读取 `references/narrative-planning.md`，选择教学、说服、产品解释、复盘报告或知识卡片结构。每页只能有一个主观点。
4. **语义映射版式。** 读取 `references/slide-archetypes.md`。用“对比、转化、筛选、阻塞、分叉、循环、搭建、总结”等页面角色建立节奏，不能机械重复一个模板。
5. **锁定整套风格。** 读取 `references/character-dna.md`、`references/visual-dna.md`，先写一次 deck style lock，再逐页复用。固定画布、暖白底、标题位置、页码、线条、调色、留白和小黄身份；只改变中间的语义动作与物件。
6. **先出 blueprint。** 用户要求规划、素材不足，或页数超过 5 页时，先给 slide-by-slide blueprint。每页列出标题、主旨、archetype、小黄动作、可见文字和图像 brief。
7. **逐页生图。** 每个页面单独调用图像工具；每张只表达一个关系。把小黄参考图传入并用 `references/prompt-patterns.md` 组装提示词。每页使用 `Required text only`，限制可见中文。
8. **验收与交付。** 读取 `references/output-quality.md`。检查身份锚点、文字、尺寸、页面节奏、内容准确性和风格一致性。多页必须生成并查看 contact sheet，修复失败页后再交付。

## 默认值

- 语言：简体中文。
- 受众：对主题有兴趣的中文学习者，不假设专业背景。
- 长度：短观点 5–8 页；文章 8–12 页；课程模块 15–30 页。
- 页面：16:9 PNG，推荐 1920×1080；多页附 contact sheet 和简短 blueprint。
- 视觉：暖白底、轻手绘黑线、充足留白；小黄是解释关系的操作员而非装饰。
- 文字：标题 5–12 字；每页 2–5 个主标注，最多 6 个短标注。

## 强制规则

- 小黄必须保持暖黄色不规则种子形身体、细弯天线与空心爱心、黑色竖椭圆眼、微笑、腮红和细黑四肢；不能变成梨子、鸡蛋、水滴、动物或通用黄色吉祥物。
- 小黄必须承担筛选、搬运、连接、点亮、修复、拆解、阻塞、记录等关键动作。删掉小黄后页面仍毫不费力成立，说明它只是装饰，应重新设计。
- 一页一件事；将长文压缩成结构和图像关系，不做 bullet dump、卡片墙或密集流程图。
- 不复用同一个中心隐喻、物件组合或动作结构；版式的变化来自语义，不来自换标题位置、换配色或随机加入角色。
- 可见中文必须短且准确。若生图文字错误，先减少字数并重生；仍失败时才保留干净预留空间做确定性文字修复。

## 最终回复

完成后简短报告：输出目录和 contact sheet 路径、页数与 deck 类型、采用的假设、已完成的质量检查，以及仍存在的文字或身份漂移风险。
