# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

## 生图工具使用规则
- Oracle 必须使用 `--browser-manual-login` 模式（`--engine browser --browser-manual-login`）

- Oracle 和 Codex 必须**交替使用**，不要连续用同一个工具。例如：场景图用 Oracle → 卖点图用 Codex → 尺寸图用 Oracle → 材质图用 Codex，以此类推。
- 如果某个工具失败，换另一个工具重试。
- Oracle 必须串行排队，不可并发。
- 这条规则适用于所有电商套图生成任务。

## lark-cli Notes

- `base +record-upload-attachment` no longer accepts `--name` in current local runs, even though help may still list it. Omit `--name`; uploaded attachment names are derived from local file basenames.
- When uploading multiple files to the same Base attachment field, run `base +record-upload-attachment` serially. Parallel uploads can race and leave only part of the appended attachment list; if that happens, repair with the raw record update using the full intended attachment array.

---

Add whatever helps you do your job. This is your cheat sheet.
