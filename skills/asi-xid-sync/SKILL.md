---
name: "asi-xid-sync"
description: "从Excel/CSV按Product_Number回填ASI商品表XID和Prod_Image"
---

# ASI XID Sync

本 skill 用于把 ASI/ESP 上传结果文件中的 `XID` 和可选 `Prod_Image` 同步回飞书多维表格中的 `ASI商品表`。它只描述可复用流程，不硬编码 base token、table id、字段 id、文件路径或用户本地目录。

## 输入

用户应提供一个 Excel/CSV 文件，文件表头至少包含：

- `Product_Number`
- `XID`

文件也可能包含：

- `Prod_Image`
- 其他上传平台返回字段

如果用户没有提供文件路径或附件，先请用户发送 Excel/CSV 文件，或提供本地文件路径。不要猜测文件位置。

## 目标表

目标表是飞书多维表格里的 `ASI商品表`，不是 `商品表`。

如果不知道 `ASI商品表` 的 table id，必须先列出目标 Base 中所有表，按表名确认 `ASI商品表`，再读取该表字段结构。不要把 `商品表` 当成目标表。

## 工作流程

1. 确认输入文件存在且可读取。
2. 读取 Excel/CSV 表头，确认至少存在 `Product_Number` 和 `XID`。
3. 若存在 `Prod_Image`，将其纳入待回填字段；若不存在，只回填 `XID`。
4. 定位目标 Base：
   - 如果用户给了 Base URL 或 base token，从中解析或使用该 token。
   - 如果当前工作区有明确默认 Base，可使用当前工作区约定的 Base；但 skill 本身不得写死具体值。
   - 如果无法确定 Base，询问用户要操作哪个 Base。
5. 定位目标表：
   - 若已知 `ASI商品表` table id，可使用它。
   - 若未知，列出 Base 内所有表，找到表名严格等于 `ASI商品表` 的表。
6. 读取 `ASI商品表` 字段结构，确认存在：
   - `Product_Number`
   - `XID`
   - 若源文件包含 `Prod_Image`，确认表里也有 `Prod_Image` 字段。
7. 读取 `ASI商品表` 记录，建立 `Product_Number -> record_id` 映射。
8. 将源文件每一行按 `Product_Number` 匹配目标记录。
9. 只更新匹配成功且有可写字段值的记录：
   - `XID` 写入源文件对应行的 `XID`。
   - 若同时存在并可写，`Prod_Image` 写入源文件对应行的 `Prod_Image`。
10. 写入前做数据清洗：
    - 去除表头和字段值两端空白。
    - 跳过空 `Product_Number` 行。
    - 跳过空 `XID`，除非用户明确要求清空已有 XID。
    - 对重复 `Product_Number` 做记录，并优先停止让用户确认，或在用户明确同意时按最后一行覆盖。
11. 批量更新时使用支持每条记录不同字段值的写入方式，例如 Bitable 原始 `records/batch_update` API；不要使用只能把同一个 patch 应用于多条记录的命令来写不同 XID。
12. 写入应按平台限制分批，并串行执行。
13. 完成后报告：
    - 源文件总行数。
    - 成功匹配记录数。
    - 成功回填记录数。
    - 未匹配的 `Product_Number` 数量。
    - 因缺字段、空值、重复值或写入错误跳过的数量。

## 字段匹配规则

- 源文件字段名必须优先精确匹配 `Product_Number`、`XID`、`Prod_Image`。
- 不要把 `Product Name`、`Product_ID`、`Product Number` 等近似字段自动当作 `Product_Number`，除非用户确认。
- 目标表字段名也应精确匹配。字段名不一致时，先列出候选字段并请用户确认映射。

## Prod_Image 处理规则

`Prod_Image` 可能是文本 URL、平台图片地址、图片文件名或普通文本字段。先根据 `ASI商品表` 的字段类型决定写入方式：

- 如果目标字段是文本/URL 类型，直接写入清洗后的字符串。
- 如果目标字段是附件类型，不要把 URL 伪造成附件；需要先下载或获取本地文件，再按附件上传流程处理。
- 如果字段类型不明确，先读取字段结构并按真实类型处理。

## 安全与核验

- 不创建新商品记录，除非用户明确要求。
- 不修改 `Product_Number`。
- 不删除或清空已有字段，除非用户明确要求。
- 写入前优先小批量验证字段类型与写入格式。
- 写入后抽查或重新读取已更新记录，确认 `XID` 与可选 `Prod_Image` 已回填。

## 工具调用示例

以下示例只展示调用形态，实际执行时必须替换占位符，不得把占位符当成真实参数。

### 查看 Base 表列表

```bash
lark-cli base +table-list --base-token <BASE_TOKEN>
```

### 查看 ASI商品表字段

```bash
lark-cli base +field-list --base-token <BASE_TOKEN> --table-id <ASI_TABLE_ID>
```

### 读取 ASI商品表记录

```bash
lark-cli base +record-list \
  --base-token <BASE_TOKEN> \
  --table-id <ASI_TABLE_ID> \
  --field-id Product_Number \
  --field-id XID \
  --field-id Prod_Image \
  --limit <PAGE_SIZE> \
  --offset <OFFSET> \
  --format json
```

### 按每条记录不同值批量回填

当每条记录的 `XID` 或 `Prod_Image` 不同，使用支持 per-record fields 的 Bitable batch update API：

```bash
lark-cli api POST \
  /open-apis/bitable/v1/apps/<BASE_TOKEN>/tables/<ASI_TABLE_ID>/records/batch_update \
  --data @<REQUEST_JSON_FILE>
```

`<REQUEST_JSON_FILE>` 内容形态：

```json
{
  "records": [
    {
      "record_id": "<RECORD_ID>",
      "fields": {
        "XID": "<XID>",
        "Prod_Image": "<PROD_IMAGE>"
      }
    }
  ]
}
```

如果只更新少量记录，也可以按记录逐条更新：

```bash
lark-cli base +record-upsert \
  --base-token <BASE_TOKEN> \
  --table-id <ASI_TABLE_ID> \
  --record-id <RECORD_ID> \
  --json '{"XID":"<XID>","Prod_Image":"<PROD_IMAGE>"}'
```

## 输出

完成后用简洁中文报告实际结果，至少包括：

- 成功回填多少个产品。
- 是否回填了 `Prod_Image`。
- 有多少行未匹配或跳过。
- 如有错误，列出主要原因和少量示例 `Product_Number`。
