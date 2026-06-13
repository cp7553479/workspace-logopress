---
name: generate-white-background
description: 在飞书商品线索表里生成并回填商品白底图。Use when 用户要求给某个产品做白底主图、基于参考图生成白底电商主图，或把白底图上传到商品记录的 `白底图` 字段。
---

# Generate White Background

为 `商品线索表` 中的商品生成白底主图，并把结果写回 `白底图` 字段。若有多个产品，可以派生多个subagent分别阅读本skill，然后处理指定产品。

**注意：**
以下 base-token、table-id、view-id、field-id 均为示例值，请根据实际情况替换成实际值，先读取表结构，再思考下一步。
如果未声明base token或无法准确定位表格请直接询问用户。
请回复用户，充分与用户沟通。

## Inputs

1. 商品标识：优先 `产品编号`，也可直接给 `record_id`。
2. 参考图来源：默认读记录里的 `参考图片` 附件字段。
3. 白底图要求：默认使用“纯白背景、专业棚拍灯光、专业电商主图视角、保留产品主体形状与颜色”。
4. 若参考图上带有任何 Logo、品牌字样、印刷图案、二维码、水印、厂家信息、厂商名称、供应商信息、平台信息、联系方式、网址或其他可见标识，生成白底图时必须移除这些标识，只保留产品本体，不要把参考图上的 logo/印刷/二维码/水印/厂家信息一起保留下来。
5. 生图提示词必须明确要求：No QR codes, no watermarks, no manufacturer information, no supplier information, no platform marks, no contact information, no website URLs, no extra logos.
6. 必须严格按照本 skill 的要求执行，**以生成图片的质量与最终效果为优先目标**，不得为了“尽快完成任务”而擅自改用偏离要求的替代方案、降级方案或违规兜底方案。
7. 禁止使用脚本、图像处理代码、抠图后再贴回、局部覆盖、程序合成等方式生成最终白底图；必须使用生图 skill / 生图能力直接生成最终白底图。
8. 当需要优化白底图、编辑白底图、去除残留 logo/印刷/二维码/水印/厂家信息、修正边缘或重做白底图时，必须通过“调整提示词 + 使用生图 skill 重新生成图片”的方式处理，禁止对已有图片做程序化局部修改。
9. 如果当前环境的生图能力不可用、输出质量达不到要求、参考图存在问题、字段状态异常，或执行过程中出现任何会影响结果质量与合规性的阻塞，必须**第一时间明确汇报给用户**，说明问题发生在哪一步、会造成什么影响，以及当前推荐的下一步处理方式；不要静默降级，更不要擅自硬做出一个不符合要求的结果。

## Output

1. 本地下载的参考图文件。
2. 使用生图工具/技能生成的白底图文件，或明确的阻塞说明。
3. 已回填到 Base `白底图` 字段的附件记录。

## Process

### 1. 先读真实字段结构

- Base Token: `<your base token>`
- Table ID: `<your table id>`

先执行：

```bash
lark-cli base +field-list \
  --base-token <your base token> \
  --table-id <your table id> \
  --offset 0 \
  --limit 200
```

确认至少存在这些字段：

- `产品编号`
- `参考图片`
- `白底图`

只按真实字段名操作，不要猜字段。

### 2. 定位目标记录

若用户提供 `record_id`，直接使用。

若用户提供 `产品编号`，先查询记录；优先用 `+data-query` 或 `+record-search` 找到唯一记录，再取出 `record_id`。

目标不唯一时，先把候选记录列给用户确认，不要误上传到错误商品。

### 3. 先检查 `白底图` 字段是否已有附件

在真正生成前，先读取目标记录，确认 `白底图` 字段当前是否已经有附件。

若 `白底图` 已有附件，不要直接继续生成；先询问用户要哪一种处理方式：

- 继续生成并新增一张
- 继续生成并覆盖当前白底图
- 跳过本次生成

用户未明确前，不要擅自新增或覆盖。

### 4. 不要只依赖 `+record-get` 的简化输出

要读取 **原始 Bitable record API**，因为 Base 附件下载所需的 `extra.bitablePerm` 是从原始响应里拿到的。

示例：

```bash
lark-cli api GET \
  /open-apis/bitable/v1/apps/<your base token>/tables/<your table id>/records/<record_id> \
  --as user
```

从返回的 `fields.参考图片[0]` 里提取：

- `file_token`
- `name`
- `url`
- `tmp_url`
- `extra`（通常藏在 `url` / `tmp_url` 的 query 里）

重点：Base 附件的下载经常需要

```json
{"bitablePerm":{"tableId":"<your table id>","rev":<rev>}}
```

### 5. 下载参考图时，带上 `extra.bitablePerm`

不要默认只用：

- `lark-cli docs +media-download --token ...`
- `lark-cli drive +download --file-token ...`

这两条在 Base 附件场景下可能因为缺少 `extra.bitablePerm` 直接返回 `HTTP 400`。

优先用原始接口下载：

```bash
lark-cli api GET /open-apis/drive/v1/medias/<file_token>/download \
  --as user \
  --params '{"extra":"{"bitablePerm":{"tableId":"<your table id>","rev":<rev>}}"}' \
  --output <workspace>/.temp/<产品编号>_asi_<record_id>/reference.jpg
```

或先取临时下载链接：

```bash
lark-cli api GET /open-apis/drive/v1/medias/batch_get_tmp_download_url \
  --as user \
  --params '{"file_tokens":"<file_token>","extra":"{"bitablePerm":{"tableId":"<your table id>","rev":<rev>}}"}'
```

注意：`rev` 以当前原始 record 返回值为准，不要硬编码旧值。

### 6. 使用合适的生图工具/技能生成白底图

生成白底图时，使用合适的生图工具/技能生成图片，传入参考图，编写生图指令。

生图指令必须写清楚：

- 输入参考图本地路径
- 输出到 `<workspace>/.temp/<产品编号>_asi_<record_id>`
- 纯白背景
- 专业棚拍灯光
- 专业电商主图视角
- 保留主体形状与颜色
- 移除参考图里的 Logo、品牌字样、印刷图案、二维码、水印、厂家信息、厂商名称、供应商信息、平台信息、联系方式、网址或其他可见标识
- 明确写入英文禁止项：No QR codes, no watermarks, no manufacturer information, no supplier information, no platform marks, no contact information, no website URLs, no extra logos.
- 输出最终文件路径

如果当前环境的生图工具/技能不可用、无法真实产出图片文件，或输出质量不达标，必须明确告诉用户阻塞点，不要伪造结果。

### 7. 验证输出文件

在声称完成前，至少检查：

- 文件存在
- 能被 `file` 命令识别为图片
- 路径明确

例如：

```bash
file <workspace>/.temp/<产品编号>_asi_<record_id>/output.jpg
ls -l <workspace>/.temp/<产品编号>_asi_<record_id>/output.jpg
```

### 8. 上传到 `白底图` 字段

`白底图` 是附件字段，必须走附件上传链路。

不要用 `record-upsert` 伪造附件值；使用：

```bash
cd /<workspace>/.temp/<产品编号>_asi_<record_id> && \
lark-cli base +record-upload-attachment \
  --base-token <your base token> \
  --table-id <your table id> \
  --record-id <record_id> \
  --field-id "白底图" \
  --file ./output.jpg \
  --name output.jpg
```

注意：`lark-cli` 对 `--file` 有路径限制。若报 unsafe path，先 `cd` 到文件所在目录，再用相对路径上传。

### 9. 通过 `message` 把白底图发给用户，并上传到多维表格

白底图生成后，要做两件事：

1. 通过 `message` 把图片文件发给用户
2. 通过 `+record-upload-attachment` 上传到 Base `白底图` 字段

`message` 示例：

```json
{
  "action": "send",
  "channel": "feishu",
  "target": "<user_or_chat_target>",
  "media": "<white_background_image_path>",
  "message": "白底图已生成，先发你确认。",
  "replyTo": "<message_id_if_needed>"
}
```

回复用户时，至少说明：

- 用的是哪条记录
- 参考图是否下载成功
- 生图工具/技能是否成功产出
- 图片是否已通过 `message` 发给用户
- `白底图` 是否上传成功
- 若失败，失败点在哪一步

## Examples

### Example 1

用户说：`给这个商品生成白底图，并写回飞书`。

执行思路：

1. `+field-list` 确认 `参考图片` 与 `白底图`。
2. 通过产品编号或 `record_id` 定位目标记录。
3. 先检查 record 当前 `白底图` 是否已有附件；若已有，先问用户是新增、覆盖还是跳过。
4. 读取原始 Bitable record，提取 `file_token + extra.bitablePerm`。
5. 下载参考图到本地目录。
6. 使用合适的生图工具/技能生成白底图，传入参考图，编写生图指令。
7. 用 `message` 把白底图图片文件发给用户。
8. 用 `+record-upload-attachment` 上传到 `白底图`。

## Troubleshooting

### `docs +media-download` 或 `drive +download` 返回 HTTP 400

原因：大概率缺少 Base 附件必需的 `extra.bitablePerm`。

处理：改为读取原始 Bitable record 响应中的 `url` / `tmp_url`，提取 `extra` 后再调用原始下载接口。

### `+record-upload-attachment` 报 unsafe file path

原因：`--file` 传了绝对路径。

处理：先 `cd` 到目标目录，再传 `./filename`。


## Reference

- 当前表：`商品线索表`
- Base Token: `<your base token>`
- Table ID: `<your table id>`
- 附件下载关键经验：**Base 原始 record 响应比 `+record-get` 更完整，`extra.bitablePerm` 要从这里取。**
