create or replace function demo_implicit_cursor()
    returns void as
$$
declare
    rec record;
begin
    for rec in
        select c.category_id, c.name as category_name, count(p.product_id) as total_products
        from "Category" c
                 join "Subcategory" s on s.category_id = c.category_id
                 join "Product" p on p.subcategory_id = s.subcategory_id
        group by c.category_id, c.name
        order by c.category_id
        loop
            raise notice 'category: %, name: %, products: %',
                rec.category_id, rec.category_name, rec.total_products;
        end loop;
end;
$$ language plpgsql;

select demo_implicit_cursor();
