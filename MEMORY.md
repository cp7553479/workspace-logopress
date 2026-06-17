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

## Promoted From Short-Term Memory (2026-06-17)

<!-- openclaw-memory-promotion:memory:memory/2026-06-13.md:19:19 -->
- ASI image queue update - 00:25: Context: LP1559 subagent completed and parent reviewed the result. [score=0.833 recalls=0 avg=0.620 source=memory/2026-06-13.md:19-19]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12-1218.md:13:16 -->
- Conversation Summary: assistant: LP2575_dimension_chart_codex.png assistant: LP2575_selling_point_oracle_chatgpt.png assistant: LP2575_material_detail_codex.png assistant: LP2575_dimension_chart_codex.png [score=0.832 recalls=0 avg=0.620 source=memory/2026-06-12-1218.md:13-16]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12-1218.md:17:20 -->
- Conversation Summary: assistant: LP2575_material_detail_codex.png assistant: LP2575 已完成收口：5 张商品主图已上传、回读核验并全部发给你；参考图片 1 张、白底图 1 张、商品主图 5 张，无重复。SKU 图因只有 custom color 且没有确认多 SKU，已跳过。进度表已标记 completed，当前 running=0、retry_queue=0；HEARTBEAT.md 已按规则清空。 assistant: LP2575 已完成：5 张主图已发，Base 已核验无重复；进度表 completed，当前 running=0，HEARTBEAT.md 已清空。 assistant: LP2575_material_detail_codex.png [score=0.832 recalls=0 avg=0.620 source=memory/2026-06-12-1218.md:17-20]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12-1218.md:21:24 -->
- Conversation Summary: user: [message_id: om_x100b6d82ff4288b8c3635954383ff06] 陈鹏: ⚠️ Cron job "asi-subagent-watch-current-session" failed: cron: isolated agent setup timed out before runner start ⚠️ Cron job "asi-subagent-watch-current-session" failed: GatewayTransportError: gateway timeout after 10000ms Gateway target: ws://127.0.0.1:18789 [score=0.832 recalls=0 avg=0.620 source=memory/2026-06-12-1218.md:21-24]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12-1218.md:25:28 -->
- Conversation Summary: Source: local loopback Config: /Users/vincent/.openclaw/openclaw.json Bind: loopback ⚠️ Cron job "asi-subagent-watch-current-session" failed: cron: isolated agent setup timed out before runner start [score=0.832 recalls=0 avg=0.620 source=memory/2026-06-12-1218.md:25-28]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12-1218.md:3:5 -->
- Session: 2026-06-12 12:18:39 GMT+8: **Session Key**: agent:global-trading-product:main; **Session ID**: c23f2cdc-3b02-42d0-914e-b259d962eb17; **Source**: feishu [score=0.832 recalls=0 avg=0.620 source=memory/2026-06-12-1218.md:3-5]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12-1218.md:9:12 -->
- Conversation Summary: assistant: LP2575_lifestyle_scene_codex.png assistant: LP2575_hero_main_codex_LOGO-BK.png assistant: LP2575_selling_point_oracle_chatgpt.png assistant: LP2575_lifestyle_scene_codex.png [score=0.832 recalls=0 avg=0.620 source=memory/2026-06-12-1218.md:9-12]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12-1235.md:3:5 -->
- Session: 2026-06-12 12:35:37 GMT+8: **Session Key**: agent:global-trading-product:main; **Session ID**: 866bd676-5332-4f5a-a16b-fbf7762f53cb; **Source**: feishu [score=0.832 recalls=0 avg=0.620 source=memory/2026-06-12-1235.md:3-5]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12-1255.md:3:5 -->
- Session: 2026-06-12 12:55:34 GMT+8: **Session Key**: agent:global-trading-product:main; **Session ID**: 1eb054dc-b31a-4f18-9e0f-a144edb27c82; **Source**: feishu [score=0.832 recalls=0 avg=0.620 source=memory/2026-06-12-1255.md:3-5]
<!-- openclaw-memory-promotion:memory:memory/2026-06-12-1255.md:9:11 -->
- Conversation Summary: user: [message_id: om_x100b6d8cb5064cb4c38b7ca82e3f360] 陈鹏: 筛选商品表的Mark字段是 有询单 的并且商品主图是没有图片文件的商品，分别生成asi商品套图，需要每个商品派生独立subagent处理，派生时要求写清楚任务要求，要求使用oracle的chagpt和gemini交替生图，只有在出错时才使用codex生图，并且下一张图片还要先测试一下oracle是否已恢复只有ORACLE还没恢复才使用codex生图。先将 参考图片 的图片使用生图工具消除商品上的logo图案（保留“YOUR LOGO"文字），替换掉参考图片上的图片文件（替换非新增），然后使用新生成的参考图片继续进行asi商品套图的生图任务（阅读具体的skill）。记住你每次只能同时派生2个subagent，每个subagent只能处理一个产品，新的产品需要新的subagent来处理，你需要在HEARTBEAT.md里面写下检查任务进度和subagent状态，长时间无响应的subagent要发消息催促一下，记录你的任务要求进度和状态进memory/，随时更新update_plan。 assistant: 收到。我先读取商品表/图片生成相关流程，筛出符合条件的商品，然后按每次最多 2 个子任务推进；同时会把进度写入 HEARTBEAT.md 和 memory。 [score=0.832 recalls=0 avg=0.620 source=memory/2026-06-12-1255.md:9-11]
