# 知识课程风格索引

本库把“有辨识度的首屏”扩展为能讲完一堂课的 deck 系统。每套风格都必须覆盖：封面、章节、核心概念、关系解释、步骤、对比、练习/提问和结尾。

## 默认选择

知识课程默认同时做以下三个真实封面预览：

1. [Warm Intelligence](styles/warm-intelligence.md)：首次接触、中文教学、方法论和有温度的内容。
2. [Swiss Signal](styles/swiss-signal.md)：框架、模型、案例拆解和信息密度较高的课程。
3. [Editorial Noir](styles/editorial-noir.md)：创始人故事、反思型课程和有明确叙事弧的内容。

三个预览都使用课程的实际标题、一个真实概念和用户的 logo（如有）；不能只做色板或模板命名页。

## 完整风格库

| 风格 | 主要气质 | 课程最佳用途 | 谨慎使用 |
| --- | --- | --- | --- |
| [Warm Intelligence](styles/warm-intelligence.md) | 温暖、清楚、轻盈 | 入门课、中文方法论、团队共识 | 严肃财务/风险汇报 |
| [Swiss Signal](styles/swiss-signal.md) | 结构、精确、可信 | 框架、流程、案例、数据 | 情绪表达与长故事 |
| [Editorial Noir](styles/editorial-noir.md) | 克制、思辨、叙事 | 创始人观点、品牌课、结论型分享 | 密集表格和步骤教学 |
| [Bio-Techno Reveal](styles/bio-techno-reveal.md) | 沉浸、未来、探索 | AI、产品、科技趋势、开场 | 长时间阅读与小屏学习 |
| [Pixel Signal](styles/pixel-signal.md) | 新锐、实验、能量 | AI 工具、开发者、年轻创作者 | 高正式度客户培训 |
| [Liquid Metal Ops](styles/liquid-metal-ops.md) | 高级、稳重、执行 | 企业 AI、运营系统、管理层课程 | 初学者、温暖沟通 |

## 选择规则

- **受众不熟悉主题**：优先 Warm Intelligence；用具象隐喻、分步动画和更多留白。
- **需要带走工具或框架**：优先 Swiss Signal；用强网格、编号和清晰图例。
- **目标是改变一个判断**：优先 Editorial Noir；用一句结论、一段证据和一个转折。
- **开场需要惊喜但正文仍需教清楚**：Bio-Techno 或 Pixel Signal 只用于科技主题；从第二章起降低动态密度。
- **企业内部推进或高层共识**：优先 Liquid Metal Ops；把金属/玻璃效果控制在导航和重点状态，正文保持清晰。

## 不可省略的约束

- 一套 deck 只能选一个主风格。混搭仅限单个辅助元素，并要保持标题、正文、网格和色彩系统一致。
- 不把参考中的外部视频、远程图片、品牌名、logo 或专有文字固化进输出。优先使用用户资产；没有资产时用 CSS 形状、网格、线条或纹理替代。
- 高能动效只能服务于封面、章节转换或关系揭示；正文不得因为视觉效果牺牲阅读。
- 无论风格，中文正文优先选择可稳定渲染的字体，并在固定 1920×1080 舞台中保持舒适字号。
