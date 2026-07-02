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

## Promoted From Short-Term Memory (2026-06-18)

<!-- openclaw-memory-promotion:memory:memory/2026-06-11-1527.md:13:16 -->
- Conversation Summary: User text: [Feishu oc_ec473251e4d81e5d4285a200b5e704e7:ou_ff32a73eb197d17bb99c7e56e2d0c052 Tue 2026-06-09 06:12:55 GMT+8] 王桂彬: /root/.openclaw/media/inbound/d9fc6689-e04d-49f4-93aa-e34658f4cc4d.jpg Description: A black waterproof roll-top dry bag/pouch with a buckle closure, branded “World Nomads Travel Insurance,” lying on a light gray tiled floor. [score=0.834 recalls=0 avg=0.620 source=memory/2026-06-11-1527.md:13-16]
<!-- openclaw-memory-promotion:memory:memory/2026-06-11-1527.md:17:20 -->
- Conversation Summary: assistant: NO_REPLY user: 将这张图生成灰色的不带logo的正面图 assistant: dry-bag-grey-front-no-logo-from-user-ref---b506d00b-e8d4-47ad-aca6-7cd8a6b95eba.png assistant: NO_REPLY [score=0.834 recalls=0 avg=0.620 source=memory/2026-06-11-1527.md:17-20]
<!-- openclaw-memory-promotion:memory:memory/2026-06-11-1527.md:21:24 -->
- Conversation Summary: user: 将前面这张图生成灰色的不带logo的正面图 assistant: dry-bag-grey-front-no-logo-from-user-ref---b506d00b-e8d4-47ad-aca6-7cd8a6b95eba.png assistant: NO_REPLY user: LP0586，请根据首图生成Asi套图并上传到飞书多维表格 [score=0.834 recalls=0 avg=0.620 source=memory/2026-06-11-1527.md:21-24]
<!-- openclaw-memory-promotion:memory:memory/2026-06-11-1527.md:25:27 -->
- Conversation Summary: assistant: LP0586-white-background-no-logo.png, LP0586-asi-final-hero-logo.png, LP0586-asi-lifestyle-scene.png, LP0586-asi-selling-playback-modes.png, LP0586-asi-material-detail.jpg, LP0586-asi-dimensions.png assistant: NO_REPLY user: LP0923，LP0927，LP0928使用subagent阅读skill生成ASI首图上传到飞书多维表格商品表里。 [score=0.834 recalls=0 avg=0.620 source=memory/2026-06-11-1527.md:25-27]
<!-- openclaw-memory-promotion:memory:memory/2026-06-11-1527.md:3:5 -->
- Session: 2026-06-11 15:27:47 GMT+8: **Session Key**: agent:main:feishu:group:oc_ec473251e4d81e5d4285a200b5e704e7; **Session ID**: b9077fdb-adcb-4491-b1fc-9f02ec64c3b6; **Source**: feishu [score=0.834 recalls=0 avg=0.620 source=memory/2026-06-11-1527.md:3-5]
<!-- openclaw-memory-promotion:memory:memory/2026-06-11-1527.md:9:12 -->
- Conversation Summary: user: 给我一张LP0223的灰色的不带logo的正面图 assistant: LP0223-grey-front-no-logo---fd35160a-58ea-42de-9316-2c21f58a4c6d.jpg assistant: NO_REPLY user: [Image] [score=0.834 recalls=0 avg=0.620 source=memory/2026-06-11-1527.md:9-12]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12.md:13:14 -->
- 2026-06-12 12:49 CST - New ASI has-inquiry missing-main queue: LP1277 `recuYsAdUpxzmv`: session `agent:global-trading-product:subagent:7844b231-c091-4e6b-af1b-fb7633f1510d`, run `10ad75a5-fa49-4fe2-a3b9-9dedd72e2c1a`.; LP1356 `recuYsAdUp4j8c`: session `agent:global-trading-product:subagent:7f8fc6fa-7c10-4785-845a-d2f4c0db7fa6`, run `39fa8069-3d11-48d7-b8f6-01557b844d6a`. [score=0.834 recalls=0 avg=0.620 source=memory/2026-06-12.md:13-14]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12.md:15:15 -->
- 2026-06-12 12:49 CST - New ASI has-inquiry missing-main queue: Current batch state is also recorded in `.temp/asi_has_inquiry_manifest/current_batch_20260612_1300.md`. Do not spawn a third product until one of these completes, blocks, or clearly exits. [score=0.834 recalls=0 avg=0.620 source=memory/2026-06-12.md:15-15]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12.md:16:19 -->
- 2026-06-12 12:49 CST - New ASI has-inquiry missing-main queue: User-specific operating rule for this run: at most 2 product-image subagents active at the same time; each subagent handles exactly one product. New products require new subagents.; Required pre-step per product: use the original `参考图片` only to generate a clean no-logo reference image; remove product logo artwork/logo patterns, brand marks, sample logos, imprints, manufacturer/platform marks, QR/watermark/contact/URL while preserving the exact real product. If the reference contains the plain text `YOUR LOGO`, keep that text.... [score=0.834 recalls=0 avg=0.620 source=memory/2026-06-12.md:16-19]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12.md:20:23 -->
- 2026-06-12 12:49 CST - New ASI has-inquiry missing-main queue: 2026-06-12 13:08 CST clarification: `HEARTBEAT.md` should be a compact event reminder for what to inspect, not a duplicate task history. Keep detailed product rules, worker handoffs, and status history in memory/progress/handoff files; keep heartbeat prompts short and pointer-based.; 2026-06-12 13:15 CST correction: do not hard-code current product numbers such as LP1277/LP1356 into heartbeat prompts for a queue task.... [score=0.834 recalls=0 avg=0.620 source=memory/2026-06-12.md:20-23]

## Promoted From Short-Term Memory (2026-07-03)

<!-- openclaw-memory-promotion:memory:memory/2026-06-28.md:12:15 -->
- 2026-06-28 11:07 Asia/Shanghai - Pre-compaction flush: LP3558: `LP3558_clean_no_logo.png`, `LP3558_white_background.png`, `LP3558_scene_01.png`, `LP3558_dimension_01.png`, `LP3558_material_detail_01.png`, `LP3558_hero_01.png`; LP3561: `LP3561_clean_no_logo.png`, `LP3561_white_background.png`, `LP3561_main_hero_logopress.png`, `LP3561_scene_outdoor.png`, `LP3561_selling_points.png`, `LP3561_size_diagram.png`, `LP3561_material_detail.png`, `LP3561_sku_colors.png`; LP3592: `LP3592_clean_no_logo.png`, `LP3592_white_background.png`, `LP3592_hero_main.png`, `LP3592_lifestyle.png`, `LP3592_selling_point.png`, `LP3592_dimension.png`,... [score=0.815 recalls=0 avg=0.620 source=memory/2026-06-28.md:12-15]
<!-- openclaw-memory-promotion:memory:memory/2026-06-27.md:4:7 -->
- 2026-06-27 00:10 CST - Pre-compaction flush: Active workspace: `/Users/vincent/.openclaw/workspace-logopress`; current Feishu direct conversation with account `logopress`.; User asked Oracle to open browser profiles for manual ChatGPT and Gemini login. ChatGPT/default Oracle profile was kept at `~/.oracle/browser-profile`; Gemini profile `~/.oracle/browser-profiles/gemini` was later deleted at user request. `oracle profile list` was reported as only `default`.; ASI product image flow was paused while handling Oracle login/profile cleanup. Current pending product: `LP3530 / recuYsANVGkAdM`.... [score=0.806 recalls=0 avg=0.620 source=memory/2026-06-27.md:4-7]
<!-- openclaw-memory-promotion:memory:memory/2026-06-27.md:8:9 -->
- 2026-06-27 00:10 CST - Pre-compaction flush: User requested syncing latest workspace code from GitHub `main` into this workspace. The workspace fetched `origin/main` and merge reported `Already up to date`; current branch remained `macmini`. Local uncommitted change to `TOOLS.md` was intentionally preserved.; Important workspace rule already in `TOOLS.md`: use `lark-cli --profile logopress ...`; primary Base token is `SF9ibzjI4a0YFJsDZtKcLvtbnfh`; table IDs include ASI商品表 `tbl1f731h82T86ag` and 商品表 `tbl3KNB7zP8EQ1d0`. [score=0.806 recalls=0 avg=0.620 source=memory/2026-06-27.md:8-9]
