UPDATE user_logs
SET event_data = event_data || '{
  "source": "app"
}'::jsonb;
SELECT event_data
FROM user_logs
LIMIT 3;
