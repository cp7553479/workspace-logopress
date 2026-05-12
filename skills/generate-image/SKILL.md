---
name: generate-image
description: 当用户想要生成图片或修改现有图片时使用。适用于“生成图片 / 做图 / 出图 / 画图 / 文生图 / 图生图 / 改图 / 编辑图片 / 参考图生成 / 白底图 / 商品图 / 电商图 / 海报图 / 封面图 / 场景图”等请求。
---

# Image Generation

使用 ACP Codex、image CLI 为用户生成图片，参考图使用绝对路径文件，生成结果必须保存到指定绝对路径里

## 执行顺序

默认按以下顺序尝试，前一个失败再用下一个：

1. ACP Codex（`sessions_spawn`，`runtime: "acp"`, `agentId: "codex"`）
2. image CLI

如果用户明确指定工具或方式，按用户指定执行，不做自动回退。

## 结果交付

- 生成成功后，使用 `message` 把图片文件直接发给用户
- 不要只告诉用户本地文件路径

## 输出文件

- 先确定输出目录与文件名
- 文件名简洁、可读、避免空格
- 优先使用 PNG，除非用户明确要 JPEG / WEBP

---

## 方法 1：ACP Codex

通过 `sessions_spawn` 派生 ACP Codex，让 ACP Codex 使用其内置 `image_gen` 能力完成生成。

### 关键规则

- 使用 `sessions_spawn`，不要再使用 `codex exec`。
- 必须设置：`runtime: "acp"`、`agentId: "codex"`、`mode: "run"`。
- 必须传入 `streamTo: "parent"`。
- 派生 ACP Codex 后必须使用 `sessions_yield` 等待生图结果，不要在同一轮里假定已经完成。
- 必须用 `cwd` 指定启动目录；该目录应是当前任务的专用临时目录，里面包含参考图、`AGENTS.md`、plan、输出目录等。
- 图生图时把参考图的绝对路径和用途写进 `task`，并要求 ACP Codex 先读取/检查这些参考图。
- 如果涉及 Logo，必须把 Logo 文件作为参考图写入 `task`，并明确该图片是指定 Logo 文件；必要时同时提供黑/白版本帮助识别，不允许 generic logo。
- 禁止用脚本、PIL、ImageMagick、SVG/canvas、本地合成、程序化贴图来生成最终图片；最终图片必须由生图能力直接生成。
- 指令里要明确：
  - 目标是生成还是编辑
  - 英文生图提示词
  - 每张参考图的绝对路径与用途
  - 输出文件保存位置（绝对路径）
  - 如果图片落在 ACP Codex 自己的 `CODEX_HOME/generated_images`，需要把生成的 PNG 原样复制到指定输出路径

图片/文件路径必须是绝对路径，禁止使用相对路径。

---

## 方法 2：image CLI

使用本地 `image` 命令生成图片。

### 生成命令

基础形式：

```bash
image generate "<提示词>" --model <provider/model>
```

### 常用参数

- `--image <参考图路径或URL>`：可重复传入，用于图生图/参考图
- `--size 2k|4k|<宽x高>`
- `--aspect 1:1|4:3|3:4|16:9|9:16|3:2|2:3|21:9`
- `--format png|jpeg|webp`
- `--background auto|opaque|transparent`
- `--negative-prompt "<负面提示词>"`
- `--output-dir <输出目录（绝对路径）>`
- `--json`
- `--extra '<json object>'`

### 文生图

```bash
image generate "<提示词>" --model <provider/model> --output-dir <输出目录（绝对路径）>
```

### 图生图 / 参考图生成

```bash
image generate "<提示词>" --model <provider/model> --image <参考图路径（绝对路径）> --output-dir <输出目录（绝对路径）>
```

### 多参考图

```bash
image generate "<提示词>" --model <provider/model> --image <参考图1> --image <参考图2> --output-dir <输出目录（绝对路径）>
```

### 检查配置

```bash
image config show --json
image config doctor --json
image config providers
```

---

可使用 web search 搜索“生成 xxx 最佳提示词”，学习提示词写法。

---

## 发送图片给用户

生成成功后，用 `message` 发送图片文件。

### 单张图片

```json
{
  "action": "send",
  "media": "<图片文件路径（绝对路径）>"
}
```

### 带说明发送

```json
{
  "action": "send",
  "media": "<图片文件路径（绝对路径）>",
  "caption": "<简短说明>"
}
```

---

## 执行建议

- 先把用户需求整理成清晰提示词
- 有参考图时，明确“哪些要保留、哪些要修改”
- 商品图/白底图优先强调：主体准确、边缘干净、纯白背景、不要多余道具
- 编辑任务优先强调：只改指定部分，其余保持一致
- 若一种方式报错，不要原地重复；直接切到下一种方式
- 异步执行 command 结束后会自动提醒，无需手动轮询进程状态
- 所有文件路径必须绝对路径，不能使用相对路径
