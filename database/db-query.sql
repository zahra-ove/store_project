-- ============== Users
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    username VARCHAR(255),
    `password` VARCHAR(255),
    mobile VARCHAR(30),
    email VARCHAR(255),
    email_verified_at TIMESTAMP NULL DEFAULT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    deleted_at TIMESTAMP NULL DEFAULT NULL
);


-- ============== Categories
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    deleted_at TIMESTAMP NULL DEFAULT NULL
);


-- ============== Products
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
CREATE TABLE IF NOT EXISTS attributes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    deleted_at TIMESTAMP NULL DEFAULT NULL
);



-- ============== Attribute Category
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
CREATE TABLE IF NOT EXISTS tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
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
