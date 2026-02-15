create trigger trg_check_airport_iata_format
    before insert or update
    on kr2_airports
    for each row
execute function check_airport_iata_format();
