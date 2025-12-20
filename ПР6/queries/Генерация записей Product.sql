do
$$
    declare
        w_id bigint;
        s_id bigint;
    begin
        for i in 1..1000000
            loop

                select warehouse_id
                into w_id
                from "Warehouse"
                order by random()
                limit 1;

                select subcategory_id
                into s_id
                from "Subcategory"
                order by random()
                limit 1;

                insert into "Product" (warehouse_id, subcategory_id, name, description, price, status)
                values (w_id,
                        s_id,
                        'product #' || i,
                        'описание товара №' || i,
                        (random() * 900 + 100)::numeric(10, 2),
                        (random() > 0.5)
                       );
            end loop;
    end;
$$ language plpgsql;
