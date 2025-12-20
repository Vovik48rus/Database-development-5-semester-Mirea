CREATE TABLE "Employee" (
                            "employee_id" bigint NOT NULL,
                            "name" varchar NOT NULL,
                            "email" varchar NOT NULL,
                            "phone" varchar NOT NULL,
                            "hiredDate" date NOT NULL,
                            "department" varchar NOT NULL,
                            "isActive" boolean NOT NULL,
                            PRIMARY KEY ("employee_id")
);
CREATE TABLE "Driver" (
                          "driver_id" bigserial NOT NULL,
                          "employee_id" bigint NOT NULL,
                          "licenseNumber" varchar NOT NULL,
                          "startDrive" date NOT NULL,
                          "isAvailable" boolean NOT NULL,
                          "rating" smallint NOT NULL,
                          PRIMARY KEY ("driver_id"),
                          CONSTRAINT "fk_Driver_employee_id_Employee_employee_id" FOREIGN KEY("employee_id") REFERENCES "Employee"("employee_id")
);
CREATE TABLE "Vehicle" (
                           "vehicle_id" bigserial NOT NULL,
                           "driver_id" bigint NOT NULL,
                           "type" smallint NOT NULL,
                           "plateNumber" varchar NOT NULL,
                           "capacity" smallint NOT NULL,
                           "fuelType" smallint NOT NULL,
                           "status" varchar NOT NULL,
                           PRIMARY KEY ("vehicle_id"),
                           CONSTRAINT "fk_Vehicle_driver_id_Driver_driver_id" FOREIGN KEY("driver_id") REFERENCES "Driver"("driver_id")
);
CREATE TABLE "Client" (
                          "client_id" bigserial NOT NULL,
                          "name" varchar NOT NULL,
                          "email" varchar NOT NULL,
                          "registrationDate" date NOT NULL,
                          PRIMARY KEY ("client_id")
);
CREATE TABLE "SupportChat" (
                               "supportChat_id" bigserial NOT NULL,
                               "client_id" bigint NOT NULL,
                               "employee_id" bigint NOT NULL,
                               "createdAt" date NOT NULL,
                               "status" smallint NOT NULL,
                               PRIMARY KEY ("supportChat_id"),
                               CONSTRAINT "fk_SupportChat_client_id_Client_client_id" FOREIGN KEY("client_id") REFERENCES "Client"("client_id"),
                               CONSTRAINT "fk_SupportChat_employee_id_Employee_employee_id" FOREIGN KEY("employee_id") REFERENCES "Employee"("employee_id")
);
CREATE TABLE "Message" (
                           "message_id" bigserial NOT NULL,
                           "chat_id" bigint NOT NULL,
                           "message" text NOT NULL,
                           "createdAt" date NOT NULL,
                           "sender" boolean NOT NULL,
                           PRIMARY KEY ("message_id"),
                           CONSTRAINT "fk_Message_chat_id_SupportChat_supportChat_id" FOREIGN KEY("chat_id") REFERENCES "SupportChat"("supportChat_id")
);
CREATE TABLE "Category" (
                            "category_id" bigserial NOT NULL,
                            "name" varchar NOT NULL,
                            "description" text NOT NULL,
                            PRIMARY KEY ("category_id")
);
CREATE TABLE "Transaction" (
                               "transaction_id" bigserial NOT NULL,
                               "paymentDate" date NOT NULL,
                               "paymentStatus" smallint NOT NULL,
                               "paymentMethod" boolean NOT NULL,
                               "currency" varchar NOT NULL,
                               "invoiceNumber" varchar NOT NULL,
                               PRIMARY KEY ("transaction_id")
);
CREATE TABLE "Order" (
                         "order_id" bigserial NOT NULL,
                         "user_id" bigint NOT NULL,
                         "transaction_id" bigint,
                         "orderDate" date NOT NULL,
                         "status" varchar NOT NULL,
                         "totalAmount" numeric NOT NULL,
                         PRIMARY KEY ("order_id"),
                         CONSTRAINT "fk_Order_transaction_id_Transaction_transaction_id" FOREIGN KEY("transaction_id") REFERENCES "Transaction"("transaction_id"),
                         CONSTRAINT "fk_Order_user_id_Client_client_id" FOREIGN KEY("user_id") REFERENCES "Client"("client_id")
);
CREATE TABLE "Warehouse" (
                             "warehouse_id" bigserial NOT NULL,
                             "address" text NOT NULL,
                             "capacity" integer NOT NULL,
                             "currentLoad" integer NOT NULL,
                             PRIMARY KEY ("warehouse_id")
);
CREATE TABLE "Subcategory" (
                               "subcategory_id" bigserial NOT NULL,
                               "category_id" bigint NOT NULL,
                               "name" varchar NOT NULL,
                               "description" text NOT NULL,
                               PRIMARY KEY ("subcategory_id"),
                               CONSTRAINT "fk_Subcategory_category_id_Category_category_id" FOREIGN KEY("category_id") REFERENCES "Category"("category_id")
);
CREATE TABLE "Product" (
                           "product_id" bigserial NOT NULL,
                           "warehouse_id" bigint NOT NULL,
                           "subcategory_id" bigint NOT NULL,
                           "name" varchar(150) NOT NULL,
                           "description" text NOT NULL,
                           "price" numeric NOT NULL,
                           "status" boolean NOT NULL,
                           PRIMARY KEY ("product_id"),
                           CONSTRAINT "fk_Product_warehouse_id_Warehouse_warehouse_id" FOREIGN KEY("warehouse_id") REFERENCES "Warehouse"("warehouse_id"),
                           CONSTRAINT "fk_Product_subcategory_id_Subcategory_subcategory_id" FOREIGN KEY("subcategory_id") REFERENCES "Subcategory"("subcategory_id"),
                           CONSTRAINT "check_price_positive" CHECK (price > 0)
);
CREATE TABLE "relation_Order_Product" (
                                          "relation_Order_Product_id" bigserial NOT NULL,
                                          "order_id" bigint NOT NULL,
                                          "product_id" bigint NOT NULL,
                                          PRIMARY KEY ("relation_Order_Product_id"),
                                          CONSTRAINT "fk_relation_Order_Product_order_id_Order_order_id" FOREIGN KEY("order_id") REFERENCES "Order"("order_id"),
                                          CONSTRAINT "fk_relation_Order_Product_product_id_Product_product_id" FOREIGN KEY("product_id") REFERENCES "Product"("product_id")
);
CREATE TABLE "PickupPoint" (
                               "pickupPoint_id" bigserial NOT NULL,
                               "warehouse_id" bigint NOT NULL,
                               "address" text NOT NULL,
                               "workingHours" varchar NOT NULL,
                               "contactPhone" varchar NOT NULL,
                               PRIMARY KEY ("pickupPoint_id"),
                               CONSTRAINT "fk_PickupPoint_warehouse_id_Warehouse_warehouse_id" FOREIGN KEY("warehouse_id") REFERENCES "Warehouse"("warehouse_id")
);
CREATE TABLE "DeliveryRequest" (
                                   "deliveryRequest_id" bigserial NOT NULL,
                                   "driver_id" bigint NOT NULL,
                                   "order_id" bigint NOT NULL,
                                   "vehicle_id" bigint NOT NULL,
                                   "pickupPoint_id" bigint NOT NULL,
                                   "deliveryDate" date NOT NULL,
                                   "status" smallint NOT NULL,
                                   PRIMARY KEY ("deliveryRequest_id"),
                                   CONSTRAINT "fk_DeliveryRequest_driver_id_Driver_driver_id" FOREIGN KEY("driver_id") REFERENCES "Driver"("driver_id"),
                                   CONSTRAINT "fk_DeliveryRequest_order_id_Order_order_id" FOREIGN KEY("order_id") REFERENCES "Order"("order_id"),
                                   CONSTRAINT "fk_DeliveryRequest_pickupPoint_id_PickupPoint_pickupPoint_id" FOREIGN KEY("pickupPoint_id") REFERENCES "PickupPoint"("pickupPoint_id"),
                                   CONSTRAINT "fk_DeliveryRequest_vehicle_id_Vehicle_vehicle_id" FOREIGN KEY("vehicle_id") REFERENCES "Vehicle"("vehicle_id")
);