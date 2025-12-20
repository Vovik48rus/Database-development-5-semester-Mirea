create or replace function prevent_category_delete()
    returns trigger as
$$
declare
    subcat_count  integer;
    product_count integer;
begin
    select count(*)
    into subcat_count
    from "Subcategory"
    where category_id = old.category_id;

    if subcat_count > 0 then
        raise exception
            'Нельзя удалить категорию %, так как в ней есть подкатегории.',
            old.category_id;
    end if;

    select count(*)
    into product_count
    from "Product" as p
             join "Subcategory" s
                  on p.subcategory_id = s.subcategory_id
    where s.category_id = old.category_id;

    if product_count > 0 then
        raise exception
            'Нельзя удалить категорию %, так как в ней есть товары.',
            old.category_id;
    end if;

    return old;
end;
$$ language plpgsql;

create trigger trg_prevent_category_delete
    before delete
    on "Category"
    for each row
execute function prevent_category_delete();

DELETE FROM "Category" WHERE category_id = 2;


