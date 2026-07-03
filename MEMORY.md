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

## Promoted From Short-Term Memory (2026-07-04)

<!-- openclaw-memory-promotion:memory:memory/2026-06-28.md:16:19 -->
- 2026-06-28 11:07 Asia/Shanghai - Pre-compaction flush: LP3609: `LP3609_clean_no_logo.png`, `LP3609_white_background.png`, `LP3609_hero_logopress.png`, `LP3609_scene_party.png`, `LP3609_selling_points.png`, `LP3609_dimension.png`, `LP3609_material_detail.png`, `LP3609_sku_colors.png`; LP3611: `LP3611_clean_no_logo.png`, `LP3611_white_background.png`, `LP3611_00_hero_logo.png`, `LP3611_01_lifestyle.png`, `LP3611_02_selling_point.png`, `LP3611_04_material_detail.png`, `LP3611_05_sku_chart.png`; LP3624: `LP3624_clean_no_logo.png`, `LP3624_white_background.png`, `LP3624_hero_main.png`, `LP3624_lifestyle_scene.png`,... [score=0.869 recalls=0 avg=0.620 source=memory/2026-06-28.md:16-19]
<!-- openclaw-memory-promotion:memory:memory/2026-06-28.md:20:22 -->
- 2026-06-28 11:07 Asia/Shanghai - Pre-compaction flush: LP3665: `LP3665_clean_no_logo.png`, `LP3665_white_background.png`, `LP3665_hero.png`, `LP3665_lifestyle.png`, `LP3665_selling_point.png`, `LP3665_dimension.png`, `LP3665_material_detail.png`, `LP3665_sku.png`; LP3674: `LP3674_clean_no_logo.png`, `LP3674_white_background.png`, `LP3674_hero_logo.png`, `LP3674_scene.png`, `LP3674_selling.png`, `LP3674_dimension.png`, `LP3674_material.png`, `LP3674_sku.png`; 会话末尾已经 spawn 了一个新的子任务（call id `call_kxYPNql2gS8gZ7eiRcIFx1pi`），但上下文未显示它对应的商品号和结果；恢复后需先检查 session/live 状态，不要假设完成。 [score=0.869 recalls=0 avg=0.620 source=memory/2026-06-28.md:20-22]
<!-- openclaw-memory-promotion:memory:memory/2026-06-28.md:8:11 -->
- 2026-06-28 11:07 Asia/Shanghai - Pre-compaction flush: 最近一批已出现过的文件清单：; LP3548: `LP3548_clean_no_logo.png`, `LP3548_white_background.png`, `LP3548_hero.png`, `LP3548_lifestyle.png`, `LP3548_selling_point.png`, `LP3548_material_detail.png`, `LP3548_sku.png`; LP3549: `LP3549_clean_no_logo.png`, `LP3549-white-background.png`, `LP3549-main.png`, `LP3549-lifestyle.png`, `LP3549-selling_point.png`, `LP3549-size.png`, `LP3549-material.png`, `LP3549-sku.png`; LP3555: `LP3555_clean_no_logo.png`, `LP3555_white_background.png`, `LP3555_hero.png`, `LP3555_lifestyle.png`, `LP3555_selling_point.png`, `LP3555_material_detail.png` [score=0.869 recalls=0 avg=0.620 source=memory/2026-06-28.md:8-11]
<!-- openclaw-memory-promotion:memory:memory/2026-06-28.md:26:26 -->
- 2026-06-28 ASI image delivery preference: User explicitly requested: for every ASI product image task, send all generated images to the user each time. This includes clean no-logo reference, white-background image, and every generated 商品主图 image, not only selected final main images. If an expected image type is skipped, explain the skip reason in the visible message. [score=0.837 recalls=0 avg=0.620 source=memory/2026-06-28.md:26-26]
<!-- openclaw-memory-promotion:memory:memory/2026-06-28.md:4:7 -->
- 2026-06-28 11:07 Asia/Shanghai - Pre-compaction flush: 当前会话在处理商品图批量生成/回填/发送给用户。用户明确要求“图片要发我”，所以每完成一个商品后需要把图片发到当前飞书私聊，同时回填飞书多维表格。; 工作方式已调整为串行：进入下一条商品前先查 live 表状态，只启动一个新子任务，避免并发混乱。; 已完成并发送/回填的商品包括：LP3547、LP3548、LP3549、LP3555、LP3558、LP3561、LP3592、LP3600、LP3609、LP3611、LP3624、LP3657、LP3665、LP3674。早前上下文还显示 LP3535、LP3537 的图片文件清单已处理/发送过。; LP3547 特别备注：参考图片已替换为干净无 logo 图；白底图 1 张；商品主图 4 张（首图、场景图、卖点图、材质细节图）；尺寸图跳过，因为尺寸 `14 cm x 29 cm x 0 cm` 不完整；SKU 图跳过，因为只有可靠单色 Green。 [score=0.837 recalls=0 avg=0.620 source=memory/2026-06-28.md:4-7]
<!-- openclaw-memory-promotion:memory:memory/2026-06-29.md:3:4 -->
- Memory - 2026-06-29: Feishu group/product image workflow: User shared umbrella product images and requested repeated corrections. Key product requirement: umbrella interior/coating must be black for all color variants; only the exterior canopy should have multiple colors. User said the white variant looked correct, but other colors were not correct and needed continued modification.; Later in the same Feishu group thread, user asked: “请把这张图logo换一下，并上传到飞书表格，LP0342”. Work was performed after that request: the provided image was edited with a changed logo and uploaded/sent to the Feishu table entry/product code LP0342.... [score=0.837 recalls=0 avg=0.620 source=memory/2026-06-29.md:3-4]
<!-- openclaw-memory-promotion:memory:memory/2026-06-30.md:12:15 -->
- lark-cli / logopress profile recovery: User asked why `logopress` profile disappeared. Root cause found: ordinary terminal uses `~/.lark-cli/config.json` where `logopress` existed; OpenClaw environment uses `~/.lark-cli/openclaw/config.json`, which initially only had `wali-ge`.; The `logopress` app config was synchronized into the OpenClaw lark-cli config.... [score=0.837 recalls=0 avg=0.620 source=memory/2026-06-30.md:12-15]
<!-- openclaw-memory-promotion:memory:memory/2026-06-30.md:16:16 -->
- lark-cli / logopress profile recovery: Important workspace rule from TOOLS.md: all lark-cli commands here must use `lark-cli --profile logopress ...`; primary Base token is `SF9ibzjI4a0YFJsDZtKcLvtbnfh`. [score=0.837 recalls=0 avg=0.620 source=memory/2026-06-30.md:16-16]
<!-- openclaw-memory-promotion:memory:memory/2026-06-30.md:19:21 -->
- User auth request: User then requested: use the agent's Feishu-bound appid/appsecret to configure `logopress` profile and send a login link.; The assistant generated/sent `logopress-auth.png` in Feishu, apparently containing the login/auth QR or link for the user to authorize.; After this, continue by checking whether `lark-cli --profile logopress auth status` has user identity ready before doing user-token Base/Drive operations. [score=0.837 recalls=0 avg=0.620 source=memory/2026-06-30.md:19-21]
<!-- openclaw-memory-promotion:memory:memory/2026-06-30.md:24:25 -->
- Communication context: Current source is a Feishu direct chat under account/workspace `logopress`.; Normal final assistant messages are private in this environment; to make a visible Feishu reply, use OpenClaw message tool action=send if available/needed. [score=0.837 recalls=0 avg=0.620 source=memory/2026-06-30.md:24-25]
