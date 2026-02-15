call change_route_aircraft( 7, 1);

select kr2_routes.route_id, kr2_routes.aircraft_id
from kr2_routes
where kr2_routes.route_id = 7;
