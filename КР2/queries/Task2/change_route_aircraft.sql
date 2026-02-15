create or replace procedure change_route_aircraft(
    p_route_id integer,
    p_new_aircraft_id integer
)
    language plpgsql
as $$
begin
    if not exists (
        select 1
        from kr2_aircrafts
        where aircraft_id = p_new_aircraft_id
    ) then
        raise exception
            'Самолёт с aircraft_id = % не существует.',
            p_new_aircraft_id;
    end if;

    if not exists (
        select 1
        from kr2_routes
        where route_id = p_route_id
    ) then
        raise exception
            'Маршрут с route_id = % не существует.',
            p_route_id;
    end if;

    update kr2_routes
    set aircraft_id = p_new_aircraft_id
    where route_id = p_route_id;
end;
$$;
