SELECT
    AVG((event_data -> 'details' ->> 'total_sum')::NUMERIC)::NUMERIC(10,2) AS
        avg_check
FROM user_logs
WHERE event_data ->> 'event' = 'sale';
