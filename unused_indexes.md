# Unused Index Report

Run `reports/unused_indexes.sql` in PostgreSQL after representative workload.

## Candidate indexes
| Index | idx_scan | Size | Decision | Reason |
|---|---:|---:|---|---|
| ___ | ___ | ___ | Keep/Delete | ___ |

### Rule
`idx_scan = 0` is a candidate for investigation, not automatic proof that the index is useless. Consider workload frequency, deployment age, constraints, uniqueness, and future queries before removing it.
