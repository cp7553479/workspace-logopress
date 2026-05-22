---
name: asi-product-image-generator
description: Generate ASI product image sets(首图、场景图、卖点图、尺寸图、材质工艺图、SKU图) or a specified product main image. Launch when 用户说生成asi电商套图、生成主图、生成场景图、生成卖点图、生成多SKU图、生成尺寸示意图、生成印刷效果图、生成材质工艺图，or requests product image generation, main image generation, or product profile image generation.
---

# asi-product-image-generator

## 目标

面向北美促销礼品经销商业务，为指定的商品生成电商套图，并把结果写回 `商品主图` 字段。若有多个产品，可以派生多个subagent分别阅读本skill，然后处理指定产品。

**注意：**
以下 base-token、table-id、view-id、field-id 均为示例值，请根据实际情况替换成实际值，先读取表结构，再思考下一步。
请使用`message` tool输出你的思考，充分与用户沟通，例如使用message tool输出你的思考步骤、计划、生图提示词内容、参考图选择决策，生图工具的选择等。

生成图片时，使用合适的生图工具/技能生成图片，传入参考图，编写生图指令。每次调用必须传入产品参考图与英文提示词。你必须合理选择参考图以及设计提示词，建议 `1-3` 张白底图或除了有产品以外比较干净的图，如果是生成多 SKU 图可以传入 9 张参考图（可使用代码将参考图拼接成一张图片，并压缩图片文件为3MB大小之内，然后作为参考图传入，避免生图工具对于参考图传入数量的限制）。当产品是可以拆卸或者可折叠时，并且你希望生成的图片是展示拆卸后或折叠后的图，请你选择对应的参考图（例如可拆卸的参考图和可折叠的参考图），然后在提示词里面明确指出参考 xxx 图的产品拆卸/折叠方式，生成 xxx 图。总之你必须决定要生成什么样的图片，提示词怎么写，使用哪些参考图，提示词里如何强化怎么参考提供的参考图。如果遇到问题，立马停止，并告诉我问题在哪里，由我选择下一步方案。

以下图片类型均属于`商品主图`的图片类型：

- 首图：通常作为商品在线上展示的第一张图片
- 场景图：商品在场景里包含卖点的图
- 卖点图：商品的卖点图海报
- 尺寸图：商品的长宽高标识示意图
- 材质工艺图：展示材质和印刷工艺等细节
- SKU 图：展示多个不同的颜色和规格整合在一张图中（通常一张 SKU 图不超过 9 宫格的布局，可多生成几张不同的 SKU 图来覆盖所有 SKU）

`商品表` 是以 `产品编号` 为记录的索引（如果有 `record_id` 也可以作为索引），获取 `参考图片`、`白底图` 字段的附件作为参考图并下载到本地（按产品分文件夹分类好，避免文件交叉）。每个商品必须先在 workspace 的 `temp/` 目录下创建专用临时目录，用于存放 `AGENTS.md`、参考图、白底图、生成图和上传记录；目录名必须包含产品编号，建议格式为 `temp/<产品编号>_asi_<record_id>/`。生成后的主图/套图需传入到 `商品主图` 附件字段里。

需下载和上传附件请阅读 `lark-cli` 如何向飞书多维表格中上传和下载附件：

### 下载 Base 附件到本地（不代入具体值）

先读取原始 Bitable record，拿到附件字段中的 `file_token` 以及下载所需的 `extra.bitablePerm`：

```bash
lark-cli api GET \
  /open-apis/bitable/v1/apps/<base_token>/tables/<table_id>/records/<record_id> \
  --as user
```

然后使用原始下载接口下载附件：

```bash
lark-cli api GET /open-apis/drive/v1/medias/<file_token>/download \
  --as user \
  --params '{"extra":"{"bitablePerm":{"tableId":"<table_id>","rev":<rev>}}"}' \
  --output ./temp/<产品编号>_asi_<record_id>/references/<filename>
```

如需先获取临时下载地址：

```bash
lark-cli api GET /open-apis/drive/v1/medias/batch_get_tmp_download_url \
  --as user \
  --params '{"file_tokens":"<file_token>","extra":"{"bitablePerm":{"tableId":"<table_id>","rev":<rev>}}"}'
```

**注意：** 临时下载地址随时会过期，请使用前获取最新的地址，请勿使用记忆的地址，请勿将临时链接写入到记忆中。

### 上传本地图片到 Base 附件字段（不代入具体值）

```bash
cd <local_output_dir> && \
lark-cli base +record-upload-attachment \
  --base-token <base_token> \
  --table-id <table_id> \
  --record-id <record_id> \
  --field-id "商品主图" \
  --file ./<generated_image_file> \
  --name <generated_image_file>
```

## 全局硬约束

以下要求为底线规则，适用于当前商品、当前商品的所有图片、所有 Prompt：

1. 所有提示词必须为英文。
2. 图片中严禁出现任何中文字符；所有文字必须使用英文，或由中文准确翻译成自然英文。
3. 图片中严禁出现任何价格、货币符号、折扣、优惠、促销文案或其他与价格相关的信息。
4. 图片中严禁出现任何二维码、水印、厂家信息、厂商名称、供应商信息、平台信息、联系方式、网址、厂商或平台标识、多余标记。
5. 需要 Logo 时，以指定 Logo 文件为准。首图必须带 Logo；其他图默认不加 Logo。
6. 不允许虚构素材中不存在的颜色、款式、结构、尺寸、材质、功能、接口、配件或 SKU。
7. 不写兼容逻辑，不写回退逻辑；不满足条件的图片类型直接跳过。
8. 每张图片的 Prompt 都必须明确要求输出比例为 `1:1`。
9. 每次生图时必须传入至少一张参考图。不要交叉生图，分清楚每个产品需要使用独立的生图提示词和对应的参考图，不可以混淆。

### Prompt 视觉质量硬要求

以下要求必须写进每张生图 Prompt（尺寸图除外，尺寸图以清晰准确为第一优先）：

- 图片必须是 professional, beautiful, high-converting Amazon-style ecommerce image。
- 画面必须有 clean premium layout、strong visual hierarchy、balanced spacing、attractive lighting、polished commercial poster design、modern typography。
- 场景图、卖点图、材质工艺图、SKU 图必须体现专业电商主图/电商海报级设计感，不能像普通随手照片、低质拼图或简单截图。
- 所有设计优化不得改变产品真实结构、颜色、材质、配件、尺寸或已确认信息。

### 源素材图（参考图）

源素材图是指飞书多维表格的 `商品表` 的 `参考图片`、`白底图` 字段的附件，需要下载到本地，如果 `白底图` 没有文件，则还需阅读 `generate-white-background` skill，先为该商品生成白底图（如果有多个颜色，每个颜色都需要生成一张白底图）。用户可能会直接发送图片给你，向用户确认该图片对应的“产品编号”，同样可以视为参考图。

## 商品专用临时目录与 AGENTS.md

在处理任何商品之前，必须先创建商品专用临时目录：

```text
<workspace>/temp/<产品编号>_asi_<record_id>/
```

该目录用于集中保存：

- `AGENTS.md`：markdown文件，保存当前商品分析、素材映射、生成计划、Prompt 归档、任务状态
- `references/`：从飞书下载的参考图、白底图、Logo 辅助参考等
- `outputs/`：所有生成结果
- `uploads/`：上传回飞书后的响应记录

`AGENTS.md` 必须在开始生图前生成，至少包含：

- 当前商品编号、record_id、Base token、table id
- 当前商品可确认的产品描述、材质、尺寸、颜色/SKU
- 本商品的参考图清单及用途
- 全局硬约束：1:1、英文提示词、禁止中文、禁止价格/折扣/二维码/水印/厂家信息/厂商标识/供应商信息/平台信息/联系方式/网址、禁止虚构 SKU/结构/材质
- Logo：需要 Logo 时以指定 Logo 文件为准；首图必须带 Logo；其他图默认不加 Logo
- 输出文件必须保存到本商品 `outputs/` 目录
- 禁止使用脚本/PIL/ImageMagick/SVG/canvas/本地合成来生成最终图片，除非用户明确要求

## 生图工具/技能使用要求

生成图片时，使用合适的生图工具/技能生成图片，传入参考图，编写生图指令。每张图必须使用当前商品独立的参考图与英文 Prompt，并将输出保存到当前商品 `outputs/` 目录。

## 生成商品套图工作流程

当前商品必须按以下主链路执行：

1. 创建当前商品专用临时目录：`<workspace>/temp/<产品编号>_asi_<record_id>/`，并创建 `references/`、`outputs/`、`uploads/` 子目录。
2. 在该目录生成 `AGENTS.md`，写清楚当前商品任务、素材、硬约束和输出规则。
3. 下载当前商品的全部源素材图（从飞书多维表格下载下来的参考图、白底图，或用户提供的图片）到该目录的 `references/`。
4. 检查`白底图` 字段有没有文件，白底图是重要的参考图，如果 `白底图` 字段没有文件，必须先阅读 `generate-white-background` skill，并先为该商品生成白底图、上传回 `白底图` 字段，再使用白底图作为参考图继续生成其他图片。如果有多个SKU，每个SKU都需要生成一张白底图。
5. 分析每张图片的内容、角度、背景、是否含尺寸信息、是否含材质信息、是否为 SKU 图、是否适合作为白底参考图、是否适合作为主图参考图。
6. 创建或更新当前商品`AGENTS.md`，位置在商品专用临时目录内。
7. 在 `AGENTS.md` 中写清楚产品描述、素材清单、参考图映射、生成计划、任务状态、历史产物记录。
8. 按图片类型规则判断当前商品需要生成哪些图。
9. 发起 webSearch，然后为每一张待生成图片单独编写英文 Prompt。
10. 先生成场景图、卖点图、尺寸图、材质工艺图、SKU 图等；首图必须最后生成，并使用白底图、已生成的场景/卖点/尺寸/材质/SKU图以及 Logo 文件作为参考。
11. 当前商品完成后，update_plan 中的任务状态、已生成文件、Prompt 记录与跳过原因。

## 商品内调用规则

对当前商品文件夹，严格按以下方式发起生图任务：

2. 每张图都必须单独编写英文 Prompt，不可以使用一个 prompt 来生成多个不同类型的图片。
3. 每张图的 Prompt 都必须明确要求：完全参考参考图上的商品，且图片比例是 `1:1`。

## `AGENTS.md`要求

`AGENTS.md`文件保存位置与参考图下载位置一致，统一保存在 workspace 下的 `temp/<产品编号>_asi_<record_id>/` 专用临时目录；plan 文件名需自定义且必须包含产品编号。

### 1. 产品描述（必填）

基于素材与商品信息写清，只写可确认的信息，不允许猜测：

- 产品名称（建议中英文都写；生成提示词时用英文名）
- 产品卖点（核心 `1-3` 条，用于场景图/卖点图文案填空）
- 规格/尺寸（若有：单位统一为 `inch`，用于尺寸图；缺失则写明无法确认）
- 材质/工艺（若有：用于材质工艺图；缺失则写明无法确认）

### 2. 素材清单

建议记录每张源素材图的信息：

- 文件名
- 图片内容
- 拍摄角度
- 商品状态（是否是折叠后的或者展开后的或者其他什么形态的）
- 背景类型
- 是否包含尺寸/规格信息
- 是否包含材质/工艺信息
- 是否为 `sku-xxx` 类型图片（SKU 参考图）
- 是否为白底图
- 适合生成哪些类型图片时作为参考图（首图、场景图、卖点图、尺寸图、材质工艺图、SKU 图，可重复多写）

### 3. 生成计划

列出本商品最终需要生成的图片类型，并说明跳过原因，例如：

- 跳过尺寸图：素材中无可靠尺寸信息
- 跳过材质工艺图：素材中无可确认的材质细节
- 跳过 SKU 图：仅有单一 SKU

### 4. 已生成产物记录

必须记录：

- 图片类型
- 输出文件名
- 使用的参考图
- 对应 Prompt 摘要或归档位置
- 任务状态

## `AGENTS.md`模板

```md
# Product Analysis

## Product Description
- Product Name (EN): [PRODUCT_NAME]
- Product Name (CN): [PRODUCT_NAME_CN]
- Key Selling Points:
  - [SELLING_POINT_1]
  - [SELLING_POINT_2]
  - [SELLING_POINT_3]
- Specs / Dimensions (inch, confirmed only): [SPECS_IN_INCH_OR_NA]
- Materials / Craftsmanship (confirmed only): [MATERIALS_OR_NA]

## Source Images
- `image-01.jpg`: front product shot, white background, suitable for main image reference, no size info
- `image-02.jpg`: side angle detail shot, shows zipper material, suitable for material/process image
- `sku-red.jpg`: red SKU image, can be used in SKU image
- `sku-blue.jpg`: blue SKU image, can be used in SKU image

## Generation Plan
- Generate Main Image: yes
- Generate Scene Image: yes
- Generate Selling Point Image: yes
- Generate Size Image: no, no reliable dimensions found
- Generate Material / Process Image: yes
- Generate SKU Image: yes

## Task Status
- Overall Status: in_progress
- Last Run At: [YYYY-MM-DD HH:mm:ss]
- Skip Reason: [N/A or reason]
- Failure Reason: [N/A or reason]

## Generated Outputs
- Scene Image: `gen-scene-01.png` | refs: `image-01.jpg` | status: submitted
- Selling Point Image: `gen-selling-point-01.png` | refs: `image-02.jpg` | status: submitted
```

## 图片类型生图提示词规则

### 1. 首图

首图为必做项，但首图需要放在最后来生成，因为可以将生成好的场景图/细节图等加入到生成首图的参考图中来生成首图。
首图为一张组合图片，包含产品主体的白底图，场景图，卖点图、尺寸图、材质工艺图、多SKU图等组合到一个画面里，对排版要求较高，产品主体的白底图占画面里最大的比重。

要求：

- 主体占画面约 `80%`
- 左侧最大区域展示包含 Logo 的产品主体
- 若存在多个 SKU，可在底部展示其他 SKU 商品图
- 右侧三个圆形小图约占画面 `20%`，展示使用场景、卖点、尺寸、材质或 SKU 细节图
- 首图不带文案
- Logo 必须合成到产品可印刷区域
- 比例 `1:1`
- 生成首图时必须把指定 Logo 文件作为参考图
- 如果商品存在多个 SKU，底部可展示其他 SKU；如果只有单 SKU，则不展示额外 SKU。

Logo 文件：

- `<skill_path>/asserts/LOGO-BK.png`：浅色产品或浅色可印刷区域
- `<skill_path>/asserts/LOGO-WT.png`：深色产品或深色可印刷区域

Logo 规则：需要 Logo 时，以指定 Logo 文件为准；参考图 Logo 与指定文件不同时，以指定文件为准。Prompt 只说明使用指定 Logo 文件，不描述 Logo 外观。

### 2. 场景图

可生成多张。

要求：

- 展示产品在真实环境中的使用效果
- 场景必须贴合实际用途
- professional, beautiful, high-converting Amazon-style ecommerce lifestyle poster design
- clean premium layout, attractive lighting, strong visual hierarchy, polished commercial composition
- 默认不加 Logo；如需展示印刷效果，以指定 Logo 文件为准
- 比例 `1:1`

### 3. 卖点图

可生成多张。

要求：

- 展示产品主要用途或核心卖点
- professional, beautiful, high-converting Amazon-style ecommerce selling point poster design
- clean premium layout, modern English typography, strong visual hierarchy, polished commercial composition
- 一张图只讲一个利益点，多个卖点可生成多张图片
- 默认不加 Logo；如需展示印刷效果，以指定 Logo 文件为准
- 比例 `1:1`

### 4. 尺寸图

只有在素材中存在可靠尺寸或规格信息时才生成。

要求：

- 必须先识别素材中的真实规格数据
- 单位必须统一转换为 `inch`
- 必须选择一张白底产品图作为参考图
- 版式必须以产品主体和尺寸标注为核心
- 文案仅允许使用尺寸信息，不要额外营销文案
- 默认不加 Logo；如需展示印刷效果，以指定 Logo 文件为准
- 比例 `1:1`

如果缺少可靠尺寸信息，或者没有可用白底产品图，则直接跳过尺寸图。

标注规则：

- 根据产品实际情况使用 `Height` / `Width` / `Length` / `Depth` / `Diameter`
- 不允许编造尺寸
- 尺寸值必须写成 `xx inch`

如果原始尺寸来源不清晰、数值不完整、单位不明确，则跳过尺寸图。

### 5. 材质工艺图

只有在素材能准确体现材质或工艺时才生成。

要求：

- 展示材质细节、表面纹理、缝线、印刷、金属件、织带、拉链、包边等真实工艺信息
- professional, beautiful, high-converting Amazon-style ecommerce material/detail poster design
- clean premium layout, close-up detail emphasis, attractive lighting, polished commercial composition
- 若素材中有明确材质描述，则必须准确写出材质英文说明
- 不能猜测材质
- 默认不加 Logo；如需展示印刷效果，以指定 Logo 文件为准
- 比例 `1:1`

### 6. SKU 图

只有在存在多个颜色或多个款式时才生成，可生成多张。

SKU 识别规则：

- 若文件名包含 `sku-xxx.jpg`，则该图视为 SKU 图
- `xxx` 可作为颜色名或款式名的候选来源
- 若素材中明显存在多个颜色或款式，也可纳入 SKU 图
- 禁止添加素材中不存在的 SKU

生成规则：

- 使用整齐宫格排版
- professional, beautiful, high-converting Amazon-style ecommerce SKU chart design
- clean premium layout, balanced spacing, modern English typography
- 不要出现网格线
- 单张 SKU 图中最多展示 `9` 个 SKU
- 如果 SKU 数量大于 `9`，则按每 `9` 个一组拆分，生成多张不同的 SKU 图
- 每个 SKU 需标注英文颜色名或规格名，且标签位置保持统一
- 默认不加 Logo；如需展示印刷效果，以指定 Logo 文件为准
- 比例 `1:1`

若某商品有超过 `9` 个 SKU：

1. 按 `9` 个 SKU 为一组进行拆分。
2. 每组生成一张独立 SKU 图。
3. 保证每个 SKU 至少出现一次。
4. 同一张 SKU 图中不要重复展示同一 SKU。

示例：

- `1-9` 号 SKU -> `sku-sheet-01`
- `10-18` 号 SKU -> `sku-sheet-02`
- `19-27` 号 SKU -> `sku-sheet-03`

## 搜索参考案例的方法

在为当前商品写任何英文 Prompt 之前，必须先联网搜索一次 Amazon / 北美电商图片案例,优化生图提示词。例如：

- `Best Amazon [product name] listing Prompt`
- `How to write prompt of Amazon main image`
- `Amazon [CATEGORY_KEYWORD] main image examples`

## 提示词编写原则

每张图的提示词都必须为英文，并且必须包含以下约束：

1. 开头明确图片类型，并正确表达为电商图片/电商海报图/电商信息图。
2. Prompt 必须明确加入：`professional, beautiful, high-converting Amazon-style ecommerce image, clean premium layout, strong visual hierarchy, attractive lighting, polished commercial poster design, modern typography`。
3. 必须明确：生成结果中的商品必须参考图上的商品，保证商品细节 `100%` 一致（形状、结构、材质、纹理、配件、接口、开孔、走线、缝线、比例等），不允许任何细节变化或重设计。
4. 必须明确是否需要英文文案。
5. 必须明确 Logo 规则：需要 Logo 时，以指定 Logo 文件为准。
6. 必须明确输出风格为专业、高转化、好看的北美电商图片 / Amazon-style ecommerce image。
7. 必须明确要求比例为 `1:1`。
8. 必须注入统一硬约束：禁止中文、价格、水印、二维码、厂家信息、厂商名称、供应商信息、平台信息、联系方式、网址、虚构信息；需要 Logo 时以指定 Logo 文件为准。
9. 禁止使用脚本、图像处理代码、透视贴图、局部覆盖、程序合成等方式人为拼接或合成最终图片；所有最终交付图片必须通过生图 skill / 生图能力直接生成。
10. 当需要优化图片、编辑图片、修正图片、不满意重做时，必须通过“调整提示词 + 使用生图 skill 重新生成图片”的方式处理，禁止通过脚本或程序局部修改已有图片。

## Prompt 硬约束句

以下约束句必须强制注入到每张图时。

### 通用核心约束

```text
Product must be 100% identical to reference in all details (shape, texture, parts). When a logo is required, follow the specified logo file. No Chinese, no QR codes, no watermarks, no manufacturer information, no supplier information, no platform marks, no contact information, no website URLs, no price info. All text in English. Do not invent unsupported details. Ratio 1:1.
```

说明：

- 首图必须最后生成，以便在构图时综合商品主体、SKU 情况、场景、卖点、尺寸、材质和可展示细节
- 除首图外，其他图片允许在同一商品内按异步方式批量发起任务
- 不满足条件的图片类型直接跳过
- 同一类型如果条件成立且有必要，可以生成多张
- 使用 webSearch 搜索，优化prompt。

## 输出要求

1. 已生成的图片上传到飞书多维表格对应记录的“商品主图”字段中。
2. 已生成的图片通过飞书 `message` 上传并发给用户。

## 禁止事项

- 禁止在未写 `AGENTS.md` 之前直接生图
- 禁止使用中文 Prompt
- 禁止在无参考图的情况下调用生图
- 禁止为凑图而生成不成立的图片类型
- 禁止使用脚本、图像处理代码、透视贴图、局部覆盖、程序合成等方式拼接最终交付图
- 禁止把“优化/编辑/修正图片”实现为程序化局部修改；此类需求只能通过调整提示词后重新生图
- 禁止为 SKU 图新增不存在的颜色或款式
- 禁止在无可靠尺寸信息时生成尺寸图
- 需要 Logo 时，以指定 Logo 文件为准
- 禁止编造材质、功能、结构、规格
- 禁止把历史生成结果图误当作源素材图再次参与分析

## 最终原则

你的唯一目标是：**为指定商品文件夹执行产品主图生成的工作流。**

生成好的图片请通过message把文件上传并主动发给用户，生成好的图片默认是需要上传到飞书多维表格对应的`产品编号`的`白底图`与`产品主图`字段（`产品主图`包含首图、场景图、卖点图、多SKU图、尺寸示意图、材质工艺图等除了白底图以外的图片），不要传错，不要忽视上传。

请参考 `## 生成商品套图工作流程` 中说明的工作流程开始你的工作。遇到问题请直接询问用户。
