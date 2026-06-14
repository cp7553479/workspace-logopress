# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## Credentials (`~/.openclaw/.env`)
- LLM Keys: `GEMINI_API_KEY`, `OPENROUTER_API_KEY`, `XAI_API_KEY`

## Local CLIs
- `openclaw`, `lark-cli`

## Spawnable Agents
- Spawn `customer-intent-insight` when analyzing customer intent, queries, or extracting structured requirements.
- Spawn `catalog-maker` when generating catalogs, styling PDFs, or formatting Notion catalog pages.
- Spawn `website-maker` when building, compiling, or deploying websites from product data.
- Spawn `takewaypack` when handling takeaway package workflows, pricing, or templates.
- Spawn `main` for general coordination or fallback routing outside specific domains.

## Tips & Notes
- **lark-cli uploads**: Do not use `--name`, use relative paths for `--file` (e.g., `./file.png`), and upload serially to avoid race conditions.
- **Feishu image replies**: Use `filePath="/path/to/img.png"` inside `message(action="send", ...)` to ensure images render correctly.
