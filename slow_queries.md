# Slow Query Report

| Query | Calls | Mean execution (ms) | Main bottleneck | Action |
|---|---:|---:|---|---|
| ___ | ___ | ___ | ___ | ___ |

## Investigation checklist
- Run `EXPLAIN (ANALYZE, BUFFERS)`.
- Check Sequential Scan vs Index Scan.
- Check row estimates vs actual rows.
- Check Sort, Hash Join, Nested Loop and buffer reads.
- Test indexes only when justified by the workload.
