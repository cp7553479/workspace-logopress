---
name: print-pi
description: 导出PI形式发票(Proforma Invoice)。将PI表中指定记录及其商品明细填充至PI模板xlsx，通过飞书发送给用户。触发词：打印PI、导出PI、生成PI、print PI、export PI。
---

# 打印PI表

## 数据源

如果未声明base token或无法准确定位表格请直接询问用户。

- **Base ID:** `<your base token>`
- **PI表:** `<your table id>`（索引字段 `PI`，Text类型，值为PI编号如 `LP26041701`）
- **PI明细表:** `<your table id>`（主键 `商品编号`，Text类型；关联字段 `PI` 指向PI表）
- **PI模板:** `PI/PI模板.xlsx`（workspace相对路径）
- **LOGO图片:** `PI/image1.png`（workspace相对路径，1.56cm × 2.08cm，模板中已嵌入）

## 流程

### 1. 查找PI记录

用户提供PI编号，在PI表中按 `PI` 字段筛选。

```python
# 使用 feishu_bitable_list_records 筛选，或遍历全部记录匹配
# PI表记录量通常较少，list_records 遍历即可
feishu_bitable_list_records(app_token="<your base token>", table_id="<your table id>")
# 从返回的 records 中匹配 fields["PI"] == <用户提供的PI编号>
```

### 2. 读取商品明细

PI记录中 `商品明细` 字段（DuplexLink）包含关联的PI明细表记录ID列表。逐条用 `feishu_bitable_get_record` 读取。

```python
# 商品明细字段值结构:
# fields["商品明细"] = [{"record_ids": ["recxxx", ...], "table_id": "<your table id>"}, ...]
# 收集所有 record_id，逐条读取
feishu_bitable_get_record(
    app_token="<your base token>",
    table_id="<your table id>",
    record_id=<record_id>
)
```

### 3. 复制模板并填充

复制模板为 `<PI编号>.xlsx`，用 openpyxl 写入。

#### 3.1 字段映射

| 模板单元格 | 模板占位符 | PI表字段 | 说明 |
|-----------|-----------|---------|------|
| B9 | @客户 公司名称 | 客户 公司名称 | Lookup，值取 `text` |
| B10 | @客户 公司地址 | 客户 公司地址 | 同上 |
| B11 | @客户姓名 | 客户姓名 | 同上 |
| B12 | @客户电话 | 客户电话 | 同上 |
| B13 | @客户邮箱 | 客户邮箱 | 同上 |
| E9 | @S.T Company | S.T Company | Text |
| E10 | @S.T Address | S.T Address | Text |
| E11 | @S.T Attn | S.T Attn | Text |
| E12 | @S.T Phone | S.T Phone | Text |
| E13 | @S.T Email | S.T Email | Text |
| I4 | @Order Date | Order Date | 毫秒时间戳→`yyyy/MM/dd` |
| I5 | @PI | PI | Text |
| I6 | @PO | PO | Text |
| I9 | @Order Date | Order Date | 同I4 |
| I10 | @Ship Date | Ship Date | 毫秒时间戳→`yyyy/MM/dd` |
| I11 | @In-Hands Date | In-Hands Date | 毫秒时间戳→`yyyy/MM/dd` |
| I12 | @运输公司 | 运输公司 | SingleSelect，取 `name` |
| I13 | @发货包裹数 | 发货包裹数 | Number |
| I26 | @Freight | Freight | 公式字段，取数值 |
| I27 | @Set-up fee | Set-up fee | Number |
| I28 | @Insurance | Insurance | Number |
| I29 | @Inspection\|Cert. | Inspection\|Cert. | Number |
| I30 | @Other (specify) | Other (specify) | Number |

Lookup字段取值方式：`fields["客户 公司名称"][0]["text"]`
SingleSelect取值方式：`fields["运输公司"]` 直接为字符串（已选中的 option name）
时间戳转换：`datetime.fromtimestamp(ms / 1000).strftime('%Y/%m/%d')`

#### 3.2 商品行（B16:I24）

每条PI明细记录占一行，从第16行开始。

| 列 | 单元格 | PI明细表字段 | 说明 |
|----|--------|------------|------|
| B | 商品编号 | 商品编号 | Text |
| C | DESCRIPTION | 商品名称 | Lookup，取 `text` |
| G | QTY | QTY | Number |
| H | UNIT PRICE | UNIT PRICE | Number |

I16:I24 已有公式 `=G*H`，勿覆盖。商品明细不足9行时多余行留空即可。

#### 3.3 Python执行模板

```python
import openpyxl, shutil
from datetime import datetime

src = "<workspace>/PI/PI模板.xlsx"
dst = f"<workspace>/PI/{pi_number}.xlsx"
shutil.copy2(src, dst)

wb = openpyxl.load_workbook(dst)
ws = wb["PI"]

def ts(ms):
    if not ms: return None
    return datetime.fromtimestamp(ms / 1000).strftime('%Y/%m/%d')

def lookup(field):
    if not field: return None
    return field[0]["text"]

# 客户信息
ws['B9']  = lookup(r['客户 公司名称'])
ws['B10'] = lookup(r['客户 公司地址'])
ws['B11'] = lookup(r['客户姓名'])
ws['B12'] = lookup(r['客户电话'])
ws['B13'] = lookup(r['客户邮箱'])

# Ship To
ws['E9']  = r.get('S.T Company')
ws['E10'] = r.get('S.T Address')
ws['E11'] = r.get('S.T Attn')
ws['E12'] = r.get('S.T Phone')
ws['E13'] = r.get('S.T Email')

# 订单信息
ws['I4']  = ts(r.get('Order Date'))
ws['I5']  = r.get('PI')
ws['I6']  = r.get('PO')
ws['I9']  = ts(r.get('Order Date'))
ws['I10'] = ts(r.get('Ship Date'))
ws['I11'] = ts(r.get('In-Hands Date'))
ws['I12'] = r.get('运输公司')
ws['I13'] = r.get('发货包裹数')

# 费用
ws['I26'] = r.get('Freight', 0)
ws['I27'] = r.get('Set-up fee', 0)
ws['I28'] = r.get('Insurance', 0)
ws['I29'] = r.get('Inspection|Cert.', 0)
ws['I30'] = r.get('Other (specify)', 0)

# 商品明细
for i, item in enumerate(items):
    row = 16 + i
    ws[f'B{row}'] = item['商品编号']
    ws[f'C{row}'] = lookup(item.get('商品名称'))
    ws[f'G{row}'] = item.get('QTY')
    ws[f'H{row}'] = item.get('UNIT PRICE')

wb.save(dst)
```

> **图片保留**：openpyxl `load_workbook` + `save` 会丢失模板中嵌入的图片。`wb.save(dst)` 之后、发送之前，执行以下代码注入图片：
>
> ```python
> import zipfile, io
> with zipfile.ZipFile(src, 'r') as z_orig:
>     media_files = [n for n in z_orig.namelist() if 'media/' in n or 'drawing' in n]
> buf = io.BytesIO()
> with zipfile.ZipFile(dst, 'r') as z_base:
>     with zipfile.ZipFile(buf, 'w', zipfile.ZIP_DEFLATED) as z_out:
>         for item in z_base.namelist():
>             z_out.writestr(item, z_base.read(item))
>         with zipfile.ZipFile(src, 'r') as z_orig2:
>             for item in media_files:
>                 z_out.writestr(item, z_orig2.read(item))
> with open(dst, 'wb') as f:
>     f.write(buf.getvalue())
> ```

### 4. 调用message工具发送文件给用户

```
message(action="send", channel="feishu", filePath="<path>", caption="...")
```

## 注意事项

- 时间戳字段（Order Date / Ship Date / In-Hands Date）值为毫秒级 Unix timestamp，需转换为 `yyyy/MM/dd` 格式
- Lookup字段值为数组 `[{text: "xxx"}]`，取 `[0]["text"]`
- DuplexLink字段（商品明细）值结构为 `[{record_ids: [...], table_id: "<your table id>"}]`，需提取 record_id 逐条读取
- I16:I24 列含 `=G*H` 公式，只写 B/C/G/H 列
- I25:I33 行含汇总公式，勿写入
- 数值字段可能以字符串存储（如 `"40"`），openpyxl 写入时自动处理
