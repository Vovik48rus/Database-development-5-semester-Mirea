DO
$$
    DECLARE
        i            INT;
        random_date  TIMESTAMPTZ;
        random_user  INT;
        event_type   TEXT;
        json_payload JSONB;
    BEGIN
        FOR i IN 1..20000
            LOOP
                -- Генерация даты в диапазоне с середины 2024 по середину 2025
                random_date :=
                        '2024-07-01'::TIMESTAMPTZ + random() * ('2025-07-01'::TIMESTAMPTZ - '2024-07-01'::TIMESTAMPTZ);
                random_user := floor(random() * 2 + 1)::INT;

                IF (i % 2 = 0) THEN
                    event_type := 'login';
                    -- JSON для входа: сохраняем IP и статус
                    json_payload := jsonb_build_object(
                            'event', event_type,
                            'ip', '192.168.1.' || floor(random() * 255)::TEXT,
                            'success', (random() > 0.1)
                                    );
                ELSE
                    event_type := 'sale';
                    json_payload := jsonb_build_object(
                            'event', event_type,
                            'details', jsonb_build_object(
                                    'medicine_id', floor(random() * 5 + 1),
                                    'quantity', floor(random() * 10 + 1),
                                    'total_sum', (random() * 1000)::NUMERIC(10, 2)
                                       )
                                    );
                END IF;

                INSERT INTO user_logs (created_at, user_id, event_data)
                VALUES (random_date, random_user, json_payload);
            END LOOP;
    END
$$;