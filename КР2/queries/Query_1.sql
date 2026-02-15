CREATE OR REPLACE FUNCTION warehouse_price_avg(warehouse_id_param int)
    RETURNS NUMERIC
AS
$$
DECLARE
    price_avg NUMERIC;
BEGIN
    SELECT AVG(p.price)
    INTO price_avg
    FROM "Product" p
    WHERE p.warehouse_id = warehouse_id_param;
    RETURN price_avg;
END;
$$ LANGUAGE plpgsql;

select w.address,
       warehouse_price_avg(w.warehouse_id::INT) as warehouse_product_avg
from "Warehouse" w;