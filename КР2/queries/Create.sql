-- Аэропорты
CREATE TABLE kr2_Airports
(
    airport_id SERIAL PRIMARY KEY,
    iata       CHAR(3)      NOT NULL UNIQUE, -- код IATA
    name       VARCHAR(200) NOT NULL,        -- название аэропорта
    city       VARCHAR(100) NOT NULL         -- город
);

-- Самолёты
CREATE TABLE kr2_Aircrafts
(
    aircraft_id SERIAL PRIMARY KEY,
    model       VARCHAR(100) NOT NULL,                  -- модель самолёта
    seats       SMALLINT     NOT NULL CHECK (seats > 0) -- число кресел
);

-- Плановые маршруты (рейсы)
CREATE TABLE kr2_Routes
(
    route_id        SERIAL PRIMARY KEY,
    flight_no       VARCHAR(10) NOT NULL UNIQUE,                                 -- номер рейса
    origin_id       INT         NOT NULL REFERENCES kr2_Airports (airport_id),   -- аэропорт вылета
    dest_id         INT         NOT NULL REFERENCES kr2_Airports (airport_id),   -- аэропорт прилёта
    aircraft_id     INT         NOT NULL REFERENCES kr2_Aircrafts (aircraft_id), -- плановый борт
    sched_departure TIME        NOT NULL,                                        -- плановое время вылета
    sched_arrival   TIME        NOT NULL                                         -- плановое время прилёта
);
-- Конкретные вылеты по датам
CREATE TABLE kr2_Movements
(
    movement_id      SERIAL PRIMARY KEY,
    route_id         INT       NOT NULL REFERENCES kr2_Routes (route_id), -- плановый рейс
    flight_date      DATE      NOT NULL,                                  -- дата вылета
    actual_departure TIMESTAMP NULL,                                      -- фактический вылет
    actual_arrival   TIMESTAMP NULL                                       -- фактическое прибытие
);

-- Пассажиры
CREATE TABLE kr2_Passengers
(
    passenger_id SERIAL PRIMARY KEY,
    full_name    VARCHAR(200) NOT NULL -- ФИО пассажира
);

-- Билеты
CREATE TABLE kr2_Tickets
(
    ticket_id    SERIAL PRIMARY KEY,
    passenger_id INT            NOT NULL REFERENCES kr2_Passengers (passenger_id), -- пассажир
    booked_at    TIMESTAMP      NOT NULL,                                          -- бронирование
    total_amount NUMERIC(10, 2) NOT NULL                                           -- сумма
);

-- Посадочные (привязка билета к конкретному вылету и месту)
CREATE TABLE kr2_Boarding
(
    boarding_id SERIAL PRIMARY KEY,
    ticket_id   INT        NOT NULL REFERENCES kr2_Tickets (ticket_id),     -- билет
    movement_id INT        NOT NULL REFERENCES kr2_Movements (movement_id), -- вылет
    seat_no     VARCHAR(5) NOT NULL,                                        -- место
    UNIQUE (movement_id, seat_no)                                           -- уникальное место на вылете
);


-- Аэропорты
INSERT INTO kr2_Airports (iata, name, city)
VALUES ('WAW', 'Chopin', 'Warsaw'),
       ('KRK', 'Balice', 'Krakow'),
       ('GDN', 'Lech Walesa', 'Gdansk'),
       ('POZ', 'Lawica', 'Poznan'),
       ('WRO', 'Strachowice', 'Wroclaw'),
       ('KTW', 'Pyrzowice', 'Katowice'),
       ('RZE', 'Jasionka', 'Rzeswow');

-- Самолёты
INSERT INTO kr2_Aircrafts (model, seats)
VALUES ('A320', 180),
       ('B737', 160),
       ('A321', 220),
       ('E190', 100),
       ('B787', 280);

-- Маршруты
INSERT INTO kr2_Routes (flight_no, origin_id, dest_id, aircraft_id, sched_departure, sched_arrival)
VALUES ('LO100', 1, 2, 1, TIME '08:00', TIME '09:00'), -- WAW → KRK, A320
       ('LO101', 2, 1, 2, TIME '18:00', TIME '19:00'), -- KRK → WAW, B737
       ('LO200', 1, 3, 1, TIME '12:00', TIME '13:00'), -- WAW → GDN, A320
       ('LO201', 3, 1, 3, TIME '14:00', TIME '15:00'), -- GDN → WAW, A321
       ('LO300', 1, 4, 4, TIME '07:30', TIME '08:20'), -- WAW → POZ, E190
       ('LO301', 4, 1, 4, TIME '19:00', TIME '19:50'), -- POZ → WAW, E190
       ('LO400', 1, 5, 5, TIME '10:00', TIME '10:50'), -- WAW → WRO, B787
       ('LO500', 1, 6, 1, TIME '16:30', TIME '17:25'), -- WAW → KTW, A320
       ('LO600', 1, 7, 2, TIME '06:45', TIME '07:50');
-- WAW → RZE, B737

-- Вылеты
INSERT INTO kr2_Movements (route_id, flight_date, actual_departure, actual_arrival)
VALUES (1, DATE '2025-10-10', TIMESTAMP '2025-10-10 08:10', TIMESTAMP '2025-10-10 09:05'),
       (2, DATE '2025-10-10', TIMESTAMP '2025-10-10 18:05', TIMESTAMP '2025-10-10 19:10'),
       (3, DATE '2025-10-11', TIMESTAMP '2025-10-11 12:05', TIMESTAMP '2025-10-11 13:02'),
       (4, DATE '2025-10-11', TIMESTAMP '2025-10-11 14:10', TIMESTAMP '2025-10-11 15:08'),
       (5, DATE '2025-10-10', TIMESTAMP '2025-10-10 07:35', TIMESTAMP '2025-10-10 08:22'),
       (6, DATE '2025-10-10', TIMESTAMP '2025-10-10 19:03', TIMESTAMP '2025-10-10 19:55'),
       (7, DATE '2025-10-12', TIMESTAMP '2025-10-12 10:07', TIMESTAMP '2025-10-12 10:53'),
       (8, DATE '2025-10-12', TIMESTAMP '2025-10-12 16:32', TIMESTAMP '2025-10-12 17:27'),
       (9, DATE '2025-10-15', TIMESTAMP '2025-10-15 06:50', TIMESTAMP '2025-10-15 07:55'),
       (1, DATE '2025-10-12', TIMESTAMP '2025-10-12 08:02', TIMESTAMP '2025-10-12 09:01'),
       (2, DATE '2025-10-12', TIMESTAMP '2025-10-12 18:10', TIMESTAMP '2025-10-12 19:12');

-- Пассажиры
INSERT INTO kr2_Passengers (full_name)
VALUES ('Jan Kowalski'),
       ('Anna Nowak'),
       ('Piotr Zielinski'),
       ('Marta Wisnewska'),
       ('Krzysztof Lewandowski'),
       ('Alicja Dabrowska'),
       ('Tomasz Szymanski'),
       ('Natalia Kaminska'),
       ('Michael Wojik'),
       ('Julia Kaczmarek');

-- Билеты
INSERT INTO kr2_Tickets (passenger_id, booked_at, total_amount)
VALUES (1, TIMESTAMP '2025-10-01 12:00:00', 250.00),
       (2, TIMESTAMP '2025-10-02 13:00:00', 270.00),
       (3, TIMESTAMP '2025-10-03 08:30:00', 199.00),
       (4, TIMESTAMP '2025-10-01 14:15:00', 180.00),
       (5, TIMESTAMP '2025-10-02 09:20:00', 210.00),
       (6, TIMESTAMP '2025-10-04 16:45:00', 300.00),
       (7, TIMESTAMP '2025-10-05 11:10:00', 260.00),
       (8, TIMESTAMP '2025-10-03 17:30:00', 225.00),
       (9, TIMESTAMP '2025-10-06 10:00:00', 290.00),
       (10, TIMESTAMP '2025-10-04 13:20:00', 195.00),
       (1, TIMESTAMP '2025-10-07 09:00:00', 240.00),
       (2, TIMESTAMP '2025-10-08 15:30:00', 280.00);

-- Посадочные
INSERT INTO kr2_Boarding (ticket_id, movement_id, seat_no)
VALUES (1, 1, '12A'),
       (2, 2, '14C'),
       (3, 3, '10B'),
       (4, 5, '08F'),
       (5, 6, '21A'),
       (6, 7, '05D'),
       (7, 8, '17C'),
       (8, 9, '03A'),
       (9, 10, '11B'),
       (10, 11, '13E'),
       (11, 4, '19D'),
       (12, 3, '07F');
