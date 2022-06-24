CREATE DATABASE IF NOT EXISTS store;

USE store;

CREATE TABLE IF NOT EXISTS products (
    sku INT,
    l3 VARCHAR(20) NOT NULL,
    qty TINYINT NOT NULL,
    category VARCHAR(255) NOT NULL,
    price DOUBLE(10,2),
    description VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (sku)
);

CREATE TABLE IF NOT EXISTS transmissionsummary (
    qtysum TINYINT NOT NULL,
    recordcount TINYINT NOT NULL,
    Id VARCHAR(255),
    PRIMARY KEY (Id)
);
