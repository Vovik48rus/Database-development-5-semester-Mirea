create or replace function trigger_totalAmount_Order()
    returns trigger as
$$
declare
    add_price integer;
begin
    select p.price
    into add_price
    from "Product" p
    where p.product_id = new.product_id;

    update "Order"
    set "totalAmount" = "totalAmount" + add_price
    where order_id = new.order_id;

    return new;
end;
$$ language plpgsql;

create or replace trigger before_ordering_trigger
    before insert on "relation_Order_Product"
    for each row
execute function trigger_totalAmount_Order();
