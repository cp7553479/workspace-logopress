tasks:

- **Conflict-baseline correction:** Bitable attachment `rev` is table-level permission metadata and may increase when any record changes. Do not stop a product task merely because this value changed. Lock and compare the assigned record's protected attachment tokens, attachment counts, and field states. After every expected own write, immediately re-read the record and make the observed field state the next baseline; stop only on an unexpected assigned-record field change.

- name: asi-image-queue-supervisor
  interval: 10m
  prompt: "主动检查 ASI 商品套图队列：检查 native subagent、Oracle/生图进程、占用锁、任务目录状态和对应 Base 记录。仅主会话可筛选候选商品和对外发送；派发前双读确认候选商品（商品主图为空且参考图片不为空）的远端基线，并固定单一 LP 编号、record_id、当前记录版本和参考图片附件 token，建立唯一占用锁。每个 handoff 必须只指定该 LP 与 record_id；subagent 禁止自行筛选、替换或猜测商品，禁止触碰其他记录，仅回报文件路径、Base 回填 token、验收证据和 blocker。每个产品同时只能有一个执行流；旧流程确认结束、主会话验收并释放锁后才可重试。最多并行两个不同且已锁定的商品；写入前后回读 Base，基线或参考 token 变化即停止并保存冲突证据。右下角出现闪光图形标记或四角星标记的生成图可视为合格，不能仅因该标记拒绝；此为验收规则，严禁把它写入任何生图提示词。subagent 一旦产生合格图片即立即回报主会话；主会话须先独立回读 Base，确认相应字段和附件 token 已上传且符合预期，再立即向用户发送该图片，并逐次记录发送成功或失败证据。若回读不一致，或图片上传/IM 发送因权限或其他原因失败，立即向用户明确报告，绝不声称已交付；留存证据后继续其余处理。对已结束 worker 立即独立回读验收、更新状态、释放锁，并立刻补派空闲槽位；主会话等待 worker 返回，不得派出后直接结束调度循环。"

# Interrupted-task recovery

- **LP1035 / recuYsA1RQjQ03:** completed, independently verified, delivered, and released. The record has one clean reference, three verified white-background images, and four verified product-main images; do not re-dispatch it as an empty-main-image candidate.
- **LP1033 / recuYsA1RQ7NOK:** completed, independently verified, delivered, and released. The record retains its sole clean reference and five white-background attachments, and has six verified product-main images: scene, selling-point, size, detail, five-color SKU, and `YOUR LOGO` hero. Do not re-dispatch it as an empty-main-image candidate.
- **LP0984 / recuYsA4H00tsL:** completed, independently verified, delivered, and released. The record preserves its accepted hero and now has verified scene `UZ1IbHUgbok6SpxyiHTcZipmn3e` and selling-point `Iu0mbikOhoZIRIx6cICcnfPtnag` images; do not re-dispatch it as an empty-main-image candidate.
- LP0985 and LP0852 are completed, verified, delivered, and released; they are not recovery candidates.
- **LP1255 / `recuYsA1RQVb91`:** completed, independently verified, delivered, and released. Dimensions replacement token `WrcKbBxqrooIXuxshOTcr4wjnvC` is now in `商品主图`; obsolete `PxScbYH8gofg0CxGUYGcuBajnrg` removed. Final main images: lifestyle `QLbJbKuFPowG0pxftdec6OQ9nln`, SKU `NvcFb18vXo5qMFxCxrscT0ZznH4`, dimensions `WrcKbBxqrooIXuxshOTcr4wjnvC`, hero `ZyGhbohJioPWsJxRlMocdbBbnpg`. Do not re-dispatch.
- **LP1265 / `recuYsA1RQy4Jk`:** completed, independently verified, delivered, and released. Clean ref `JlzVbQB12oao63xomaGc1OXvngg`, white `RluubM8q1onQ1txBjT9c5GHGnDb`, main 3 (lifestyle `E23bbBYlWomzKrxgBOUc0RHSnjU`, size `XYFmbkfbFo8XZSxQmZlcMQhYn9e`, hero `F3wHbVY6NoRMIoxMCBbcY5u3n6e`). Do not re-dispatch.
- **LP0994 / `recuYsA1RQAEsQ`:** completed, independently verified, delivered, and released. Clean ref `D5BFbJD78ow647xczBec4uu9nmc`, white `Zc5UbTBrcoA52rxvs9ocuYwtncd`, main 3 (lifestyle `WrDlbWaUQoqajtx6RE2cLiUMnEc`, dimensions `QKepbvp4BoEVuvxcQfmci2OQnwg`, hero `DTSRb5dgPoFk4axmuM3cKLrhnqh`). Do not re-dispatch.
- **LP2191 / `recuYsA1RQlVts`:** Blocked 2026-07-20. All permitted generators failed: Oracle ChatGPT CLI rejects `--profile` on 0.16.0, Oracle Gemini hit image-limit reset, Codex `gpt-image-2` auth OK but `image_edits` returned `TypeError: fetch failed` from the ChatGPT backend. Reference `HbsOb1pJRovKdwxv0bsc97rnnWb` unchanged; white/main still empty. Lock preserved. Needs a different generator path or user direction before retry.

# ASI 商品主图持续生成

主调度持续处理 LogoPress ERP「商品表」中“商品主图为空、参考图片不为空”的商品。仅主会话筛选候选、指定产品并向用户/外部发送。每次派发前必须固定产品编号、`record_id`、当前远端记录版本和参考图附件 token，并建立唯一占用锁。所有正式子任务使用 `sessions_spawn`，`runtime: "subagent"`；handoff 必须只指定一个 LP 编号和 `record_id`，subagent 禁止自行筛选、替换或猜测商品，禁止触碰其他记录，且只能向主调度回报本地文件路径、附件 token、验收证据和 blocker。每个产品同时只允许一个执行流；重试前必须确认旧流程已结束，主调度完成回读验收、状态记录并释放锁。最多并行两个不同且已锁定的商品。写入前后都必须回读 Base；基线或参考 token 变化则暂停，不能覆盖。若生成图右下角出现闪光图形标记或四角星标记，视为可接受，不能仅据此拒绝；这是验收规则，绝不能写入生图提示词。subagent 一旦产生合格图片即回报主会话；主会话独立回读确认该字段和附件 token 已确实上传且符合预期后，立即向用户发送图片，并记录每次发送成功/失败证据。Base 回读不一致或图片上传/IM 发送失败时，立即明确告知用户，不得声称已交付；记录证据后继续其余工作。worker 结束后主调度立即独立验收、释放占用并补派空闲槽位；主会话必须等待 subagent 返回，不能在派出后结束调度循环。所有符合条件的商品完成后清空本文件。
