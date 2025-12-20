SELECT '2024_h2' as partition_name, count(*) FROM user_logs_2024_h2
UNION ALL
SELECT '2025_h1', count(*) FROM user_logs_2025_h1
UNION ALL
SELECT 'default', count(*) FROM user_logs_default;
