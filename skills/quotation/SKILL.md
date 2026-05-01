---
name: quotation
description: 外贸报价工具。用于根据商品编号生成报价表、查询阶梯价和补全模板内容时使用。
---

# 报价 Skill

## 流程

### 1. 确认输入

开始报价前先确认以下信息：

- 产品编号
- 客户需求量
- 几色印刷，默认 `1`
- 几个 logo，默认 `1`

若信息不清楚，先问用户。

### 2. 获取产品信息

用户提供商品编号后，在 `ASI商品表` 中通过 `Product_Number` 查找记录。

- **Base ID:** `KcXMbMUvAa7TNYsIqD7cwNi1nDf`
- **商品线索表:** `tblsVUTaYTcvp8F5`
- **ASI商品表:** `tblViJPkjCGT4OGS`

关联关系：`ASI商品表`.`Product_Number`=`商品线索表`.`产品编号`

- 使用搜索精准定位记录
```example:
lark-cli base +record-search \
  --base-token KcXMbMUvAa7TNYsIqD7cwNi1nDf \
  --table-id tblsVUTaYTcvp8F5 \
  --json '{"keyword":"LP1234","search_fields":["产品编号"]}'
```

### 3. 匹配阶梯价格

`ASI商品表` 中 `Q1`~`Q10` 是阶梯数量，`P1`~`P10` 是对应单价（USD）。客户报的每个需求量都取 **≤ 需求量的最大 Qi**，对应 `Pi` 即为该档报价。

### 4. 复制报价模板

复制 `quotation/询价模版.xlsx`，在 `quotation/` 目录下生成一份新文件。

- 模板文件：`quotation/询价模版.xlsx`
- 新文件名格式：`<YYYY-MM-DD>-<商品编号>-<需求量>`

```example
python3 - <<'PY'
from pathlib import Path
import shutil

src = Path('quotation/询价模版.xlsx')
dst = Path('quotation/<YYYY-MM-DD>-<商品编号>-<需求量>.xlsx')
shutil.copyfile(src, dst)
print(dst)
PY
```

### 5. 填写数据

识别模板中带 `@` 的单元格，这些值都从飞书多维表格中按精准字段名取值。只写入明确指定的输入单元格，不覆盖公式单元格。

#### 5.1 `报价表` 页签中的 `@` 字段

- `B2` → `@Product_Number`
- `C2` → `@Product_Name`
- `B9` → `@箱子尺寸 长(cm)`
- `C9` → `@箱子尺寸 宽(cm)`
- `D9` → `@箱子尺寸 高(cm)`
- `E9` → `@重量(箱子+产品)公斤`
- `F9` → `@件数/箱`
- `B11` → `@1688价(元)`

#### 5.2 手动输入单元格

- `D2` → 几色印刷
- `E2` → 几个 logo
- `B4:F4` → 客户需求量，从低到高填写
- `B7:F7` → 对应阶梯价，按需求量顺序填写

若只有一个需求量，只填写首个位置；其余位置留空。

#### 5.3 可选写入单元格

以下数值默认不写，只有用户明确要求时才写入：

- `C11` → 其他固定费用
- `D11` → 运费膨胀系数
- `E11` → 汇率
- `F11` → 目标利润率
- `B13` → 快递单价
- `C13` → 空派单价
- `D13` → 海派单价

#### 5.4 模板结构说明

- `B5:F5` 为基于 `B17:F17` 和 `B4:F4` 自动计算的金额，不手动写入
- `F2` 为 `SETUP FEE` 公式，不手动写入，除非用户明确要求改公式或固定值
- `G9`、`H9`、`B16:J30` 为计算或展示区域，不手动写入
- 其他页签为运费和换算辅助页，不改结构

#### 5.5 批量写入 `xlsx` 示例

```example
python3 - <<'PY'
import openpyxl

path = 'quotation/<YYYY-MM-DD>-<商品编号>-<需求量>.xlsx'
wb = openpyxl.load_workbook(path)
ws = wb['报价表']

# @ 字段
ws['B2'] = '<Product_Number>'
ws['C2'] = '<Product_Name>'
ws['B9'] = '<箱子尺寸 长(cm)>'
ws['C9'] = '<箱子尺寸 宽(cm)>'
ws['D9'] = '<箱子尺寸 高(cm)>'
ws['E9'] = '<重量(箱子+产品)公斤>'
ws['F9'] = '<件数/箱>'
ws['B11'] = '<1688价(元)>'

# 用户输入
ws['D2'] = '<几色印刷>'
ws['E2'] = '<几个logo>'
ws['B4'] = '<需求量1>'
ws['C4'] = '<需求量2>'
ws['D4'] = '<需求量3>'
ws['E4'] = '<需求量4>'
ws['F4'] = '<需求量5>'
ws['B7'] = '<报价1>'
ws['C7'] = '<报价2>'
ws['D7'] = '<报价3>'
ws['E7'] = '<报价4>'
ws['F7'] = '<报价5>'

wb.save(path)
print(path)
PY
```

### 6. 计费重量检查

计费重量若计算后低于 `15kg`，提醒用户这是小货，注意运费单价。

### 7. 输出文件

- 保存新的 `xlsx` 文件
- 上传生成后的文件
- 将文件发送给用户

## API 说明
- 使用 `lark-cli base --help` 获取 lark-cli 操作指令说明，避免猜测指令，所有飞书多维表格操作需要通过 `lark-cli` 工具执行
- 如遇权限问题可使用 `lark-cli` 的 user access token

## 注意事项

- `Product_Name` 和阶梯价格（`P1`~`P10`）在 `ASI商品表` 中用 `Product_Number` 进行索引查询，`Product_Name` 以 `ASI商品表` 的 `Product_Name` 字段值为准
- 1688价需从 `商品线索表` 按 `产品编号`(`Product_Number`) 关联查找 `1688价(元)` 字段，1688 的链接是 `来源(1688)` 字段
- 箱规需从 `商品线索表` 按 `产品编号`(`Product_Number`) 关联查找 `箱子尺寸 长(cm)` / `箱子尺寸 宽(cm)` / `箱子尺寸 高(cm)` / `重量(箱子+产品)公斤` / `件数/箱` 字段
- `商品线索表`.`产品编号`=`ASI商品表`.`Product_Number`
- 同一产品询多个数量时，需求量从低到高依次填入 `B4:F5`，对应阶梯价依次填入 `B7:F7`
- 开始报价前需确认产品编号、客户需求量、几色印刷（默认 1）、几色logo（默认 1）；其余信息从飞书多维表格查询
