create or replace function my_trigger()
    returns trigger as
$$
declare
    current_Warehouse_current_load integer;
    current_Warehouse_capacity     integer;
begin
    select wh."currentLoad", wh.capacity
    into current_Warehouse_current_load, current_Warehouse_capacity
    from "Warehouse" as wh
    where wh.warehouse_id = new.warehouse_id;

    if current_Warehouse_capacity < (current_Warehouse_current_load + 1) then
        RAISE EXCEPTION
            'Невозможно добавить товар на склад %: превышена максимальная вместимость.',
            NEW.warehouse_id;
    end if;

    update "Warehouse"
    set "currentLoad" = "currentLoad" + 1
    where warehouse_id = new.warehouse_id;

    return new;
end;
$$ language plpgsql;

create or replace trigger before_sale_product_insert_trigger
    before insert on "Product"
    for each row
    execute function my_trigger();


insert into "Product" (product_id, warehouse_id, subcategory_id, name, description, price, status)
values (32, 1, 1, 'name', 'description', 200, true);

insert into "Product" (product_id, warehouse_id, subcategory_id, name, description, price, status)
values (33, 2, 1, 'name', 'description', 200, true);
