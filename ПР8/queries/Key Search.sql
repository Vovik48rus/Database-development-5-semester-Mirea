SELECT log_id, event_data
FROM user_logs
WHERE event_data ->> 'event' = 'sale'
  AND (event_data -> 'details' ->> 'total_sum')::NUMERIC > 800
LIMIT 5;