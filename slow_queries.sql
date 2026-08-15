-- Slow query identification using PostgreSQL statistics.
-- This requires the pg_stat_statements extension.
-- If the extension is unavailable, use EXPLAIN ANALYZE on individual queries.

CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

SELECT
    calls,
    ROUND(total_exec_time::numeric, 2) AS total_exec_ms,
    ROUND(mean_exec_time::numeric, 2) AS mean_exec_ms,
    rows,
    LEFT(query, 180) AS query
FROM pg_stat_statements
WHERE dbid = (SELECT oid FROM pg_database WHERE datname = current_database())
ORDER BY mean_exec_time DESC
LIMIT 20;
