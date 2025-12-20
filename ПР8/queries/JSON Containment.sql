SELECT * FROM user_logs
WHERE event_data @> '{"success": true}'
LIMIT 5;
