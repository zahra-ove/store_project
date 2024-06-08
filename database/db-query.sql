drop database store;
create database store character set utf8 collate utf8



-- ============== Users
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
                                     id INT AUTO_INCREMENT PRIMARY KEY,
                                     first_name VARCHAR(255),
    last_name VARCHAR(255),
    username VARCHAR(255),
    `password` VARCHAR(255),
    remember_token VARCHAR(100),
    mobile VARCHAR(30),
    email VARCHAR(255),
    email_verified_at TIMESTAMP NULL DEFAULT NULL,

    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    deleted_at TIMESTAMP NULL DEFAULT NULL
    );


-- ============== Categories
DROP TABLE IF EXISTS categories;
CREATE TABLE IF NOT EXISTS categories (
                                          id INT AUTO_INCREMENT PRIMARY KEY,
                                          `name` VARCHAR(255) NOT NULL,
    category_id int,

    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    deleted_at TIMESTAMP NULL DEFAULT NULL,

    index categories_categoryid_idx (category_id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
    );


-- ============== Products
DROP TABLE IF EXISTS products;
CREATE TABLE IF NOT EXISTS products (
                                        id INT AUTO_INCREMENT PRIMARY KEY,
                                        `name` VARCHAR(255) NOT NULL,
    category_id int,
    price decimal(15,3),
    stock int,
    active TINYINT,   -- is product active? (show/hide on store)   0:inactive  1:active
    discount_active TINYINT,    -- is discount active for this product?   0:discount_inactive  1:discount_active
    discount_amount decimal(15,3),
    discount_percent float,

    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    deleted_at TIMESTAMP NULL DEFAULT NULL,

    index product_categoryid_idx (category_id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
    );


-- ============== Attribute
DROP TABLE IF EXISTS attributes;
CREATE TABLE IF NOT EXISTS attributes (
                                          id INT AUTO_INCREMENT PRIMARY KEY,
                                          `name` VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    deleted_at TIMESTAMP NULL DEFAULT NULL
    );



-- ============== Attribute Category
DROP TABLE IF EXISTS attribute_category;
CREATE TABLE IF NOT EXISTS attribute_category (
                                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                                  attribute_id int,
                                                  category_id int,
                                                  `order` int,
                                                  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,

                                                  index attributecategory_attributeid_idx (attribute_id),
    FOREIGN KEY (attribute_id) REFERENCES attributes(id),

    index attributecategory_categoryid_idx (category_id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
    );


-- ============== Product Attribute Values
DROP TABLE IF EXISTS productattribute_values;
CREATE TABLE IF NOT EXISTS productattribute_values (
                                                       id INT AUTO_INCREMENT PRIMARY KEY,
                                                       product_id int,
                                                       `value` text,
                                                       created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
                                                       updated_at TIMESTAMP NULL DEFAULT NULL,
                                                       deleted_at TIMESTAMP NULL DEFAULT NULL,

                                                       index productattributevalues_productid_idx (product_id),
    FOREIGN KEY (product_id) REFERENCES products(id)
    );


-- ============== Taggable
DROP TABLE IF EXISTS taggables;
CREATE TABLE IF NOT EXISTS taggables (
                                         id INT AUTO_INCREMENT PRIMARY KEY,
                                         tag_id int,
                                         taggable_id int,
                                         taggable_type varchar(255),
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,

    index taggables_taggableid_idx (taggable_id),
    index taggables_taggabletype_idx (taggable_type)
    );


-- ============== Tickets
DROP TABLE IF EXISTS tickets;
CREATE TABLE IF NOT EXISTS tickets (
                                       id int AUTO_INCREMENT PRIMARY KEY,
                                       title varchar(500),
    content text,
    user_id int,
    ticket_id int,  -- reply to which ticket_id
    main_ticket TINYINT(1) DEFAULT 0, -- is it first ticket
    closed TINYINT(1) DEFAULT 0,  -- is this ticket conversation finished?

    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    deleted_at TIMESTAMP NULL DEFAULT NULL,


    index tickets_userid_idx (user_id),
    FOREIGN KEY (user_id) REFERENCES users(id),

    index tickets_ticketid_idx (ticket_id),
    FOREIGN KEY (ticket_id) REFERENCES tickets(id)
    );


-- ============== Images
DROP TABLE IF EXISTS images;
CREATE TABLE IF NOT EXISTS images (
                                      id INT AUTO_INCREMENT PRIMARY KEY,
                                      original_name VARCHAR(255),
    formatted_name VARCHAR(255),
    path VARCHAR(700),
    extension VARCHAR(20),
    imagable_id int,
    imagable_type VARCHAR(500),


    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    deleted_at TIMESTAMP NULL DEFAULT NULL,


    index images_imagableid_idx (imagable_id),
    index images_imagabletype_idx (imagable_type)
    );

-- ============== Personal_access_tokens
DROP TABLE IF EXISTS personal_access_tokens;
CREATE TABLE `personal_access_tokens` (
                                          `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                                          `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                          `tokenable_id` bigint unsigned NOT NULL,
                                          `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                          `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
                                          `abilities` text COLLATE utf8mb4_unicode_ci,
                                          `last_used_at` timestamp NULL DEFAULT NULL,
                                          `expires_at` timestamp NULL DEFAULT NULL,
                                          `created_at` timestamp NULL DEFAULT NULL,
                                          `updated_at` timestamp NULL DEFAULT NULL,
                                          PRIMARY KEY (`id`),
                                          UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
                                          KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
);


-- ============== Password_reset_tokens
DROP TABLE IF EXISTS password_reset_tokens;
CREATE TABLE `password_reset_tokens` (
                                         `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `created_at` timestamp NULL DEFAULT NULL,
                                         PRIMARY KEY (`email`)
);




set foreign_key_checks=1;
