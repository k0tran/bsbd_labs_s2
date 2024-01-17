-- Tables

CREATE SCHEMA pdb;
CREATE SCHEMA staff;
CREATE SCHEMA sales;
CREATE SCHEMA logistics;
CREATE SCHEMA inventory;

CREATE TABLE pdb.vendor (
    id INTEGER PRIMARY KEY,
    name TEXT,
    office TEXT,
    rating INTEGER
);

CREATE TABLE pdb.category (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE pdb.product_type (
    code INTEGER PRIMARY KEY,
    vendor INTEGER,
    category INTEGER,
    raise INTEGER,
    FOREIGN KEY(vendor) REFERENCES pdb.vendor(id),
    FOREIGN KEY(category) REFERENCES pdb.category(id)
);

CREATE TABLE pdb.country (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE staff.job (
    id INTEGER PRIMARY KEY,
    name TEXT,
    salary INTEGER,
    days_per_week INTEGER
);

CREATE TABLE staff.employee (
    id INTEGER PRIMARY KEY,
    job INTEGER,
    name TEXT,
    active BOOLEAN,
    exp_date TIMESTAMP,
    FOREIGN KEY(job) REFERENCES staff.job(id)
);

CREATE TABLE sales.customer (
    id INTEGER PRIMARY KEY,
    phone INTEGER,
    name TEXT,
    reg_date TIMESTAMP
);

CREATE TABLE sales.sale (
    id INTEGER PRIMARY KEY,
    date TIMESTAMP,
    employee INTEGER,
    customer INTEGER,
    bonus INTEGER,
    bonus_used INTEGER,
    FOREIGN KEY(employee) REFERENCES staff.employee(id),
    FOREIGN KEY(customer) REFERENCES sales.customer(id)
);

CREATE TABLE logistics.supply (
    id INTEGER PRIMARY KEY,
    date DATE,
    done BOOLEAN,
    employee INTEGER,
    price INTEGER,
    FOREIGN KEY(employee) REFERENCES staff.employee(id)
);

CREATE TABLE inventory.product (
    id INTEGER PRIMARY KEY,
    type INTEGER,
    country INTEGER,
    price INTEGER,
    supply INTEGER,
    sold BOOLEAN,
    sale INTEGER,
    FOREIGN KEY(type) REFERENCES pdb.product_type(code),
    FOREIGN KEY(country) REFERENCES pdb.country(id),
    FOREIGN KEY(supply) REFERENCES logistics.supply(id),
    FOREIGN KEY(sale) REFERENCES sales.sale(id)
);

-- Roles
-- NOTE: In production use ECRYPTED password set

CREATE ROLE pdb_role LOGIN PASSWORD '123';
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pdb TO pdb_role;
GRANT USAGE ON SCHEMA pdb TO pdb_role;

CREATE ROLE sales_role LOGIN PASSWORD '123';
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA sales TO sales_role;
GRANT SELECT, UPDATE ON ALL TABLES IN SCHEMA inventory TO sales_role;
GRANT USAGE ON SCHEMA sales TO sales_role;
GRANT USAGE ON SCHEMA inventory TO sales_role;

CREATE ROLE staff_role LOGIN PASSWORD '123';
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA staff TO staff_role;
GRANT SELECT ON ALL TABLES IN SCHEMA sales TO staff_role;
GRANT USAGE ON SCHEMA staff TO staff_role;
GRANT USAGE ON SCHEMA sales TO staff_role;

CREATE ROLE logistics_role LOGIN PASSWORD '123';
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA logistics TO logistics_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA inventory TO logistics_role;
GRANT USAGE ON SCHEMA logistics TO logistics_role;
GRANT USAGE ON SCHEMA inventory TO logistics_role;
