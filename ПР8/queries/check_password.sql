SELECT
    username,
    password_raw,
    encode(password_hash, 'hex') AS password_hash,
    (digest(password_raw, 'sha256') = password_hash) as is_valid_check
FROM system_users;
