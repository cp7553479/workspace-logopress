---
name: inquiry
description: 从用户消息中提取询单信息写入飞书多维表询单表。当用户要求新增/录入/导入/修改询单记录时使用
---

# 新增询单

**注意：**
以下 base-token、table-id、view-id、field-id 均为示例值，请根据实际情况替换成实际值，先读取表结构，再思考下一步。
如果未声明base token或无法准确定位表格请直接询问用户。
请回复用户，充分与用户沟通。

## 步骤
1. 请先读取飞书多维表格中的关键表的字段结构
2. 提取询单信息：客户、产品编号、数量、目的地、邮箱、备注等其他与飞书多维表格中的关键表的字段相关的数据。
3. 询单查重：在`询单`.`标题`中搜索包含客户姓名和产品编号关键词的记录，通过这种模糊搜索的方式若有找到记录，询问用户是否在旧的记录上修改还是新增。
4. 匹配产品：将产品编号（通常是“LP+数字”的格式）搜索 `商品线索表`.`产品编号`，取匹配到的第一条记录；未匹配到时询问用户是否要新增一条产品记录再关联。
5. 匹配客户：搜索 `客户联系人`.`客户邮箱`；未匹配到时在`客户联系人`表中新增一条客户联系人记录，再回填询单的客户姓名。
6. 写入询单记录，只填写当前能确定的字段。
7. 输出结果：record_id + 完整字段表格。
8. 使用`quotation` skill，生成该询单的报价

## API 说明
- 使用`lark-cli base --help`获取lark-cli操作指令，避免猜测指令，所有飞书多维表格操作需要通过`lark-cli`工具执行
- 如遇权限问题可使用`lark-cli`的user access token
- 使用搜索精准定位记录
```example:
lark-cli base +record-search \
  --base-token <your base token> \
  --table-id <your table id> \
  --json '{"keyword":"LP1234","search_fields":["产品编号"]}'
```

## 表结构
Base ID: `<your base token>`
- 询单: tableId=`<your table id>`, viewId=`vewFvOHsQS`
- 商品线索表: tableId=`<your table id>`, viewId=`vewRmWitRt`, indexFieldName=`产品编号`
- 客户联系人: tableId=`<your table id>`, viewId=`vew4OAIn9N`, indexFieldName=`客户邮箱`

## 注意事项
- 不写只读字段
- 不清楚就暂停任务并询问用户
- 必须以客户邮箱去`客户联系人.客户邮箱`里匹配客户联系人信息，同一个客户公司底下可能有不同多个客户联系人，但在`询单.客户姓名`中需要以客户邮箱匹配到的精准的记录
- `询单`.`标题`通常包含产品编号和客户姓名
