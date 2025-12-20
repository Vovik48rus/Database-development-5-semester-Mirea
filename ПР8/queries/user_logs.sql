CREATE TABLE user_logs
(
    log_id     BIGSERIAL,
    created_at TIMESTAMPTZ NOT NULL,
    user_id    INT,
    event_data JSONB
) PARTITION BY RANGE (created_at);
