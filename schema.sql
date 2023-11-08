-- BASIC, INDEPENDENT ENTITIES

-- -- Table of chemicals used for production (chemically identical substances, regardless of supplier)

CREATE TABLE `chemicals` (
    `id` TINYINT,
    `name` VARCHAR(30) NOT NULL UNIQUE,
    `formula` VARCHAR(50) NOT NULL UNIQUE,
    `type` ENUM("acid", "base", "organic", "solid"),
    PRIMARY KEY(`id`)
);

-- -- Table of chemical suppliers. There is exactly one contact to each company to avoid confusion.

CREATE TABLE `suppliers` (
    `id` TINYINT,
    `name` VARCHAR(50) NOT NULL UNIQUE,
    `address` VARCHAR(80) NOT NULL,
    `currency` CHAR(3) NOT NULL,
    `contact_name` VARCHAR(50) NOT NULL,
    `contact_email` VARCHAR(40) NOT NULL,
    `contact_phone` VARCHAR(16) NOT NULL,
    PRIMARY KEY(`id`)
);

-- -- Table of products.

CREATE TABLE `products` (
    `id` TINYINT,
    `name` VARCHAR(50) NOT NULL UNIQUE,
    `description` TEXT NOT NULL,
    PRIMARY KEY(`id`)
);

-- DEPENDENT ENTITIES (with foreign keys)

CREATE TABLE `recipes` (
    `id` TINYINT,
    `product_id` TINYINT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`product_id`) REFERENCES `products`(`id`)
);

CREATE TABLE `supplies` (
    `chemical_id` TINYINT,
    `supplier_id` TINYINT,
    `price_per_kg` DECIMAL(5,2) NOT NULL,
    `until` DATE NOT NULL
    FOREIGN KEY(`chemical_id`) REFERENCES `chemicals`(`id`),
    FOREIGN KEY(`supplier_id`) REFERENCES `suppliers`(`id`),
);

CREATE TABLE `chemical_recipes` (
    `recipe_id` TINYINT,
    `chemical_id` TINYINT,
    `quantity` DECIMAL(6,3),
    `yield` DECIMAL(5,2),
    FOREIGN KEY(`recipe_id`) REFERENCES `recipes`(`id`),
    FOREIGN KEY(`chemical_id`) REFERENCES `chemicals`(`id`)
);
