UPDATE user_logs
SET event_data = jsonb_set(event_data, '{key}', '123456')
WHERE log_id = (SELECT min(log_id)
                FROM user_logs
                WHERE event_data ->>
                      'event' = 'login');
SELECT event_data
FROM user_logs
WHERE event_data ->> 'key' = '123456'
LIMIT 1;