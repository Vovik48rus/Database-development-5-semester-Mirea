create or replace function demo_explicit_cursor()
    returns void as
$$
declare
    cur_products cursor for
        select product_id, name, price
        from "Product"
        where price > 100;
    rec record;
begin
    open cur_products;

    loop
        fetch cur_products into rec;
        exit when not found;

        raise notice 'product: %, name: %, price: %',
            rec.product_id, rec.name, rec.price;
    end loop;

    close cur_products;
end;
$$ language plpgsql;

select demo_explicit_cursor();
