# MEMORY.md - Long-Term Memory

## Workspace
- Agent: global-trading-product (logopress workspace)
- Host: Vincent's MacBook Air (macOS, arm64)
- Git auto-syncs with macmini remote
- Skills: add-product, quotation, inquiry, new-pi, print-pi, asi-product-image-generator, asi-xid-sync, generate-white-background, cron-heartbeat-watcher, and more

## Key Facts
- Workspace uses Feishu (飞书) multi-dimensional tables for product management
- Product table (商品表) and PI table are core data sources
- ASI product image generation pipeline exists for e-commerce photos
- Quotation and PI (Proforma Invoice) workflows are established

## Lessons Learned
- (none yet)

## People
- Vincent: workspace owner

## Notes
- Initialized memory infrastructure on 2026-07-14

## Promoted From Short-Term Memory (2026-07-22)

<!-- openclaw-memory-promotion:memory:memory/2026-07-17.md:7:8 -->
- Oracle/ChatGPT browser mode has recurring `ECONNREFUSED 127.0.0.1:<port>`, manual-login-session timeout, and no-output failures. Treat this as a browser-session availability issue, preserve validated work, and resume from the checkpoint after confirming the second profile is logged in. - Operational rules and per-product checkpoints live in `HEARTBEAT.md`, `task-progress.md`, and each product's `.temp/LPxxxx_asi_<record_id>/` handoff files. HEARTBEAT includes a five-minute recovery audit covering worker state, Base state, cooling/retry timing, and exclusive write ownership. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-17.md:7-8]
<!-- openclaw-memory-promotion:memory:memory/2026-07-17.md:12:15 -->
- 2026-07-17 11:54 CST — corrected pipeline checkpoint: The older entries above are superseded where they conflict with this checkpoint: the Oracle `second` browser profile was deleted. All future Oracle work must use only the `default` profile; do not recreate or use `second`.; Fully closed and slot-released products: LP0747 and LP0749.; LP0750 remains an active slot, blocked at the clean-logo-reference step. Oracle `default` did not detect a valid ChatGPT login session; Gemini subsequently terminated when its WebSocket closed. No output was generated, uploaded, or written to Base in this retry.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-17.md:12-15]
<!-- openclaw-memory-promotion:memory:memory/2026-07-17.md:16:16 -->
- 2026-07-17 11:54 CST — corrected pipeline checkpoint: Therefore, do not dispatch LP0752 or later yet: LP0750 and LP0751 still occupy the two unfinished-product slots. Continue the five-minute audit and recover stalled work without duplicate workers or concurrent attachment writes. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-17.md:16-16]
<!-- openclaw-memory-promotion:memory:memory/2026-07-17.md:27:30 -->
- 2026-07-17 20:13 CST — latest ASI pipeline and delivery checkpoint: Supersedes earlier pipeline status where inconsistent. The active global objective remains: continuously process LogoPress ERP `商品表` entries where 商品主图 is empty and 参考图片 is present; one worker per product, at most two concurrent products, complete the ASI asset set, validate, write back and read back, then deliver accepted images to Vincent.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-17.md:27-30]
<!-- openclaw-memory-promotion:memory:memory/2026-07-17.md:20:23 -->
- 2026-07-17 13:13 CST — current pipeline checkpoint: This checkpoint supersedes conflicting earlier entries. Fully closed and slot-released products are LP0747, LP0749, LP0751, and LP0750. LP0750’s last two assets—the two-color SKU image and final Hero—were accepted, written to Base, read back, reverse-SHA verified, and delivered; its evidence is in `.temp/LP0750_asi_recuRcKFugmc2D/handoff.md`.; LP0752 is the sole currently occupied slot. Its clean reference, three color white-background images, scene image, and selling-point image were accepted, written to Base, read back, SHA verified, and delivered.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-17.md:20-23]
<!-- openclaw-memory-promotion:memory:memory/2026-07-17.md:3:6 -->
- Ongoing ASI product-image pipeline: keep exactly two active, unfinished product slots. When one closes its full loop, immediately query the LogoPress ERP 商品表 for the next eligible product (empty main image and a reference image; exclude completed/in-progress) and assign one dedicated worker. - Each product requires generation, acceptance review, Feishu Base write-back, read-back/SHA verification, and individual image delivery. Never skip those stages; only one worker may write a product's attachments. - Image fidelity is paramount: do not invent, alter, redraw, or omit real product structure, quantities, labels, or details.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-17.md:3-6]

## Promoted From Short-Term Memory (2026-07-23)

<!-- openclaw-memory-promotion:memory:memory/2026-07-18.md:14:17 -->
- 调度规则修正与最新状态: LP0939 已于 2026-07-18 全部完成并回填核验：最终 revision 9208；干净无标识参考图、白底图、场景图、最终首图、卖点图和尺寸图均已生成写入。尺寸图参数已核实为 5.12 / 4.72 / 3.15 英寸，视觉核验通过。证据仍在 `.temp/LP0939_asi_recuYsAdUpvvx9/STATUS.md`。已完成并回填核验总数应更新为 32。; 用户明确纠正派单方式：主调度者必须先选定并固定一个具体商品，再创建任务；子任务正文必须明确限定“只处理 LPxxxx，record_id=xxxx”，不得自行从商品表筛选、挑选、替换或猜测目标商品，也不得触碰其他记录。; 派发前必须持久记录商品编号、record_id、当前记录版本和参考图附件 token，并为该商品建立唯一占用；同一商品任一时刻仅允许一个执行流。重试前必须确认旧会话结束并释放占用；最多两个子任务时也必须为两个不同且已指定的商品。; 上述持续执行、心跳恢复、单商品唯一占用和明确派单约束已写入 `HEARTBEAT.md`；它是后续心跳恢复时应读取的持久任务配置。完成后主调度者回读核验、释放占用，然后才选定下一件商品。 [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-18.md:14-17]
<!-- openclaw-memory-promotion:memory:memory/2026-07-18.md:29:32 -->
- 20:15 最新续态: 已完成且回填核验的数量更新为 38；在既有清单基础上，LP0943、LP0944、LP0945 也已完成核验。LP0945 已写入干净参考图、白底图及 3 张商品主图；尺寸数据为无效 0，按规则未虚构尺寸图。其唯一占用已释放；图片 IM 发送仍因飞书资源权限失败。; LP0943、LP0944 当前均为安全暂停：已完成干净参考图和白底图回填，但场景候选分别改变了口罩形状、真实产品结构/编号，均被拒绝且未上传；两个商品的调度锁都已释放。证据分别在 `.temp/LP0943_asi_recuYsA4H0GMbk/STATUS.md`、`.temp/LP0944_asi_recuYsA4H0xS9t/STATUS.md`。; LP0946（record_id `recuYsA1RQLnv8`）安全暂停：已写入干净参考图 token `NLcubY7xBoNSZGx18OmcV1UKn4e` 与白底图 token `KNsUbseTho9XBix9akncdIUBnMd`，最终回读 revision 9236；场景候选含违规文字和虚构卖点，已拒绝，后续重试也未产生有效文件，故未写任何商品主图。干净参考图和白底图已成功发送给用户。该商品的调度锁尚未释放，重试前须先确认基线/策略并妥善处理此锁；当前没有运行子任务，另有 2 个并行槽空闲。; LP0946 的一次跨会话“完成”通知是过期重复投递，已按冲突规则忽略，不能据此释放锁或改变远端状态。 [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-18.md:29-32]
<!-- openclaw-memory-promotion:memory:memory/2026-07-18.md:3:6 -->
- 2026-07-18 — ASI 商品套图批处理状态: 目标：为 LogoPress ERP「商品表」中“商品主图为空、参考图片不为空”的商品生成 ASI 套图。每件必须先回读基线、避免并发覆盖；每次只处理一个商品、最大并行 2。所有执行者都须遵守 `skills/asi-product-image-generator/SKILL.md`。; 当前安全策略：每 30 分钟先做只读稳定性检查；仅在 LP0767/LP0768 遗留 Oracle 活跃进程消失、候选商品连续回读稳定后，才恢复单件派发。相关配置已写入 `HEARTBEAT.md`。; 2026-07-18 已完成全量队列审计：扫描 5,536 条云过滤记录，未排除记录，未修改 Base。LP0939、LP0940、LP0941 两次回读稳定，但因上述遗留进程仍暂停补派。; 已完成并回填核验通过共 31 个：LP0754、LP0755、LP0759、LP0760、LP0761、LP0763、LP0764、LP0771、LP0783、LP0774、LP0795、LP0785、LP0792、LP0909、LP0821、LP0823、LP0825、LP0833、LP0835、LP0834、LP0839、LP0842、LP0848、LP0850、LP0851、LP0846、LP0916、LP0931、LP0974、LP2146。 [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-18.md:3-6]
<!-- openclaw-memory-promotion:memory:memory/2026-07-18.md:25:25 -->
- 09:44 调度续态: LP0941（record_id `recuYsAdUpGLvG`）已完成并最终回读核验：revision 9221；已回填干净无标识参考图、白底图，以及生活场景图、卖点图和最终首图 3 张商品主图。因无可靠尺寸数据，尺寸图按规则跳过；4 张图片已成功发送给飞书用户。完成用的唯一占用已释放。 [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-18.md:25-25]
<!-- openclaw-memory-promotion:memory:memory/2026-07-18.md:7:10 -->
- 2026-07-18 — ASI 商品套图批处理状态: LP0939 已推进至部分完成，最终回读 revision 9206：已替换唯一干净无标识参考图，并回填白底图、场景图及最终首图；首图视觉检查含 `YOUR LOGO` 和 `LogoPress`。卖点图、尺寸图尚未生成，后续必须以当前附件 token 为新基线继续。证据：`.temp/LP0939_asi_recuYsAdUpvvx9/STATUS.md`。; 典型暂停状态：LP0935 无远端写入；LP0936 在并发变化前已写入参考图、白底图、商品主图，后续暂停；LP0938 因参考 revision 9200→9201 变化安全暂停、无远端副作用。其它暂停/冲突商品的证据均在对应 `.temp/LP<编号>_asi_recu*/STATUS.md`。; 图片发送已改用飞书原生 IM 路径；大多数历史发送仍因缺 `im:resource:upload` / `im:resource` 权限失败，但 Base 附件回填不受此影响。仅 LP0823、LP0839、LP0916 发送成功。; 后续优先事项：继续心跳只读巡检遗留 Oracle 进程与稳定候选；进程消失后先安全恢复 LP0939 的卖点图、尺寸图，再按审计队列单件处理。任务全部完成时清空 `HEARTBEAT.md`。 [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-18.md:7-10]
<!-- openclaw-memory-promotion:memory:memory/2026-07-18.md:21:24 -->
- 09:44 调度续态: 经复核，LP0767/LP0768 的 Oracle 记录是陈旧状态而非仍在运行的进程，遗留活跃进程已确认消失；此前据此暂停补派的判断已纠正。; LP0940 已按当前基线重新建立唯一占用并有一个指定子任务在运行（仅此商品）。该商品此前已安全完成干净无标识参考图替换（token `JeBDb7mh7oako9x4emMcry9cnVc`）及白底图回填（token `AbTLbitqCoW3vjxYXOqchUJpnAb`）；当前任务只补齐场景图、卖点图、尺寸图与最终首图。初次因误判 Oracle 残留会话而暂停，现已修正且旧占用已释放再锁定。; 当前占用 1 个并行槽位、另有 1 个空闲槽位；在 LP0940 完成后必须先回读核验、释放该商品占用，再按 HEARTBEAT.md 的锁定与稳定性规则继续派单。; LP0940（record_id `recuYsAdUpWP3N`）已完成：4 张商品主图已回填并最终回读核验，基线干净参考图与白底图未变；2026-07-18 已通过 OpenClaw message 在飞书会话向文森-练物-超级管理员成功发送图片。完成用的 LP0940 唯一占用已释放。 [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-18.md:21-24]
