-- Секция 1: Июль 2024 - Декабрь 2024
CREATE TABLE user_logs_2024_h2 PARTITION OF user_logs
    FOR VALUES FROM ('2024-07-01') TO ('2025-01-01'); -- Секция 2: Январь 2025 - Июнь 2025
CREATE TABLE user_logs_2025_h1 PARTITION OF user_logs
    FOR VALUES FROM ('2025-01-01') TO ('2025-07-01'); -- Секция по умолчанию (для остальных дат)
CREATE TABLE user_logs_default PARTITION OF user_logs DEFAULT;
