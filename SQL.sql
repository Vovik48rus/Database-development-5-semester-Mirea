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
CREATE TABLE "Subcategory" (
    "subcategory_id" bigserial NOT NULL,
    "category_id" bigint NOT NULL,
    "name" varchar NOT NULL,
    "description" text NOT NULL,
    PRIMARY KEY ("subcategory_id"),
    CONSTRAINT "fk_Subcategory_category_id_Category_category_id" FOREIGN KEY("category_id") REFERENCES "Category"("category_id")
);
INSERT INTO "Employee" (
        "employee_id",
        "name",
        "email",
        "phone",
        "hiredDate",
        "department",
        "isActive"
    )
VALUES (
        1,
        'Ivan Petrov',
        'ivan@mail.com',
        '8900567890',
        '2022-01-01',
        'Logistics',
        true
    ),
    (
        2,
        'Anna Smirnova',
        'anna@mail.com',
        '8900654321',
        '2021-03-15',
        'Support',
        true
    ),
    (
        3,
        'Pavel Orlov',
        'pavel@mail.com',
        '8900223333',
        '2023-07-22',
        'Logistics',
        false
    ),
    (
        4,
        'Natalia Egorova',
        'natalia@mail.com',
        '8900334444',
        '2020-09-10',
        'Support',
        true
    ),
    (
        5,
        'Mikhail Sokolov',
        'mikhail@mail.com',
        '8900445555',
        '2022-12-05',
        'Operations',
        true
    );
INSERT INTO "Driver" (
        "driver_id",
        "employee_id",
        "licenseNumber",
        "startDrive",
        "isAvailable",
        "rating"
    )
VALUES (1, 1, 'A1234567', '2022-02-01', true, 5),
    (2, 3, 'B7654321', '2023-08-10', true, 4),
    (3, 2, 'C1111111', '2021-05-30', false, 3);
INSERT INTO "Client" ("client_id", "name", "email", "registrationDate")
VALUES (
        1,
        'Sergey Ivanov',
        'sergey@mail.com',
        '2023-05-10'
    ),
    (
        2,
        'Elena Kozlova',
        'elena@mail.com',
        '2023-06-11'
    ),
    (
        3,
        'Dmitry Sidorov',
        'dmitry@mail.com',
        '2024-01-25'
    );
INSERT INTO "Category" ("category_id", "name", "description")
VALUES (1, 'Electronics', 'Electronics'),
    (2, 'Home Appliances', 'Home Appliances'),
    (3, 'Books', 'Books');
INSERT INTO "Subcategory" (
        "subcategory_id",
        "category_id",
        "name",
        "description"
    )
VALUES (1, 1, 'Smartphones', 'Smartphones'),
    (2, 2, 'Microwaves', 'Microwaves'),
    (3, 3, 'Fiction', 'Fiction');
INSERT INTO "Warehouse" (
        "warehouse_id",
        "address",
        "capacity",
        "currentLoad"
    )
VALUES (
        1,
        'Moscow region, Balashikha city district, territory of the Kuchino Landfill, 6, p. 3',
        1000,
        200
    ),
    (2, 'Vnukovskaya St., 7A, Odintsovo', 500, 150),
    (
        3,
        'MKAD, 84th kilometer, vl5x1A, Moscow',
        2000,
        1750
    );
INSERT INTO "Product" (
        "product_id",
        "warehouse_id",
        "subcategory_id",
        "name",
        "description",
        "price",
        "status"
    )
VALUES (1, 1, 1, 'iPhone 13', 'iPhone', 999.99, true),
    (
        2,
        2,
        2,
        'Samsung Microwave',
        'Samsung Microwave',
        150.00,
        true
    ),
    (
        3,
        3,
        3,
        'The witcher',
        'The witcher',
        12.99,
        true
    ),
    (
        4,
        3,
        3,
        'Samsung washing machine',
        'The washing machine',
        500.99,
        false
    ),
    (5, 3, 1, 'Poco', 'The phone', 9.99, true);
INSERT INTO "Transaction" (
        "transaction_id",
        "paymentDate",
        "paymentStatus",
        "paymentMethod",
        "currency",
        "invoiceNumber"
    )
VALUES (1, '2024-04-01', 1, true, 'USD', '123456'),
    (2, '2024-04-03', 0, false, 'EUR', '1234567'),
    (3, '2024-04-05', 1, true, 'USD', '12345678');
INSERT INTO "Order" (
        "order_id",
        "user_id",
        "transaction_id",
        "orderDate",
        "status",
        "totalAmount"
    )
VALUES (1, 1, 1, '2024-04-01', 'Processed', 999.99),
    (2, 2, 2, '2024-04-03', 'Pending', 150.00),
    (3, 3, 3, '2024-04-05', 'Shipped', 12.99);
INSERT INTO "relation_Order_Product" (
        "relation_Order_Product_id",
        "order_id",
        "product_id"
    )
VALUES (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3);
INSERT INTO "PickupPoint" (
        "pickupPoint_id",
        "warehouse_id",
        "address",
        "workingHours",
        "contactPhone"
    )
VALUES (
        1,
        1,
        'avenue. Rocket builders, 9, building 3, Dolgoprudny',
        '9:00-18:00',
        '8900234567'
    ),
    (
        2,
        2,
        '10 Novozavodskaya St., Khimki',
        '10:00-19:00',
        '8900876543'
    ),
    (
        3,
        3,
        'Herman Titov St., 10, Khimki',
        '8:00-17:00',
        '8900122334'
    );
INSERT INTO "Vehicle" (
        "vehicle_id",
        "driver_id",
        "type",
        "plateNumber",
        "capacity",
        "fuelType",
        "status"
    )
VALUES (1, 1, 1, 'A123BC', 100, 1, 'active'),
    (2, 2, 2, 'B456DE', 80, 2, 'maintenance'),
    (3, 3, 1, 'C789FG', 120, 1, 'active');
INSERT INTO "DeliveryRequest" (
        "deliveryRequest_id",
        "driver_id",
        "order_id",
        "vehicle_id",
        "pickupPoint_id",
        "deliveryDate",
        "status"
    )
VALUES (1, 1, 1, 1, 1, '2024-04-03', 1),
    (2, 2, 2, 2, 2, '2024-04-04', 0),
    (3, 3, 3, 3, 3, '2024-04-06', 1);
INSERT INTO "SupportChat" (
        "supportChat_id",
        "client_id",
        "employee_id",
        "createdAt",
        "status"
    )
VALUES (1, 1, 4, '2024-04-05', 1),
    (2, 2, 4, '2024-04-06', 0),
    (3, 3, 5, '2024-04-07', 1);
INSERT INTO "Message" (
        "message_id",
        "chat_id",
        "message",
        "createdAt",
        "sender"
    )
VALUES (1, 1, 'AAA', '2024-04-05', true),
    (2, 1, 'AA', '2024-04-05', false),
    (3, 2, 'a', '2024-04-06', true);