CREATE TABLE system_users (
                              user_id SERIAL PRIMARY KEY,
                              username VARCHAR(100) NOT NULL UNIQUE,
                              password_raw TEXT,        -- ТОЛЬКО ДЛЯ УЧЕБНЫХ ЦЕЛЕЙ!!!
                              password_hash BYTEA NOT NULL,
                              role_id INT REFERENCES system_roles(role_id)
);

-- Вставка пользователей
INSERT INTO system_users (username, password_raw, password_hash, role_id)
VALUES
    ('admin_user', 'StrongPass123!', digest('StrongPass123!', 'sha256'), 1),
    ('pharmacy_worker', 'Pharma2025', digest('Pharma2025_bad', 'sha256'), 2);
