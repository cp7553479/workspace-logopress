# Keep this file empty (or with only comments) to skip heartbeat API calls.

# Add tasks below when you want the agent to check something periodically.

## ASI supplement queue — prepared 2026-05-14 14:29 CST

Source: Feishu Base `KcXMbMUvAa7TNYsIqD7cwNi1nDf`, table `商品线索表` (`tblsVUTaYTcvp8F5`), verified by `lark-cli` on 2026-05-14.  
Target for this supplement queue: bring `商品主图` to **at least 5 images** per product unless the main agent/user changes the target.

| Priority | Product | Record ID | 参考图片 | 白底图 | 商品主图 now | 商品主图 still needed | Readiness |
|---:|---|---|---:|---:|---:|---:|---|
| 1 | LP0895 | recuVc7MkexdNw | 1 | 1 | 2 | 3 | Prepared temp dir + `raw_record.json`: `temp/LP0895_asi_recuVc7MkexdNw/` |
| 2 | LP0041 | recuLkTk2gzmDx | 1 | 1 | 3 | 2 | Prepared temp dir + `raw_record.json`: `temp/LP0041_asi_recuLkTk2gzmDx/` |
| 3 | LP0105 | recuLl0udHsSro | 1 | 1 | 3 | 2 | Ready; create/check temp dir before generation |
| 4 | LP7302 | recvcuTKgWANVm | 1 | 1 | 3 | 2 | Ready; create/check temp dir before generation |
| 5 | LP7303 | recvcuTLLHSBPg | 1 | 1 | 3 | 2 | Ready; create/check temp dir before generation |
| 6 | LP0109 | recuLl0IXOC88J | 1 | 1 | 4 | 1 | Existing dir found: `temp/LP0109_asi_recuLl0IXOC88J/` |
| 7 | LP0125 | recuLl2DDncFD1 | 1 | 1 | 4 | 1 | Ready; create/check temp dir before generation |
| 8 | LP0257 | recuLlaWQZyzDV | 1 | 2 | 4 | 1 | Ready; create/check temp dir before generation |
| 9 | LP0873 | recuVc6ojzYH1S | 1 | 1 | 4 | 1 | Ready; create/check temp dir before generation |
| 10 | LP5826 | recuYsBlcD8hT0 | 1 | 1 | 4 | 1 | Ready; create/check temp dir before generation |
| 11 | LP7291 | recvcuT9WSiXKx | 1 | 1 | 4 | 1 | Existing dir found: `temp/LP7291_asi_recvcuT9WSiXKx/` |

### Separate white-background follow-up

| Product | Record ID | 参考图片 | 白底图 now | 商品主图 now | Needed |
|---|---|---:|---:|---:|---|
| LP0056 | recuLkUQiusLGL | 1 | 0 | 5 | Generate/upload 1+ `白底图`; 商品主图 count is already 5. |

Notes:
- No Oracle/image generation/uploads/Feishu writes were run during this audit.
- For the first two highest-priority supplement products, local folders now contain `references/`, `outputs/`, `uploads/`, and `raw_record.json` only.
