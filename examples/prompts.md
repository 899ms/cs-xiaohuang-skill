# 示例提示词

## 0. 一篇文章 → 封面与正文配图

```text
Use $cs-xiaohuang-ppt 为下面文章生成 1 张 21:9 小黄封面图和 4 张 16:9 正文配图。
先输出 shot list，选择真正需要视觉解释的认知锚点，不要为每段机械配图。
正文图默认不使用页码或 PPT 标题；每张只表达一个关系，小黄必须执行关键动作；最后输出 contact sheet。

<粘贴文章>
```

## 1. 一篇文章 → 课件图

```text
Use $cs-xiaohuang-ppt 把下面文章做成 8 页小黄轻手绘 PPT-style 页面图。
面向非技术创业者，目标是理解 AI 自动化该从哪里开始。
先给逐页 blueprint；每页只讲一个判断，小黄承担关键动作；再生成 16:9 PNG 和 contact sheet。

<粘贴文章>
```

## 2. 产品说明 → 演示图

```text
Use $cs-xiaohuang-ppt 将下面产品说明变成 7 页小黄 deck。
结构按：用户卡点 → 旧方法为什么不行 → 产品机制 → 使用路径 → 最终变化。
只做最终 PNG 页面图，不需要可编辑 PPTX。避免卡片墙和正式流程图。

<粘贴产品说明>
```

## 3. 先做页面规划

```text
Use $cs-xiaohuang-ppt 先不要生图。
请把内容规划成 6 页的中文小黄 PPT-style deck；每页输出标题、唯一主旨、页面 archetype、小黄动作、主要物件、Required text only 和图像 brief。

<粘贴素材>
```
