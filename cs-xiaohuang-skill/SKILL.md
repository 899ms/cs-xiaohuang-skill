---
name: cs-xiaohuang-skill
description: "小黄（有温度）的统一入口：将中文文章、课程笔记、演讲提纲、产品说明、工作流或粗略想法，转成以小黄为叙事主角的 PPT-style 图像 deck，或生成文章的 21:9 封面与 16:9 正文配图；也生成、编辑和延展小黄的标准图、动作表情、三视图、2D/3D、联名和身份修复。用户提到小黄、有温度 IP、温度种子、爱心天线、小黄 PPT、文章配图、公众号配图、博客配图时使用。"
metadata:
  author: "陈硕"
  collection: "CS Skills"
  source: "https://github.com/ChenShuo2004/cs-xiaohuang-skill"
  compatibility: "Codex and any agent that supports SKILL.md"
---

# 小黄 IP、PPT 与文章配图

小黄是“有温度”的固定品牌角色。这个 skill 既能生成、编辑和延展小黄 IP 资产，也能把内容整理成小黄轻手绘 PPT-style 页面图，或一组服务于文章阅读的封面与正文配图。始终遵守：**可以换动作、场景、媒介和画法；不可以换掉角色身份。**

## 交付边界

- PPT 与文章配图均为完整 raster PNG 页面图；PPT 标准页面和文章正文图为 16:9，推荐 1920×1080。
- 文章或活动封面为 21:9，推荐 2520×1080；文章模式默认交付 1 张封面和 3–6 张正文图。
- 品牌 IP 延展可以交付标准图、动作 / 表情、三视图、2D / 3D、线稿、联名、场景插画或身份修复；根据用户指定尺寸和媒介生成，不强制使用 PPT 画布。
- 本 skill 中的“PPT / 幻灯片 / deck”均指最终视觉页面图，不是可编辑 PPTX、图片型 PPTX 或 PDF。
- 不使用 HTML、SVG、canvas、脚本绘图或 `python-pptx` 作为主要视觉生成手段。用图像生成模型逐页生成；仅可在方向已确认后，对错误中文做确定性文字叠加。
- 复杂架构图、数据仪表盘、正式流程图、密集表格不适合本 skill；应转用可编辑演示文稿或图表工作流。

## 先读什么

所有生产任务都必须查看 `assets/reference-xiaohuang.png`，它是小黄的唯一身份锚点。按当前任务按需加载：

- `references/intake.md`：输入判断、默认值与何时追问。
- `references/narrative-planning.md`：选择叙事骨架和生成 slide blueprint。
- `references/slide-archetypes.md`：按内容语义选择页面结构。
- `references/article-illustrations.md`：文章封面、正文 shot list 与阅读场景的构图规则。
- `references/character-dna.md`：小黄不可改变的形态与颜色规则。
- `references/media-and-variants.md`：2D / 3D、黑白、动作、联名与媒介转换规则。
- `references/ip-prompt-templates.md`：品牌 IP 标准图、3D、风格迁移、联名与局部修复提示词。
- `references/visual-dna.md`：整套页面的构图、文字、色彩和角色规则。
- `references/prompt-patterns.md`：多页 style lock 与逐页图像提示词。
- `references/output-quality.md`：最终交付和质量验收。

使用 `assets/theme-tokens.json` 写紧凑的风格锁定。当前图像工具支持本地参考图时，必须把小黄参考图作为身份参考传入；不支持时，使用角色 DNA 的文字锚点，并在交付中说明是 prompt-matched。

## 工作流

1. **读懂素材。** 读取文章、Markdown、PDF、DOCX、既有 PPTX、课程大纲、讲稿或粗略想法。既有 PPTX 只提取内容与视觉意图，不在本 skill 内编辑或包装它。
2. **做 intake。** 判断主题、受众、场景、交付长度、核心论点、可视化关系与证据充分度。只有缺少会改变结构的关键信息时，才问 1–3 个简短问题。
3. **选择输出模式。** 用户要标准图、动作、3D、联名或修复时选择 **brand IP**，并读取 `references/media-and-variants.md` 和 `references/ip-prompt-templates.md`；用户要演讲、课件或演示稿时选择 **deck**；用户要文章、公众号、博客或 Newsletter 配图时选择 **article illustration**。文章模式先给 shot list；deck 模式先定叙事。内容模式中每页 / 每张图只能有一个主观点。
4. **语义映射版式。** 读取 `references/slide-archetypes.md`。用“对比、转化、筛选、阻塞、分叉、循环、搭建、总结”等页面角色建立节奏，不能机械重复一个模板。
5. **锁定整套风格。** 读取 `references/character-dna.md`、`references/visual-dna.md`，先写一次 style lock，再逐张复用。固定画布、暖白底、线条、调色、留白和小黄身份；deck 额外固定标题与页码，文章正文图默认不放这两个元素。
6. **先出 blueprint 或 shot list。** 用户要求规划、素材不足，或 deck 超过 5 页时，先给 slide-by-slide blueprint。文章配图无论是否生成，都先给 shot list：插入位置、核心意思、构图类型、小黄动作、物件和短标注。
7. **逐张生图。** 每个页面或配图单独调用图像工具；每张只表达一个关系。把小黄参考图传入并用 `references/prompt-patterns.md` 组装提示词。每张使用 `Required text only`，限制可见中文。
8. **验收与交付。** 读取 `references/output-quality.md`。检查身份锚点、文字、尺寸、阅读 / 页面节奏、内容准确性和风格一致性。多张图必须生成并查看 contact sheet，修复失败图后再交付。

## 品牌 IP 延展工作流

1. **锁定输入。** 区分身份参考、风格参考、场景参考与编辑目标；所有任务先查看 `assets/reference-xiaohuang.png`。
2. **写出不变量与变量。** 不变量是种子轮廓、空心爱心天线、面部比例、细四肢与暖色体系；变量是动作、表情、场景、构图、媒介与光线。
3. **单资产生成或编辑。** 标准图、动作、表情、三视图、2D / 3D、黑白、联名和修复均单独生成；局部问题只进行单一目标编辑。
4. **检查身份。** 两个及以上身份锚点失败时重新设计；只有一个局部失败时固定全部不变量后局部修复。联名时双方角色必须分别可辨。
5. **保存交付。** 说明生成数量、每张用途、媒介、文件路径、最稳版本与仍需注意的身份漂移风险。

## 默认值

- 语言：简体中文。
- 受众：对主题有兴趣的中文学习者，不假设专业背景。
- 长度：短观点 5–8 页；文章 deck 8–12 页；课程模块 15–30 页；文章配图为 1 张 21:9 封面 + 3–6 张 16:9 正文图。
- 页面：16:9 PNG，推荐 1920×1080；多张图附 contact sheet。deck 附 blueprint；文章模式附 shot list。
- 品牌 IP：默认暖白背景下的克制 2D 手绘蜡笔 / 油画棒 / 彩铅质感；用户明确要求时才转换为 3D、黑白或其他媒介。
- 视觉：暖白底、轻手绘黑线、充足留白；小黄是解释关系的操作员而非装饰。
- 文字：标题 5–12 字；每页 2–5 个主标注，最多 6 个短标注。

## 强制规则

- 小黄必须保持暖黄色不规则种子形身体、细弯天线与空心爱心、黑色竖椭圆眼、微笑、腮红和细黑四肢；不能变成梨子、鸡蛋、水滴、动物或通用黄色吉祥物。
- 小黄必须承担筛选、搬运、连接、点亮、修复、拆解、阻塞、记录等关键动作。删掉小黄后页面仍毫不费力成立，说明它只是装饰，应重新设计。
- 一页一件事；将长文压缩成结构和图像关系，不做 bullet dump、卡片墙或密集流程图。
- 不复用同一个中心隐喻、物件组合或动作结构；版式的变化来自语义，不来自换标题位置、换配色或随机加入角色。
- 可见中文必须短且准确。若生图文字错误，先减少字数并重生；仍失败时才保留干净预留空间做确定性文字修复。

## 最终回复

完成后简短报告：输出目录和 contact sheet 路径（如有）、deck 页数、文章配图数量或品牌资产数量、采用的假设、已完成的质量检查，以及仍存在的文字或身份漂移风险。
