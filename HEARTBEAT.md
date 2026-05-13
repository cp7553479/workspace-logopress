# HEARTBEAT — ASI 生图任务队列

## 负责的 Session
- **Session Key**: `agent:global-trading-product:feishu:global-trading-product:direct:ou_61123e30e1c1bfd2d0d31af923d4982d`
- 这个 session 负责 HEARTBEAT 里列出的所有生图任务
- 其他 session 发现 heartbeat 时，应用 `sessions_send` 把任务派到这个 session

## 当前 Oracle 进程
- 检查是否有 Oracle 进程在跑：`ps aux | grep oracle | grep -v grep`
- 检查输出文件是否已生成：`ls -la temp/<product_dir>/outputs/LP*-oracle-*.png`

## LP0122（recuLl1iT6nKQZ）— 摩托车车罩
- [x] 场景图 oracle ✅ uploaded
- [x] 卖点图 oracle ✅ uploaded
- [x] 尺寸图 oracle ✅ uploaded
- [x] 材质图 oracle ✅ uploaded
- [x] SKU 图 oracle ✅ uploaded
- [ ] 首图 hero oracle（带 LogoPress logo）— running `keen-basil`, output `temp/LP0122_asi_recuLl1iT6nKQZ/outputs/LP0122-oracle-main-hero.png`
- 上传用: `lark-cli base +record-upload-attachment --base-token KcXMbMUvAa7TNYsIqD7cwNi1nDf --table-id tblsVUTaYTcvp8F5 --record-id recuLl1iT6nKQZ --field-id 商品主图 --as user`

## 空白商品（0张主图+0张白底图）— 优先处理
每个需要：下载参考图 → 准备 prompts → Oracle 串行生成 白底图+场景+卖点+尺寸+材质+SKU+首图 → 上传
- [ ] LP7296 (recvcuThLRvH9d) — 空
- [ ] LP7297 (recvcuTz8h1CdH) — 空
- [ ] LP7298 (recvcuTACW6pCG) — 空
- [ ] LP7299 (recvcuTACWbxhi) — 空
- [ ] LP7300 (recvcuTH4eYo80) — 空

## 需补图商品（主图不足5张）
- [ ] LP0041 (3张) — 补2张
- [ ] LP0105 (3张) — 补2张
- [ ] LP0109 (4张) — 补1张
- [ ] LP0125 (4张) — 补1张
- [ ] LP0257 (4张) — 补1张
- [ ] LP0873 (4张) — 补1张
- [ ] LP0895 (2张) — 补3张
- [ ] LP5826 (4张) — 补1张
- [ ] LP7291 (4张) — 补1张
- [ ] LP7302 (3张) — 补2张
- [ ] LP7303 (3张) — 补2张

## 缺白底图
- [ ] LP0056 (5张主图但0张白底图)

## 执行规则
1. Oracle 串行，一次只跑一个；Mac 上没有 `timeout` 命令，使用 OpenClaw `exec(timeout=600)` 控制 10 分钟
2. 超过10分钟 kill 进程，检查输出文件是否已落盘
3. 文件存在→上传继续；不存在→重试
4. Oracle 失败可用 Codex exec 进入临时文件夹生图
5. 每个 Oracle 完成后：kill进程 → 检查文件 → QA → 上传 → 启动下一个
6. 不用 Gemini 2.5 Flash Image
7. 上传前 QA：1:1、无中文、无价格/水印/QR、产品与参考一致

## 关键路径
Base: KcXMbMUvAa7TNYsIqD7cwNi1nDf | Table: tblsVUTaYTcvp8F5 | View: vewS5HTB1k
LogoPress logo: skills/asi-product-image-generator/asserts/LOGO-WT.png
