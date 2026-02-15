create or replace view my_office_chair as
select product_id, name, price
from "Product"
where subcategory_id = 3;
select *
from office_chair;

insert into my_office_chair (product_id, warehouse_id, subcategory_id, name,
                             description, price, status)
values (100, 1, 3, '123', 'New office chair', 999, true);

delete from my_office_chair
where product_id = 100;
select *
from "Product" p
where p.product_id = 100;

DROP VIEW IF EXISTS Warehouse_summary;
create or replace view Warehouse_summary as
select
    AVG(p.price) as price_avg,
    w.address
from "Product" p
         join "Warehouse" w
              on p.warehouse_id = w.warehouse_id
group by
    w.address;
select *
from Warehouse_summary;