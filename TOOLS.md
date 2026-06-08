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

## lark-cli Notes

- `base +record-upload-attachment` no longer accepts `--name` in current local runs, even though help may still list it. Omit `--name`; uploaded attachment names are derived from local file basenames.
- `base +record-upload-attachment --file` may reject absolute paths as unsafe. `cd` to the output directory and pass `--file ./filename.png`.
- In some local runs, `base +record-upload-attachment` also rejects `--json` and `--format` even when help lists them. Use the default output form and redirect/tee it if an upload receipt needs to be saved.
- When uploading multiple files to the same Base attachment field, run `base +record-upload-attachment` serially. Parallel uploads can race and leave only part of the appended attachment list; if that happens, repair with the raw record update using the full intended attachment array.

## OpenClaw Plugin Notes

- `session-auto-continue` lives at `~/.openclaw/extensions/session-auto-continue`. It is an OpenClaw hook-only extension that keeps sessions running until final assistant text contains `SESSION_OK`.
- Verify it with `npm test` in that directory and `openclaw plugins inspect session-auto-continue --runtime --json`.

## Feishu message tool notes

- In this OpenClaw Feishu channel, sending a local image with `message(action="send", media=...)` or `image=...` may produce a text-only message. Use `filePath` with a normal `message`, for example `message(action="send", message="说明", filePath="/abs/path/image.png")`; receipt should show `kind:"media"`.

---

Add whatever helps you do your job. This is your cheat sheet.
