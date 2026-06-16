# Long-Term Memory

## 用户信息
- 姓名：陈鹏（阿呆）
- 公司：LogoPress Trading Inc
- 行业：Global B2B Trading / Customized Printing
- 时区：Asia/Shanghai (北京，UTC+8)

## 稳定偏好
- Skill 修改/规则话术：偏好简洁、精炼，不添加无关解释；修改后检查上下文是否冲突、重复或累赘。
- 创建或改写 Skill 时，`SKILL.md` 应以说明文为主，保持抽象、普适、可复用；不要硬编码 baseId、tableId、文件路径等具体值，示例命令使用占位符。
- 飞书主多维表格以 `https://mingjiainno.feishu.cn/base/SF9ibzjI4a0YFJsDZtKcLvtbnfh?table=tbl3KNB7zP8EQ1d0&view=vewMQ68Gd5` 为准；base-token 为 `SF9ibzjI4a0YFJsDZtKcLvtbnfh`，历史旧 token / 旧 table id 不再作为准绳。
- 商品/电商生图工具规则：subagent 必须阅读当前可用的生图 skill，并按该 skill/tool 当前推荐的最新、最适合商品图的生图模型生成图片；handoff 可明确允许 Oracle 生图，但不要把 Oracle 或其他具体服务写成唯一方式。
- 商品图生图路径策略：后续派发商品图 subagent 时，handoff 必须明确告诉 subagent 优先使用 Oracle 生图，并在 Oracle ChatGPT 和 Oracle Gemini 之间交替尝试；只有 ChatGPT 与 Gemini 两条 Oracle 路径都遇到问题、失败、不可用或结果被拒绝并记录证据后，才切换 Codex 生图。每张图仍需记录实际使用路径和失败证据。
- 商品图 subagent 派发偏好：每次派生 subagent 时，要尽量把任务需求描述清楚，或写入产品专用 handoff 文档；明确要求 subagent 先阅读该 handoff 文档、共享 worker instructions 和相关生图 skill 后再执行。
- ASI 首图 Logo 规则：如果参考图商品本身有 logo，首图 prompt 必须要求替换为 Logo 图片文件上的 logo，或替换为不含任何图形标记的纯文字 `YOUR LOGO`，不得保留参考图商品原有 logo 图案。
- ASI 商品图前置规则：后续派发商品图 subagent 时，handoff 必须要求先用 `参考图片` 字段原始图生成一张干净无 logo 商品参考图，去掉产品上的原有 logo/sample logo/品牌图案/示例印刷/平台厂家标记；生成后必须上传回并替换当前记录 `参考图片` 字段里的原始图片，回读确认旧原图已移除；后续白底图和 ASI 套图必须基于这张已回填的干净参考图生成，不能直接用原始参考图片生成套图。
- 后续商品/电商生图任务必须由 subagent 执行；主会话每次只能派生一个商品生图 subagent，等完成、阻塞或恢复点明确后再派下一个。
- 2026-06-10 用户再次明确纠正：商品/电商生图批量任务每次仅允许同时派生一个 subagent；处理完一个商品之后再派生下一个 subagent。心跳或恢复逻辑发现已有商品图 subagent 运行时，只能监督当前商品、停止重复会话或记录阻塞，不能启动新商品。
- 禁止 Gemini 2.5 Flash Image
- 英文提示词、1:1、无中文/价格/水印/QR、不虚构
- 商品/电商生图串行排队，不并发；禁止脚本、贴图、局部覆盖、透视变换或程序合成最终图片。
- 不喜欢被说"我会一直跑"但实际做不到——要诚实
- 长批量任务偏好：及时使用 `update_plan` 记录当前任务状态，并把关键进度、阻塞、恢复点及时写入记忆，避免中断后丢失上下文。
- 商品/电商生图交付偏好：生成好的图片必须在飞书聊天里逐张发给用户，不能只上传到表格；如果用户说有图片没收到，要重新发送缺失图片并确认媒体回执。
- 长期 ASI 商品图监控偏好：不要依赖 `HEARTBEAT.md`；使用 cron 定时任务周期性唤醒并投递到当前飞书私聊 session。当前 ASI 监控 cron 为 `asi-subagent-watch-current-session`，每 30 分钟运行一次，sessionTarget 固定到 `agent:global-trading-product:feishu:global-trading-product:direct:ou_61123e30e1c1bfd2d0d31af923d4982d`。

## Promoted From Short-Term Memory (2026-06-16)

<!-- openclaw-memory-promotion:memory:memory/2026-06-13.md:103:103 -->
- ASI image queue heartbeat - 01:22: Actions and outcome: [score=0.841 recalls=0 avg=0.620 source=memory/2026-06-13.md:103-103]
<!-- openclaw-memory-promotion:memory:memory/2026-06-13.md:12:13 -->
- ASI image queue heartbeat - 00:15: Base readback files show clean reference replacement succeeded (`参考图片=1`) and white background upload succeeded (`白底图=1`); no main-image upload evidence yet (`商品主图=0`).; process coordination state is currently held by an active ChatGPT hero/main generation process for LP1559, so no recovery worker and no next product were spawned. [score=0.841 recalls=0 avg=0.620 source=memory/2026-06-13.md:12-13]
<!-- openclaw-memory-promotion:memory:memory/2026-06-13.md:15:15 -->
- ASI image queue heartbeat - 00:15: Lesson / next rule: when a worker is active and a matching Oracle process is running, continue supervising the same product; do not start recovery or the next product until the process finishes or clearly stalls. [score=0.841 recalls=0 avg=0.620 source=memory/2026-06-13.md:15-15]
<!-- openclaw-memory-promotion:memory:memory/2026-06-11.md:11:14 -->
- LP1214 completed: LP1214 (`recuYsA78zo6P0`) completed on 2026-06-11. Product: portable vintage turntable bluetooth speaker record player; colors Black/White/Brown; material Plastic.; Final set: 3 white-background images and 6 main images. Base readback verified `白底图=3`, `商品主图=6`, no duplicate names/tokens.; Final local files sent to user via Feishu media receipts: `LP1214_white_black.png`, `LP1214_white_white.png`, `LP1214_white_brown.png`, `LP1214_main_hero.png`, `LP1214_main_lifestyle.png`, `LP1214_main_selling.png`, `LP1214_main_dimension.png`, `LP1214_main_material.png`, `LP1214_main_sku_chart.png`.; Progress recorded LP1214 as... [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-11.md:11-14]
<!-- openclaw-memory-promotion:memory:memory/2026-06-11.md:18:21 -->
- LP1004 completed and hero reworked: LP1004 (`recuYsAdUpuYZk`) product: Durable Stainless Steel Camping/Travel Cup Beer Tumbler; confirmed color silver; material Stainless Steel.; Initial LP1004 completed with `白底图=1` and `商品主图=5`, no duplicate names/tokens; SKU chart skipped because only one confirmed silver SKU; 3D dimension skipped because length is 0 cm.; Initial final files delivered to user: `LP1004_oracle_white_background.png`, `LP1004_oracle_hero_main.png`, `LP1004_lifestyle_scene.png`, `LP1004_selling_point-2.png`, `LP1004_dimension_chart.png`, `LP1004_oracle_material_detail.png`.; User then requested LP1004 hero be... [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-11.md:18-21]
<!-- openclaw-memory-promotion:memory:memory/2026-06-11.md:22:22 -->
- LP1004 completed and hero reworked: LP1004 hero rework completed: new file `LP1004_hero_main_rework.png` was generated, old hero token `Ffv1b6R60oFdxNxy9KpcvHqZnHd` removed, new hero token written to `商品主图`, Base readback still `白底图=1`, `商品主图=5`, no duplicates. New hero was sent to user. [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-11.md:22-22]
<!-- openclaw-memory-promotion:memory:memory/2026-06-11.md:26:29 -->
- LP1016 current state and recovery: LP1016 (`recuYsAdUpeI5N`) product: 10000mah phone stand portable charger magnetic power bank; confirmed colors Black, White, Navy Blue, Light Blue; material Plastic; size 15.5 x 8 x 2.5 cm.; First LP1016 subagent generated and uploaded 4 white-background images to `白底图`: `LP1016_white_black.png`, `LP1016_white_white.png`, `LP1016_white_navy_blue.png`, `LP1016_white_light_blue.png`.... [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-11.md:26-29]
<!-- openclaw-memory-promotion:memory:memory/2026-06-11.md:30:32 -->
- LP1016 current state and recovery: Partial LP1016 images (4 white + 2 partial main) were sent to user via Feishu media receipts around 2026-06-11 13:53 GMT+8.; Cron job `499a0d42-22ec-440a-8ae9-3f2de47e9575` was created for 2026-06-11 14:40 GMT+8 to resume LP1016 only after the wait. Its payload says to first check active subagents/progress and not start LP1016 if another ASI subagent is running.; At 2026-06-11 14:40 cron fired. Active subagents check showed none; LP1004 hero rework had completed. A recovery handoff `.temp/asi_has_inquiry_manifest/handoff_LP1016_recovery.md` was created, and an LP1016 recovery subagent was spawned.... [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-11.md:30-32]
<!-- openclaw-memory-promotion:memory:memory/2026-06-11.md:5:7 -->
- ASI image generation queue and user preferences: User explicitly requested that future product-image subagents use Oracle and alternate between ChatGPT and Gemini image-generation modes. This was written into `skills/asi-product-image-generator/SKILL.md` and included in later handoffs. Continue serial execution: one product/image subagent at a time only.; User corrected a prior overreach: do not add durable workspace rules merely inferred from a one-off incident unless the user explicitly asks. A previously added `Done.`-style rule in `TOOLS.md` was removed per user request.... [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-11.md:5-7]
<!-- openclaw-memory-promotion:memory:memory/2026-06-13.md:101:101 -->
- ASI image queue heartbeat - 01:22: Context: heartbeat checked the serial ASI product-image queue shortly after LP1638 was spawned. [score=0.809 recalls=0 avg=0.620 source=memory/2026-06-13.md:101-101]
