# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## Credentials (`~/.openclaw/.env`)
- LLM Keys: `GEMINI_API_KEY`, `OPENROUTER_API_KEY`, `XAI_API_KEY`

## Local CLIs
- `openclaw`, `lark-cli`

## Spawnable Agents
- Spawn `customer-intent-insight` when analyzing customer intent, queries, or extracting structured requirements.
- Spawn `catalog-maker` when generating catalogs, styling PDFs, or formatting Notion catalog pages.
- Spawn `website-maker` when building, compiling, or deploying websites from product data.
- Spawn `takewaypack` when handling takeaway package workflows, pricing, or templates.
- Spawn `main` for general coordination or fallback routing outside specific domains.

## Lark-cli

Use the `lark-cli` as your primary work tool. The primary lark base(飞书多维表格) is:

`https://mingjiainno.feishu.cn/base/SF9ibzjI4a0YFJsDZtKcLvtbnfh?table=tbl3KNB7zP8EQ1d0&view=vewMQ68Gd5`

Its base-token is `SF9ibzjI4a0YFJsDZtKcLvtbnfh`. Previous Base tokens and previous table IDs are obsolete unless the user explicitly says otherwise. Table IDs must use the table list from this Base.

| 表格 | Table ID | 简介 / 作用 |
| ---- | -------- | ----------- |
| 询单 | `tbluf7HTaj65eIAc` | 记录客户询价/询盘需求，包含产品、数量、交期、客户信息、业务员、PI关联等，是报价和成单前的需求入口。 |
| PI | `tblIu2Fc9CseBBtk` | Proforma Invoice 主表，管理订单/形式发票信息，包含客户、PO、金额、利润、付款/运输方式、交期、运费、采购费等。 |
| 客户联系人 | `tblxmh9hT5UQMwMZ` | 维护客户联系人与公司资料。 |
| 客户公司 | `tblNJtiPvtNbHugm` | 维护客户公司资料。 |
| 商品表 | `tbl3KNB7zP8EQ1d0` | 商品线索与商品资料主表，用于整理产品来源、图片、材质、尺寸、包装、价格阶梯、印刷与ASI/ESP字段等商品基础数据。 |
| ASI商品表 | `tbl1f731h82T86ag` | ASI商品发布/同步用的结构化商品表，维护Product Number、Product Name、Description、价格、包装、产地、关键词、运费和上传字段。 |

Before mention 飞书多维表格、多维表格、lark base、bitable，running `lark-cli base --help`,`lark-cli base +table-list --base-token SF9ibzjI4a0YFJsDZtKcLvtbnfh`.

Before use lark-cli, running `lark-cli --help`.

## Tips & Notes
- **lark-cli uploads**: Do not use `--name`, use relative paths for `--file` (e.g., `./file.png`), and upload serially to avoid race conditions.
- **Feishu image replies**: Use `filePath="/path/to/img.png"` inside `message(action="send", ...)` to ensure images render correctly.
