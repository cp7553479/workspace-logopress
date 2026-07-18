---
name: "inquiry"
description: "合并重复示例，保留询单核心流程"
---

# 新增询单

**注意：**
以下 base-token、table-id、view-id、field-id、record-id、file token、URL 均为示例占位符。执行前先读取实际表结构和工具帮助，不要把示例占位符当成真实值。
如果未声明 base token 或无法准确定位表格，先询问用户。
请回复用户，充分与用户沟通。

## 步骤

1. 先读取飞书多维表格中的关键表字段结构。
2. 识别当前消息发送人：从运行时消息元数据读取 sender name / sender_id / open_id 等信息，用于询单来源判断和业务员归属检索。不要把发送人当成客户，除非消息内容明确说明。
3. 提取询单信息：客户、产品编号、数量、目的地、邮箱、备注，以及其他与关键表字段相关的数据。
4. 补充业务员归属：
   - 若 `询单` 表存在 `业务员`、`Sales`、`Owner` 或类似字段，先根据当前消息发送人的姓名、sender_id/open_id、聊天上下文，到记忆中检索“发送消息的人对应的业务员是谁”。
   - 只在记忆检索结果有可靠对应关系时填写业务员字段；不要在 skill 中硬编码任何发送人到业务员的映射。
   - 若记忆中没有可靠对应关系，或检索结果不确定，不要猜测；可以先新建询单，并用简短问题询问用户“这条询单的业务员是谁？”或“是否需要把业务员填为某某？”
   - 用户确认后，再把业务员回填到同一条询单记录。
5. 询单查重：在 `询单`.`标题` 中搜索包含客户姓名和产品编号关键词的记录；若找到疑似重复记录，询问用户是在旧记录上修改还是新增。
6. 匹配产品：将产品编号（通常是 “LP+数字”）搜索 `商品表`.`产品编号`，取匹配到的第一条记录；未匹配到时询问用户是否要新增产品记录再关联。
7. 匹配客户：搜索 `客户联系人`.`客户邮箱`；未匹配到时在 `客户联系人` 表中新增客户联系人记录，再回填询单的客户姓名。
8. 写入询单记录，只填写当前能确定的字段。
9. 输出结果：record_id + 完整字段表格。
10. 互动式补全询单信息：
    - 写入后读取 `询单` 表字段结构和该询单记录，识别可编辑字段中仍为空、且对报价/生产/发货/客户跟进有价值的字段。
    - 不要一次性追问所有空字段；优先选择 1-3 个最关键、用户最容易补充的问题，例如目的地、交期、印刷内容、包装要求、联系人邮箱、业务员、备注、特殊要求等。
    - 用建议式语气告诉用户“这些信息可以补充，会让询单更完整”，不要把补全作为新建询单或报价的硬性阻塞条件。
    - 用户回复后，将能确定的补充信息更新回同一条询单；仍不清楚的字段保持空白，不要猜测。
11. 判断是否需要进入报价流程：
    - 若询单已明确匹配到产品，并且订货数量/`QTY` 已明确，可以使用 `quotation` skill 生成该询单的报价表 xlsx。
    - 若暂时没有产品或订货数量，可以不用走报价流程；先回复用户已新建/更新询单，并说明后续补齐哪些信息后可继续报价。
12. 报价表生成后，上传并回填报价链接：
    - 优先用 `lark-cli drive +import --type sheet --file <报价表.xlsx> --as user` 将报价 xlsx 转为飞书电子表格。
    - 如果导入为飞书电子表格失败，再用 `lark-cli drive +upload --file <报价表.xlsx> --as user` 上传原文件。
    - 取返回的 `url` 和 token。若返回中没有 `url`，用返回 token 组装或通过 `drive +inspect`/元数据命令确认可打开链接。
    - 上传/导入成功后，尝试将文档链接权限设置为任何获得链接的人可编辑；如企业权限策略禁止该设置，说明权限设置失败并继续发送可用链接或文件。
    - 确认 `询单` 表存在 `报价` 字段；若不存在，创建 URL 文本字段。
    - 将报价链接写入该询单记录，并单独读取该记录的 `标题`、`QTY`、`报价` 字段确认可读回。
13. 最终回复用户：
    - 若已报价：报价表在线链接 + xlsx 文件；如果飞书表格转换失败但原文件上传成功，说明已回退为文件链接。
    - 若未报价：询单记录结果 + 可选的补充信息建议，不发送空报价文件。

## 工具调用模板

所有示例只允许保留占位符。执行时先用 `lark-cli --help`、`lark-cli base --help`、`lark-cli drive --help` 和实际表结构替换占位符。

### 必查帮助

```bash
lark-cli --help
lark-cli base --help
lark-cli drive --help
lark-cli drive permission.public patch --help
```

### 读取 Base 与表结构

```bash
lark-cli base +table-list --base-token <base_token>
lark-cli base +field-list --base-token <base_token> --table-id <table_id>
```

### 记忆检索业务员

```placeholder
memory_search(query="<sender_name_or_open_id> 对应 业务员 询单", corpus="all", maxResults=<max_results>)
```

### 表记录搜索 / 读取

用于询单查重、商品匹配、客户联系人匹配、结果确认。

```bash
lark-cli base +record-search \
  --base-token <base_token> \
  --table-id <table_id> \
  --json '{"keyword":"<keyword>","search_fields":["<field_name>"]}'

lark-cli base +record-get \
  --base-token <base_token> \
  --table-id <table_id> \
  --record-id <record_id>
```

### 新增 / 更新记录

用于新增客户联系人、新增询单、回填业务员、补充询单字段、回填报价链接。

```bash
lark-cli base +record-create \
  --base-token <base_token> \
  --table-id <table_id> \
  --json '{"fields":{"<field_name>":"<field_value>"}}'

lark-cli base +record-update \
  --base-token <base_token> \
  --table-id <table_id> \
  --record-id <record_id> \
  --json '{"fields":{"<field_name>":"<field_value>"}}'
```

常见字段示例：

```json
{
  "询单": {
    "标题": "<inquiry_title>",
    "客户姓名": "<contact_record_link_or_text>",
    "产品": "<product_record_link>",
    "QTY": "<qty>",
    "目的地": "<destination>",
    "<salesperson_field_name>": "<salesperson_value>",
    "备注": "<note>",
    "报价": "<quotation_url>"
  },
  "客户联系人": {
    "客户姓名": "<customer_name>",
    "客户邮箱": "<customer_email>",
    "客户公司": "<customer_company>"
  }
}
```

### 用户沟通

用于业务员不明确、疑似重复询单、产品未匹配、询单补全、最终交付。

```placeholder
message(action="send", message="<summary_or_question>")
message(action="send", attachments=[{"type":"file","media":"<file_path>","name":"<file_name>"}])
```

### 进入报价流程

```bash
# 若 <product_record_id_or_product_number> 和 <qty> 都存在，读取并使用 quotation skill。
sed -n '<start_line>,<end_line>p' <quotation_skill_path>/SKILL.md
# 按 quotation skill 生成报价 xlsx，输出文件路径：<quotation_xlsx_path>
```

### 上传报价表与设置权限

```bash
lark-cli drive +import --type sheet --file <quotation_xlsx_path> --as user
# 若导入失败：
lark-cli drive +upload --file <quotation_xlsx_path> --as user

lark-cli drive +inspect --token <uploaded_file_or_sheet_token> --as user

lark-cli drive permission.public patch \
  --token <uploaded_file_or_sheet_token> \
  --type <drive_file_type> \
  --data '{"link_share_entity":"anyone_editable"}' \
  --as user \
  --yes

lark-cli drive permission.public get \
  --token <uploaded_file_or_sheet_token> \
  --type <drive_file_type> \
  --as user
```

### 创建报价字段

```bash
lark-cli base +field-create \
  --base-token <base_token> \
  --table-id <inquiry_table_id> \
  --json '{"field_name":"报价","type":1,"property":{"formatter":"url"}}'
```

## API 说明

- 使用 `lark-cli base --help` 获取 lark-cli 操作指令，避免猜测指令，所有飞书多维表格操作需要通过 `lark-cli` 工具执行。
- 使用 `lark-cli drive permission.public patch --help` 和 `lark-cli schema drive.permission.public.patch` 确认权限字段；将链接权限改为可编辑时，`link_share_entity` 使用 `anyone_editable`。
- 如遇权限问题可使用 `lark-cli` 的 user access token。
- 使用搜索精准定位记录。
- 业务员归属必须从当前消息发送人信息和记忆检索结果推断；不要在 skill 中硬编码“某发送人=某业务员”。

## 表结构

Base ID: `<base_token>`
- 询单: tableId=`<inquiry_table_id>`, viewId=`<inquiry_view_id>`
- 商品表: tableId=`<product_table_id>`, viewId=`<product_view_id>`, indexFieldName=`产品编号`
- 客户联系人: tableId=`<contact_table_id>`, viewId=`<contact_view_id>`, indexFieldName=`客户邮箱`

## 注意事项

- 不写只读字段。
- 不清楚就暂停任务并询问用户。
- 必须以客户邮箱去 `客户联系人.客户邮箱` 里匹配客户联系人信息；同一个客户公司底下可能有多个客户联系人，但在 `询单.客户姓名` 中需要以客户邮箱匹配到的精准记录。
- `询单`.`标题` 通常包含产品编号和客户姓名。
- 新建或更新询单后，应该根据询单表字段结构和当前记录空字段，主动给出少量补充问题，引导用户完善信息；不要一次问太多，也不要把非关键补全项作为硬性阻塞。
- 若 `询单` 表有业务员相关字段，应先从当前消息发送人信息到记忆中检索对应业务员；检索不到可靠对应关系时，询问用户业务员是谁，用户确认后再回填，不要猜测或硬编码。
- 报价表上传和回填属于 `inquiry` skill 在调用 `quotation` 之后的流程，不要把这个要求写入 `quotation` skill。
- 报价流程一般需要产品和订货数量；若暂时没有，可以不用走报价流程，先完成询单记录，后续补齐后再报价。
- 已生成报价时，最终一定同时给用户报价链接和 xlsx 文件。
- 上传或导入报价文件后，尽量设置链接权限为任何获得链接的人可编辑；如果企业后台、安全标签或文件类型限制导致设置失败，要明确告知用户权限未放开，并继续提供可访问的链接或原文件。
