create or replace procedure report_movement_seat_occupation(
    p_movement_id integer
)
    language plpgsql
as $$
declare
    v_route_id     integer;
    v_aircraft_id  integer;
    v_seats        integer;
    v_occupied     integer := 0;
    v_load_percent numeric(5,2);

    boarding_rec record;
    boarding_cur cursor for
        select seat_no
        from kr2_boarding
        where movement_id = p_movement_id;
begin
    select m.route_id
    into v_route_id
    from kr2_movements m
    where m.movement_id = p_movement_id;

    if not found then
        raise exception
            'Вылет с movement_id = % не найден.',
            p_movement_id;
    end if;

    select r.aircraft_id, a.seats
    into v_aircraft_id, v_seats
    from kr2_routes r
             join kr2_aircrafts a on a.aircraft_id = r.aircraft_id
    where r.route_id = v_route_id;

    if not found then
        raise exception
            'Маршрут или самолёт для вылета movement_id = % не найден.',
            p_movement_id;
    end if;

    open boarding_cur;

    loop
        fetch boarding_cur into boarding_rec;
        exit when not found;

        v_occupied := v_occupied + 1;
    end loop;

    close boarding_cur;

    v_load_percent := (v_occupied::numeric / v_seats) * 100;

    raise notice 'Отчёт по вылету %:', p_movement_id;
    raise notice 'Маршрут ID: %, Самолёт ID: %', v_route_id, v_aircraft_id;
    raise notice 'Всего мест: %', v_seats;
    raise notice 'Занято мест: %', v_occupied;
    raise notice 'Загрузка: % %', round(v_load_percent, 2), '%';

end;
$$;
