---
name: cron-heartbeat-watcher
description: Maintain OpenClaw scheduled-work guardrails for cron jobs, heartbeat polling, and HEARTBEAT.md task lists. Use when you think recurring checks, reminders, proactive assistant behavior, OpenClaw cron, heartbeat settings, interval task blocks, cleanup of obsolete heartbeat work, or a task that needs a later agent turn to complete may be needed.
---

# 定时与心跳守卫

Use this skill to choose between OpenClaw cron and heartbeat, configure the chosen mechanism, and keep `HEARTBEAT.md` small enough to be safe in periodic prompt context.

## Before changing schedules

Before editing config or `HEARTBEAT.md`, question the timing assumption:

- Does this require exact wall-clock delivery or is approximate polling acceptable?
- Does the task need recent main-session context?
- Should output be delivered externally, kept internal, or folded into the next heartbeat?
- Does the task need isolation, a different model, or a different thinking level?

## Decision rule

Use heartbeat when:

- Multiple checks can batch together in one model turn.
- Recent conversational context matters.
- Timing can drift slightly.
- You want to reduce API calls by combining periodic checks.
- A task should continue in a later agent turn and exact timing is not required.

Use cron when:

- Exact timing matters.
- The task should run isolated from main session history.
- The task needs a different model or thinking level.
- The request is a one-shot reminder.
- Output should deliver directly to a channel or webhook without main-session involvement.

Prefer a `HEARTBEAT.md` `tasks:` block for multiple low-precision periodic checks. Prefer cron for precise schedules and standalone work.

Before creating cron, evaluate whether the job needs contextual background to execute correctly:

- If it depends on current conversation state, project state, unresolved commitments, or other session-local background, deliver it to the correct session.
- If you know the exact current session key, prefer `--session "session:<sessionKey>"` over `--session current` to avoid binding or fallback surprises.
- If you do not know the session key, choose between `--session main` and `--session current` deliberately. Use `main` for main-session heartbeat/system-event reminders; use `current` only when binding to the active creation-time session is acceptable.
- Use `--session isolated` only when the cron task is self-contained or intentionally should not inherit conversation context.

## Heartbeat configuration

Heartbeat runs periodic agent turns. Defaults are `30m`, or `1h` for Anthropic OAuth/token auth setups. Set `every: "0m"` to disable.

Typical `~/.openclaw/openclaw.json` shape:

```js
{
  agents: {
    defaults: {
      heartbeat: {
        every: "30m",
        target: "last",
        directPolicy: "allow",
        lightContext: true,
        isolatedSession: true,
        // activeHours: { start: "08:00", end: "23:00", timezone: "Asia/Shanghai" },
        // includeReasoning: true,
      },
    },
  },
}
```

Key fields:

- `every`: heartbeat cadence; use `0m` to disable.
- `target`: `none` runs silently, `last` routes to the last external contact, or use an explicit channel.
- `to`: optional recipient override for the target channel.
- `directPolicy`: `allow` or `block` for direct/DM delivery.
- `lightContext`: inject only lightweight bootstrap context, especially `HEARTBEAT.md`.
- `isolatedSession`: use fresh sessions to reduce per-heartbeat token cost.
- `activeHours`: skip runs outside the configured local window.
- `prompt`: overrides the default prompt; keep it strict and small.

Default prompt contract:

```text
Read HEARTBEAT.md if it exists (workspace context). Follow it strictly. Do not infer or repeat old tasks from prior chats. If nothing needs attention, reply HEARTBEAT_OK.
```

Manual wake:

```bash
openclaw system event --text "Check for urgent follow-ups" --mode now
```

## HEARTBEAT.md format

Use this exact top-level task block for interval checks:

```yaml
tasks:

- name: inbox-triage
  interval: 30m
  prompt: "Check for urgent unread emails and flag anything time sensitive."
- name: calendar-scan
  interval: 2h
  prompt: "Check for upcoming meetings that need prep or follow-up."
```

Rules:

- Keep task names stable, lowercase, and slug-like.
- Use only `name`, `interval`, and `prompt`.
- Keep prompts concrete, short, and safe. Do not include secrets.
- Put optional human-readable notes after the `tasks:` block under a short heading such as `# Additional instructions`.
- OpenClaw parses each task interval, includes only due tasks in that heartbeat prompt, and skips the heartbeat entirely when no tasks are due.
- Structured task timestamps are stored in session state as `heartbeatTaskState`; do not duplicate that state manually.
- On heartbeat polls, do useful work from due tasks or short `HEARTBEAT.md` reminders; reply `HEARTBEAT_OK` only when nothing needs attention.
- Keep `HEARTBEAT.md` small to limit token burn. Edit it to add or remove short checklists and reminders.
- Rotate broader checks 2-4 times per day when relevant: urgent email, calendar events in the next 24-48h, mentions/social notifications, and weather if the human may go out.
- Reach out for important email, calendar events within 2h, interesting findings, or more than 8h of silence.
- Stay quiet with `HEARTBEAT_OK` late at night (23:00-08:00) unless urgent, when the human is clearly busy, when nothing changed, or when the same area was checked less than 30 minutes ago.
- Proactive heartbeat work can include organizing memory files, checking project status such as `git status`, updating documentation, committing and pushing your own changes, and reviewing `MEMORY.md`.
- If manually rotating checks outside `tasks:`, store lightweight timestamps in `memory/heartbeat-state.json`.

Example state file for manual rotations:

```json
{
  "lastChecks": {
    "email": 1703275200,
    "calendar": 1703260800,
    "weather": null
  }
}
```

Cleanup rule:

- Remove completed or obsolete task entries immediately.
- If no heartbeat work remains, clean `HEARTBEAT.md` so it contains no meaningful heartbeat instructions or tasks. Prefer an absent or effectively empty file over stale reminders.
- If the user asks to stop heartbeat runs entirely, set heartbeat `every` to `"0m"` in OpenClaw config, then clean `HEARTBEAT.md`.

## Cron configuration

Cron is the Gateway scheduler. Jobs persist in `~/.openclaw/cron/jobs.json`, and cron executions create background task records.

Schedule types:

- `--at`: one-shot timestamp or relative delay such as `20m`.
- `--every`: fixed interval.
- `--cron`: 5-field or 6-field cron expression; use `--tz` for wall-clock timezone.

Session choices:

- First decide whether the cron job needs session context. Context-dependent cron jobs should be routed to the specific session that owns the needed background.
- If `--session` is omitted, OpenClaw infers `isolated` for `--message` agent-turn jobs and `main` for `--system-event` jobs. `current` is explicit, not the default.
- If the current session key is known, pass `--session "session:<sessionKey>"` manually for context-dependent work.
- If you are operating from the main session and want the job to return through the main heartbeat/session path, pass `--session main` explicitly and use `--system-event`.
- `--session main`: enqueue a system event into the main session, often with `--wake now` or `--wake next-heartbeat`.
- `--session isolated`: run a dedicated `cron:<jobId>` session with a fresh transcript.
- `--session current`: bind to the active session at creation time. During create normalization, OpenClaw stores this as `session:<current-session-key>` when a session key is available; without a session key, such as a bare terminal CLI call, it falls back to `isolated`.
- `--session session:<id>`: pin to an explicit persistent session key.

Examples:

```bash
# One-shot main-session activation check, auto-delete after success
openclaw cron add \
  --name "Subagent activation check" \
  --at 1m \
  --session main \
  --session-key "<sessionKey>" \
  --system-event "检查 xxx subagent 是否运行正常" \
  --wake now \
  --delete-after-run
```

Config shape:

```js
{
  cron: {
    enabled: true,
    store: "~/.openclaw/cron/jobs.json",
    maxConcurrentRuns: 1,
    sessionRetention: "24h",
    runLog: { maxBytes: "2mb", keepLines: 2000 },
  },
}
```

Disable cron with `cron.enabled: false` or `OPENCLAW_SKIP_CRON=1`.

Diagnostics:

```bash
openclaw status
openclaw gateway status
openclaw cron status
openclaw cron list
openclaw cron show <job-id>
openclaw cron run <job-id>
openclaw cron runs --id <job-id> --limit 20
openclaw system heartbeat last
openclaw logs --follow
openclaw doctor
```
