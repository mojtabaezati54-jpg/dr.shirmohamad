-- Run this after your workload has been executed for a while.
-- PostgreSQL statistics are cumulative since stats reset/server restart.
-- Never delete an index only because idx_scan is currently zero.

SELECT
    s.schemaname,
    s.relname AS table_name,
    s.indexrelname AS index_name,
    s.idx_scan,
    pg_size_pretty(pg_relation_size(s.indexrelid)) AS index_size
FROM pg_stat_user_indexes s
WHERE s.schemaname = 'public'
ORDER BY s.idx_scan ASC, pg_relation_size(s.indexrelid) DESC;
