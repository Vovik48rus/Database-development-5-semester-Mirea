create or replace function check_airport_iata_format()
    returns trigger
    language plpgsql
as $$
begin
    if new.iata is null
        or new.iata !~ '^[A-Z]{3}$' then
        raise exception
            'Некорректный IATA-код: "%". Ожидается ровно 3 заглавные латинские буквы (A–Z).',
            new.iata
            using errcode = '23514';
    end if;

    return new;
end;
$$;
