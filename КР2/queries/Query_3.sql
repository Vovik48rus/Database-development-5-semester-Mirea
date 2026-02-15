create or replace procedure move_product (
    in_product_id int,
    in_warehouse_in_id int,
    out p_success boolean,
    out p_message text
)
    language plpgsql as $$
declare
    warehouse_exsist boolean;
    product_exsist boolean;
begin
    select exists (select 1 from "Warehouse" where warehouse_id =
                                                   in_warehouse_in_id)
    into warehouse_exsist;
    if not warehouse_exsist then
        p_success := false;
        p_message := 'Ошибка: Склад с ID ' || in_warehouse_in_id || ' не
найден';
        return;
    end if;

    select exists (select 1 from "Product" where product_id = in_product_id)
    into product_exsist;
    if not product_exsist then
        p_success := false;
        p_message := 'Ошибка: Продукт с ID ' || in_product_id || ' не
найден';
        return;
    end if;

    update "Product"
    set warehouse_id = in_warehouse_in_id
    where product_id = in_product_id;
    p_success := true;
    p_message := 'Good';
end;
$$;

DO $$
    DECLARE
        v_success BOOLEAN;
        v_message TEXT;
    BEGIN
        CALL move_product(1, 1, v_success, v_message);
        RAISE NOTICE '%', v_message;
    END;
$$;