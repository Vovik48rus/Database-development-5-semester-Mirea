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
VALUES (1, 'Electronics', 'Devices and gadgets'),
    (2, 'Furniture', 'Home and office furniture'),
    (3, 'Clothing', 'Men and women clothing');
INSERT INTO "Subcategory" (
        "subcategory_id",
        "category_id",
        "name",
        "description"
    )
VALUES (
        1,
        1,
        'Smartphones',
        'Modern smartphones and accessories'
    ),
    (
        2,
        1,
        'Laptops',
        'Portable computers for work and study'
    ),
    (
        3,
        2,
        'Office Chairs',
        'Comfortable chairs for office and home'
    ),
    (4, 2, 'Desks', 'Work and study desks'),
    (
        5,
        3,
        'T-Shirts',
        'Casual t-shirts for men and women'
    );
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
    ),
    (
        4,
        'Saint Petersburg, Pulkovskoe shosse, 40',
        1200,
        600
    ),
    (
        5,
        'Novosibirsk, Aviastroiteley St., 15',
        900,
        450
    ),
    (6, 'Yekaterinburg, Lenina Ave., 102', 700, 350),
    (7, 'Kazan, Chistopolskaya St., 20', 800, 200),
    (8, 'Nizhny Novgorod, Gagarin Ave., 55', 600, 250),
    (
        9,
        'Rostov-on-Don, Tekucheva St., 140',
        1000,
        500
    ),
    (10, 'Sochi, Kurortny Ave., 60', 400, 120);
INSERT INTO "Product" (
        "product_id",
        "warehouse_id",
        "subcategory_id",
        "name",
        "description",
        "price",
        "status"
    )
VALUES (
        1,
        1,
        1,
        'iPhone 15',
        'Apple smartphone with A17 chip',
        1199.99,
        true
    ),
    (
        2,
        1,
        1,
        'Samsung Galaxy S24',
        'Flagship Android smartphone',
        1099.99,
        true
    ),
    (
        3,
        2,
        1,
        'Google Pixel 8',
        'Google smartphone with AI camera',
        999.99,
        true
    ),
    (
        4,
        2,
        1,
        'Xiaomi 14 Pro',
        'High-end phone with Leica camera',
        899.99,
        true
    ),
    (
        5,
        3,
        1,
        'OnePlus 12',
        'Fast and smooth Android phone',
        799.99,
        true
    ),
    (
        6,
        3,
        1,
        'Nokia G50',
        'Budget smartphone with 5G',
        249.99,
        true
    ),
    (
        7,
        4,
        2,
        'MacBook Air M3',
        'Lightweight Apple laptop with M3 chip',
        1499.99,
        true
    ),
    (
        8,
        4,
        2,
        'Dell XPS 13',
        'Ultrabook with Intel i7 processor',
        1399.00,
        true
    ),
    (
        9,
        5,
        2,
        'HP Envy 15',
        'High-performance laptop with 16GB RAM',
        1299.99,
        true
    ),
    (
        10,
        5,
        2,
        'Lenovo ThinkPad X1',
        'Business-class ultrabook',
        1599.99,
        true
    ),
    (
        11,
        6,
        2,
        'ASUS ZenBook 14',
        'Slim and powerful laptop',
        999.00,
        true
    ),
    (
        12,
        6,
        2,
        'Acer Aspire 5',
        'Affordable laptop for everyday tasks',
        599.99,
        true
    ),
    (
        13,
        7,
        3,
        'ErgoPro Chair',
        'Ergonomic office chair with mesh back',
        249.99,
        true
    ),
    (
        14,
        7,
        3,
        'ComfortMax 2000',
        'Adjustable executive chair',
        299.99,
        true
    ),
    (
        15,
        8,
        3,
        'OfficeRelax Basic',
        'Standard office chair with wheels',
        149.99,
        true
    ),
    (
        16,
        8,
        3,
        'Steelcase Leap',
        'Premium ergonomic chair',
        899.00,
        true
    ),
    (
        17,
        9,
        3,
        'Herman Miller Aeron',
        'Top-tier ergonomic office chair',
        1299.00,
        true
    ),
    (
        18,
        9,
        3,
        'Gaming Seat GT',
        'Chair designed for gamers',
        219.99,
        true
    ),
    (
        19,
        10,
        4,
        'WorkDesk 120',
        'Compact office desk with drawers',
        189.99,
        true
    ),
    (
        20,
        10,
        4,
        'Standing Desk Pro',
        'Adjustable electric standing desk',
        499.99,
        true
    ),
    (
        21,
        1,
        4,
        'Corner Desk Classic',
        'L-shaped desk for home office',
        259.99,
        true
    ),
    (
        22,
        2,
        4,
        'Minimal Desk 100',
        'Simple design wooden desk',
        149.99,
        true
    ),
    (
        23,
        3,
        4,
        'GlassTop Executive Desk',
        'Glass surface with metal frame',
        349.99,
        true
    ),
    (
        24,
        4,
        4,
        'Student Study Table',
        'Compact study table for small spaces',
        129.99,
        true
    ),
    (
        25,
        5,
        5,
        'Cotton T-Shirt',
        'Unisex cotton t-shirt, black color',
        24.99,
        true
    ),
    (
        26,
        5,
        5,
        'Graphic Tee',
        'Printed t-shirt with modern design',
        29.99,
        true
    ),
    (
        27,
        6,
        5,
        'Polo Shirt',
        'Casual polo shirt with collar',
        39.99,
        true
    ),
    (
        28,
        6,
        5,
        'Long Sleeve Tee',
        'Soft cotton t-shirt with long sleeves',
        34.99,
        true
    ),
    (
        29,
        7,
        5,
        'Sports T-Shirt',
        'Breathable quick-dry fabric for workouts',
        27.99,
        true
    ),
    (
        30,
        7,
        5,
        'V-Neck T-Shirt',
        'Classic v-neck unisex t-shirt',
        22.99,
        true
    );
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
    (3, '2024-04-05', 1, true, 'USD', '12345678'),
    (4, '2024-04-07', 1, false, 'USD', 'INV-00004'),
    (5, '2024-04-09', 0, true, 'EUR', 'INV-00005');
INSERT INTO "Order" (
        "order_id",
        "user_id",
        "transaction_id",
        "orderDate",
        "status",
        "totalAmount"
    )
VALUES (1, 1, 1, '2024-01-15', 'Processed', 999.99),
    (2, 2, 2, '2024-02-20', 'Pending', 150.00),
    (3, 3, 3, '2024-03-05', 'Shipped', 12.99),
    (4, 1, 4, '2024-04-10', 'Pending', 299.99),
    (5, 2, 5, '2024-05-08', 'Processed', 1599.99),
    (6, 3, NULL, '2024-01-10', 'Cancelled', 89.99),
    (7, 1, 1, '2024-05-11', 'Shipped', 459.50),
    (8, 2, 2, '2024-01-12', 'Delivered', 219.99),
    (9, 3, 3, '2024-02-14', 'Processed', 749.00),
    (10, 1, 4, '2024-12-15', 'Pending', 124.99);
INSERT INTO "relation_Order_Product" (
        "relation_Order_Product_id",
        "order_id",
        "product_id"
    )
VALUES (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 7),
    (5, 4, 8),
    (6, 5, 10),
    (7, 5, 11),
    (8, 6, 25),
    (9, 6, 26),
    (10, 7, 19),
    (11, 7, 20),
    (12, 8, 13),
    (13, 8, 14),
    (14, 9, 2),
    (15, 10, 28);
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