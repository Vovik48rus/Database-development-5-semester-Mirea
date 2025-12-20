select o."totalAmount"
from "Order" o
where o.order_id = 1;

insert into "relation_Order_Product" ("relation_Order_Product_id", order_id, product_id)
values (16, 1, 1);

select o."totalAmount"
from "Order" o
where o.order_id = 1;
