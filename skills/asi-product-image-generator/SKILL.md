---
name: asi-product-image-generator
description: Generate ASI product image sets(首图、场景图、卖点图、尺寸图、材质工艺图、SKU图) or a specified product main image. Launch when 用户说生成asi电商套图、生成主图、生成场景图、生成卖点图、生成多SKU图、生成尺寸示意图、生成印刷效果图、生成材质工艺图，or requests product image generation, main image generation, or product profile image generation.
---

# asi-product-image-generator

## 目标

面向北美促销礼品经销商业务，为指定的商品生成电商套图，并把结果写回 `商品主图` 字段。所有后续商品生图任务都必须派生 subagent 执行；主会话只做编排、验收、发送和状态记录，不直接替代 subagent 生图。派生的 subagent 必须先阅读本 skill，并同时阅读当前环境可用的生图 skill，按生图 skill 的当前说明选择生图能力，并使用当前最新、最适合商品图的生图模型生成图片。不要在本 skill 中写死具体生图服务作为唯一执行方式；如生图 skill 的推荐模型、参考图传参方式、输出路径参数或失败处理方式发生变化，以当次读取到的生图 skill、帮助说明和当前配置为准。若任务有多个产品需要生成图片，必须串行派生 subagent：每次只能派生一个 subagent，等待该 subagent 完成、明确阻塞或需要恢复后，才允许派生下一个；每个 subagent 只能处理一个产品，并必须阅读本 skill。不要用批处理脚本代替 subagent 执行商品生图任务；脚本最多只能在用户明确同意时用于低风险状态汇总，不能作为生成、上传商品图的主执行方式。严禁用脚本、图像处理代码、贴图、局部覆盖、透视变换、程序拼接或程序合成来生成、修正或补救最终交付图片；尤其禁止用脚本把 Logo 合成、贴到、覆盖到商品图片上。Logo 必须作为参考图输入生图能力，让生图能力重新生成自然、完整、可商用的图片。所有生成好的最终图片都必须回复用户并发送给用户；上传到飞书字段不等于交付给用户。任务未完成时必须持续推进，直到每个请求的商品图都生成、发送、按需上传并核验完成，或明确报告具体阻塞。

**注意：**
以下 base-token、table-id、view-id、field-id 均为示例值，请根据实际情况替换成实际值，先读取表结构，再思考下一步。
请回复用户，充分与用户沟通，例如说明你的思考步骤、计划、生图提示词内容、参考图选择决策、生图 skill 的选择等。

生成图片时，使用合适的生图 skill 生成图片，传入参考图，编写生图指令。每次调用必须传入产品参考图与英文提示词。生成任何白底图或 ASI 套图之前，必须先把 `参考图片` 字段里的原始商品图作为输入，生成一张去除产品上原有 logo、sample logo、品牌图案、示例印刷和平台/厂家标记的干净商品参考图；生成后必须把这张干净无 logo 参考图上传回当前记录的 `参考图片` 字段，并替换掉原先 `参考图片` 字段里的原始图片，回读确认 `参考图片` 字段只保留干净无 logo 参考图后，才能继续生成白底图和 ASI 套图。后续白底图、首图、场景图、卖点图、尺寸图、材质工艺图和 SKU 图都必须基于这张已回填到 `参考图片` 字段的干净无 logo 参考图继续生成，不能直接用 `参考图片` 字段里的原始图片生成 ASI 套图。你必须合理选择参考图以及设计提示词，建议 `1-3` 张白底图或除了有产品以外比较干净的图，如果是生成多 SKU 图可以传入 9 张参考图。若确因生图 skill 的参考图数量限制需要整理参考素材，只允许把多张参考图整理成“参考用 contact sheet”并压缩到 3MB 以内；该 contact sheet 只能作为生图参考输入，绝不能作为最终图、半成品图、Logo 贴图底稿或程序合成结果。当产品是可以拆卸或者可折叠时，并且你希望生成的图片是展示拆卸后或折叠后的图，请你选择对应的参考图（例如可拆卸的参考图和可折叠的参考图），然后在提示词里面明确指出参考 xxx 图的产品拆卸/折叠方式，生成 xxx 图。总之你必须决定要生成什么样的图片，提示词怎么写，使用哪些参考图，提示词里如何强化怎么参考提供的参考图。如果遇到问题，立马停止，并告诉我问题在哪里，由我选择下一步方案。

以下图片类型均属于`商品主图`的图片类型：

- 首图：通常作为商品在线上展示的第一张图片
- 场景图：商品在场景里包含卖点的图
- 卖点图：商品的卖点图海报
- 尺寸图：商品的长宽高标识示意图
- 材质工艺图：展示材质和印刷工艺等细节
- SKU 图：展示多个不同的颜色和规格整合在一张图中（通常一张 SKU 图不超过 9 宫格的布局，可多生成几张不同的 SKU 图来覆盖所有 SKU）

`商品表` 是以 `产品编号` 为记录的索引（如果有 `record_id` 也可以作为索引），获取 `参考图片`、`白底图` 字段的附件作为参考图并下载到本地（按产品分文件夹分类好，避免文件交叉）。每个商品必须先在 workspace 的 `temp/` 目录下创建专用临时目录，用于存放参考图、白底图、生成图和上传记录；目录名必须包含产品编号，建议格式为 `temp/<产品编号>_asi_<record_id>/`。生成后的主图/套图需传入到 `商品主图` 附件字段里。

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
5. 需要 Logo 时，以指定 Logo 文件为准。首图必须带 Logo，并且生成首图时必须把指定 Logo 文件作为参考图。如果参考图原本有 logo、sample logo、示例印刷、品牌字样或平台/厂商标识，首图必须用指定 Logo 文件替换这些原有标记；不得保留、复刻、叠加或并存参考图原有 logo/印刷。生成首图的英文 Prompt 必须明确写出实际使用的 Logo 文件名，并加入类似 `Use LOGO-BK.png logo file and print it on the printable area of the main product in the hero image.` 的指令；如果选择白色 Logo，则必须把文件名相应写成 `LOGO-WT.png`。其他图默认不加 Logo。首图的Logo实际上是一个logo示意图，即logo是带有`YOUR LOGO`字样的一个logo，文字`YOUR LOGO`不能省略（需要写进生图prompt里），公司名是`LogoPress`
6. 不允许虚构素材中不存在的颜色、款式、结构、尺寸、材质、功能、接口、配件或 SKU。
7. 不写兼容逻辑，不写回退逻辑；不满足条件的图片类型直接跳过。
8. 每张图片的 Prompt 都必须明确要求输出比例为 `1:1`。
9. 每次生图时必须传入至少一张参考图。不要交叉生图，分清楚每个产品需要使用独立的生图提示词和对应的参考图，不可以混淆。
10. 最终交付图片必须是生图 skill 根据参考图和 Prompt 直接生成的完整图片；禁止用脚本、图像处理代码、贴图、局部覆盖、透视变换、程序拼接、程序合成来生成或修正最终图。Logo 修正也必须重新生图：把指定 Logo 文件作为参考图加入输入，调整 Prompt 后重新生成，禁止脚本贴 Logo 或程序合成 Logo。

### Prompt 视觉质量硬要求

以下要求必须写进每张生图 Prompt（尺寸图除外，尺寸图以清晰准确为第一优先）：

- 图片必须是 professional, beautiful, high-converting Amazon-style ecommerce image。
- 画面必须有 clean premium layout、strong visual hierarchy、balanced spacing、attractive lighting、polished commercial poster design、modern typography。
- 场景图、卖点图、材质工艺图、SKU 图必须体现专业电商主图/电商海报级设计感，不能像普通随手照片、低质拼图或简单截图。
- 所有设计优化不得改变产品真实结构、颜色、材质、配件、尺寸或已确认信息。

### 源素材图（参考图）

源素材图是指飞书多维表格的 `商品表` 的 `参考图片`、`白底图` 字段的附件，需要下载到本地。`参考图片` 字段里的原始图片只能用于分析产品真实结构、颜色、材质、SKU，以及生成“去 logo 干净商品参考图”；不得直接作为 ASI 套图、白底图或首图的输入参考。生成干净参考图时必须通过生图 skill 重新生成完整图片，保留产品真实结构、颜色、材质、比例、配件和 SKU，去掉产品上的原有 logo、sample logo、品牌图案、示例印刷、平台/厂家标记、联系方式、网址和二维码；禁止用脚本擦除、局部覆盖、修补、贴图或程序合成。干净参考图建议保存为 `references/<产品编号>_clean_no_logo.png` 或 `outputs/<产品编号>_clean_no_logo.png`，并记录英文 Prompt 与生成路径。生成后必须上传到当前记录的 `参考图片` 字段并替换原始图片；不要只追加新附件而保留旧原图。完成替换后必须回读 `参考图片` 字段，确认旧原图已移除、字段内保留的是干净无 logo 参考图。如果 `白底图` 没有文件，则还需阅读 `generate-white-background` skill，先基于干净无 logo 参考图为该商品生成白底图（如果有多个颜色，每个颜色都需要生成一张白底图）。用户可能会直接发送图片给你，向用户确认该图片对应的“产品编号”，同样可以视为原始参考图，但仍需先生成干净无 logo 参考图、替换回 `参考图片` 字段后再继续套图。

## 商品专用临时目录

在处理任何商品之前，必须先创建商品专用临时目录：

```text
<workspace>/temp/<产品编号>_asi_<record_id>/
```

该目录用于集中保存：

- `references/`：从飞书下载的参考图、白底图、Logo 辅助参考等
- `outputs/`：所有生成结果
- `uploads/`：上传回飞书后的响应记录

生图前必须先确认当前商品的产品信息、素材用途、生成计划与跳过原因。生成过程中的提示词、输出文件和上传响应要保存在当前商品目录内，便于后续复核。

## 生图 skill 使用要求

生成图片前，当前商品 subagent 必须先阅读本 skill，并阅读当前环境可用的生图 skill。subagent 必须按生图 skill 的最新说明选择生图能力，并使用当前最新、最适合商品图的生图模型生成图片；不要在本 skill 中写死具体服务作为唯一方式。若生图 skill、帮助说明或当前配置中给出了推荐顺序、最新模型、参考图传参方式、输出路径参数或失败处理方式，以当次读取到的信息为准。若生图能力出现异常失败，等待 1 小时后再重试生图，不要原地快速重复失败调用。

派发商品图 subagent 时，handoff 必须明确要求 subagent 在 Oracle ChatGPT、Oracle Gemini、Codex 生图三种路径之间交替使用；不要长期依赖单一路径。每张图都要记录实际使用的路径。如果其中一个路径遇到额度、登录、模型不可用、页面异常、网络异常或参考图支持问题，应先切换到其他可用路径尝试，并记录具体失败证据，再判断是否需要等待或恢复。使用 Oracle 时仍须一次只运行一个 Oracle 生图实例。

每张图必须使用当前商品独立的参考图与英文 Prompt，并将输出保存到当前商品 `outputs/` 目录。每次生图必须显式传入产品参考图；首图需要 Logo 时，还必须把指定 Logo 文件作为参考图传入生图 skill。

派生 subagent 执行 ASI/电商套图任务时，handoff 必须明确要求：

- 只处理一个指定产品，不处理其他产品。
- 必须阅读本 skill 和当前可用的生图 skill。
- 必须使用生图 skill 指定或推荐的生图能力，并选择当前最新、最适合商品图的生图模型。
- 必须先生成一张干净无 logo 商品参考图：使用 `参考图片` 字段原始图作为输入，去除产品上的原有 logo、sample logo、品牌图案、示例印刷和平台/厂家标记；生成后上传到当前记录的 `参考图片` 字段并替换掉原先的原始图片，回读确认旧原图已移除；后续白底图和 ASI 套图只能基于这张已回填的干净参考图继续生成，不能直接用原始 `参考图片` 生成套图。
- 必须明确允许并要求在 Oracle ChatGPT、Oracle Gemini、Codex 生图三种路径之间交替使用；不要只使用单一路径，并记录每张图实际使用的路径。
- 若生图能力出现异常失败，等待 1 小时后再重试生图，不要原地快速重复失败调用。
- 不得用脚本、图像处理代码、贴图、局部覆盖、透视变换、程序拼接或程序合成来生成、修正或补救最终交付图片。
- Logo 修正也必须重新使用生图 skill：把指定 Logo 文件作为参考图加入输入，调整英文 Prompt 后重新生成；禁止脚本贴 Logo、覆盖 Logo、擦除 Logo、局部修补 Logo 或把 Logo 程序合成到产品图上。

主会话每次只能派生一个商品生图 subagent，并监督它完成、阻塞或恢复后再派生下一个，严禁同时派生多个商品生图 subagent。

## 生成商品套图工作流程

当前商品必须按以下主链路执行：

1. 创建当前商品专用临时目录：`<workspace>/temp/<产品编号>_asi_<record_id>/`，并创建 `references/`、`outputs/`、`uploads/` 子目录。
2. 下载当前商品的全部源素材图（从飞书多维表格下载下来的参考图、白底图，或用户提供的图片）到该目录的 `references/`。
3. 先生成当前商品的干净无 logo 商品参考图：原始 `参考图片` 只作为这一步的输入，英文 Prompt 必须要求 remove any existing logo, sample logo, brand mark, imprint, manufacturer/platform mark, QR code, watermark, contact information, and URL from the product while preserving the exact real product structure, color, material, proportions, accessories, and SKU details. 保存输出、Prompt 与路径。
4. 将干净无 logo 商品参考图上传到当前记录的 `参考图片` 字段，并移除该字段里原先的原始图片；不要只追加导致新旧参考图并存。完成后回读 `参考图片` 字段，确认字段内保留的是干净无 logo 参考图，并保存上传、移除和回读记录。
5. 检查`白底图` 字段有没有文件，白底图是重要的参考图，如果 `白底图` 字段没有文件，必须先阅读 `generate-white-background` skill，并先基于干净无 logo 参考图为该商品生成白底图、上传回 `白底图` 字段，再使用白底图和干净参考图继续生成其他图片。如果有多个SKU，每个SKU都需要生成一张白底图。
6. 分析每张图片的内容、角度、背景、是否含尺寸信息、是否含材质信息、是否为 SKU 图、是否适合作为白底参考图、是否适合作为主图参考图；分析可查看原始 `参考图片`，但实际套图生图输入必须使用干净无 logo 参考图、白底图、已生成图和指定 Logo 文件。
7. 确认当前商品的产品描述、素材清单、干净参考图路径、`参考图片` 字段替换回读结果、参考图映射、生成计划与跳过原因。
8. 按图片类型规则判断当前商品需要生成哪些图。
9. 为每一张待生成图片单独编写英文 Prompt（可使用webSearch搜索类似产品的文案参考案例）。
10. 先生成场景图、卖点图、尺寸图、材质工艺图、SKU 图等；首图必须最后生成，并使用干净无 logo 参考图、白底图、已生成的场景/卖点/材质/功能图以及 Logo 文件作为参考。SKU 图仅可作为判断底部 SKU 展示的辅助参考，不得作为首图右侧小图；尺寸图只能作为独立图片，不作为首图构图元素。
11. 当前商品完成后，update_plan 中记录任务状态、已生成文件、Prompt 记录与跳过原因。

## 商品内调用规则

对当前商品文件夹，严格按以下方式发起生图任务：

1. 每张图都必须单独编写英文 Prompt，不可以使用一个 prompt 来生成多个不同类型的图片。
2. 每张图的 Prompt 都必须明确要求：完全参考参考图上的商品，且图片比例是 `1:1`。

## 图片类型生图提示词规则

### 1. 首图

首图为必做项，但首图需要放在最后来生成，因为可以将生成好的场景图、细节图、功能图等加入到生成首图的参考图中来生成首图。
首图为一张组合图片，包含产品主体的白底图，并可根据素材情况加入最多三个右侧小图；小图只能展示场景图、细节图、功能图或卖点图。多 SKU 只能在底部作为商品颜色/款式小图展示，不能作为右侧小图。首图不得包含尺寸图或尺寸示意。

要求：

- 主体占画面约 `80%`
- 左侧最大区域展示包含 Logo 的产品主体
- 若存在多个 SKU，可在底部展示其他 SKU 商品图
- 右侧最多三个圆形小图，整体约占画面 `20%` 以内；小图可以展示使用场景、产品细节、功能图或卖点图
- 如果可用的场景/细节/功能素材不足，右侧小图可以少于三个，甚至不展示
- 右侧小图不得展示多 SKU 图、SKU 色卡、尺寸图、尺寸线、尺寸数字或尺寸示意
- 首图不带文案；除产品本身可见信息和通过生图自然生成在产品可印刷区域上的 Logo 示意外，不出现任何额外文字、标题、标签、尺寸数字、尺寸线或尺寸标注
- Logo 必须通过生图 skill 自然生成在产品可印刷区域；禁止用脚本、贴图、局部覆盖、透视变换或程序合成方式把 Logo 放到产品上
- 比例 `1:1`
- 生成首图时必须把指定 Logo 文件作为参考图
- 生成首图的英文 Prompt 必须明确写入实际 Logo 文件名，并说明使用该 Logo 文件印在首图产品主体的可印刷位置上。例如：`Use LOGO-BK.png logo file and print it on the printable area of the main product in the hero image.` 或 `Use LOGO-WT.png logo file and print it on the printable area of the main product in the hero image.`
- 首图必须用指定 Logo 文件替换参考图上的 logo、sample logo、`YOUR LOGO`、示例印刷、品牌字样或平台/厂商标识；不得保留、复刻、叠加或并存参考图原有 logo/印刷。
- 生成首图的英文 Prompt 必须加入同义硬约束：如果参考图商品上有 logo，必须替换成 Logo 图片文件上的 logo，或替换成不含任何图形标记的纯文字 `YOUR LOGO`；不要出现参考图商品本身的 logo 图案。建议英文句：`If the product in the reference image has a logo, replace it with the logo from the logo image file, or with plain text "YOUR LOGO" without any graphic mark; do not show the product's original logo pattern from the reference image.`
- 如果商品存在多个 SKU，底部可展示其他 SKU；如果只有单 SKU，则不展示额外 SKU。
- 如果参考图片上的商品本身印有logo，那也需要替换成logo文件上的logo，而不能使用参考图片商品上面本身的logo。

Logo 文件：

- [黑色logo文件](asserts/LOGO-BK.png)：浅色产品或浅色可印刷区域
- [白色logo文件](asserts/LOGO-WT.png)：深色产品或深色可印刷区域

Logo 规则：需要 Logo 时，以指定 Logo 文件为准；参考图 Logo 与指定文件不同时，以指定文件为准。首图要明确要求“replace any existing/sample logo or imprint in the reference image with the specified LogoPress logo file”。首图 Prompt 必须写出实际 Logo 文件名，例如 `LOGO-BK.png` 或 `LOGO-WT.png`，并说明使用该 Logo 文件印在首图产品主体的可印刷位置上。Prompt 只说明使用指定 Logo 文件，不描述 Logo 外观。

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
5. 必须明确 Logo 规则：需要 Logo 时，以指定 Logo 文件为准；首图 Prompt 必须写出实际 Logo 文件名，并说明使用该 Logo 文件印在首图产品主体的可印刷位置上。首图 Prompt 还必须加入同义硬约束：如果参考图商品上有 logo，必须替换成 Logo 图片文件上的 logo，或替换成不含任何图形标记的纯文字 `YOUR LOGO`；不要出现参考图商品本身的 logo 图案。建议英文句：`If the product in the reference image has a logo, replace it with the logo from the logo image file, or with plain text "YOUR LOGO" without any graphic mark; do not show the product's original logo pattern from the reference image.`
6. 必须明确输出风格为专业、高转化、好看的北美电商图片 / Amazon-style ecommerce image。
7. 必须明确要求比例为 `1:1`。
8. 必须注入统一硬约束：禁止中文、价格、水印、二维码、厂家信息、厂商名称、供应商信息、平台信息、联系方式、网址、虚构信息；需要 Logo 时以指定 Logo 文件为准。
9. 禁止使用脚本、图像处理代码、透视贴图、局部覆盖、程序合成等方式人为拼接或合成最终图片；所有最终交付图片必须通过生图 skill / 生图能力直接生成。
10. 当需要优化图片、编辑图片、修正图片、不满意重做时，必须通过“调整提示词 + 使用生图 skill 重新生成图片”的方式处理，禁止通过脚本或程序局部修改已有图片。
11. 当 Logo 位置、Logo 内容、Logo 质量有问题时，只能把指定 Logo 文件作为参考图，调整英文 Prompt 后重新生图；禁止用脚本贴 Logo、覆盖 Logo、擦除 Logo、局部修补 Logo 或把 Logo 程序合成到产品图上。

## Prompt 硬约束句

以下约束句必须强制注入到每张图时。

### 通用核心约束

```text
Product must be 100% identical to reference in all details (shape, texture, parts). When a logo is required, follow the specified logo file. No Chinese, no QR codes, no watermarks, no manufacturer information, no supplier information, no platform marks, no contact information, no website URLs, no price info. All text in English. Do not invent unsupported details. Ratio 1:1.
```

说明：

- 首图必须最后生成，以便在构图时综合商品主体、SKU 情况、场景、卖点、材质和可展示细节；尺寸示意只用于独立尺寸图，不能放进首图
- 除首图外，其他图片可按生图 skill 的安全能力安排；不得同时启动多个生图实例
- 不满足条件的图片类型直接跳过
- 同一类型如果条件成立且有必要，可以生成多张
- 使用 webSearch 搜索，优化prompt。

## 输出要求

1. 已生成的图片上传到飞书多维表格对应记录的“商品主图”字段中。
2. 已生成的图片通过飞书 `message` 上传并发给用户。

## 禁止事项

- 禁止使用中文 Prompt
- 禁止在无参考图的情况下调用生图
- 禁止为凑图而生成不成立的图片类型
- 禁止使用脚本、图像处理代码、透视贴图、局部覆盖、程序合成等方式拼接最终交付图
- 禁止把“优化/编辑/修正图片”实现为程序化局部修改；此类需求只能通过调整提示词后重新生图
- 禁止用脚本或程序把 Logo 合成、贴到、覆盖到、透视变换到商品图片上；Logo 必须作为参考图参与生图并由生图 skill 重新生成
- 禁止为 SKU 图新增不存在的颜色或款式
- 禁止在无可靠尺寸信息时生成尺寸图
- 需要 Logo 时，以指定 Logo 文件为准
- 禁止编造材质、功能、结构、规格
- 禁止把历史生成结果图误当作源素材图再次参与分析

## 最终原则

你的唯一目标是：**为指定商品文件夹执行产品主图生成的工作流。**

生成好的图片请通过message把文件上传并主动发给用户，生成好的图片默认是需要上传到飞书多维表格对应的`产品编号`的`白底图`与`产品主图`字段（`产品主图`包含首图、场景图、卖点图、多SKU图、尺寸示意图、材质工艺图等除了白底图以外的图片），不要传错，不要忽视上传。

检查任务进度，反复提醒自己记住生图有哪些具体的要求，更新计划时尽可能详细描述任务。

请参考 `## 生成商品套图工作流程` 中说明的工作流程开始你的工作。遇到问题请直接询问用户。
