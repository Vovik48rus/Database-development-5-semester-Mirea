SELECT setval(
               pg_get_serial_sequence('"relation_Order_Product"', 'relation_Order_Product_id'),
               COALESCE((SELECT MAX("relation_Order_Product_id") FROM "relation_Order_Product"), 0) + 1,
               false
       );
