-- Fill tables with example data

INSERT INTO pdb.vendor (id, name, office, rating) VALUES (1, 'Hatber', 'Россия, г. Москва, ул. X1, дом Y1', 8);
INSERT INTO pdb.vendor (id, name, office, rating) VALUES (2, 'Самсон', 'Россия, г. Воронеж, ул. X2, дом Y2', 7);
INSERT INTO pdb.vendor (id, name, office, rating) VALUES (3, 'Апплика', 'Россия, г. Москва, ул. X3, дом Y3', 6);

INSERT INTO pdb.category (id, name) VALUES (1, 'Ручки');
INSERT INTO pdb.category (id, name) VALUES (2, 'Тетради');
INSERT INTO pdb.category (id, name) VALUES (3, 'Карандаши');

INSERT INTO pdb.product_type (code, vendor, category, raise) VALUES (1001, 1, 1, 15);
INSERT INTO pdb.product_type (code, vendor, category, raise) VALUES (1002, 2, 1, 10);
INSERT INTO pdb.product_type (code, vendor, category, raise) VALUES (1003, 1, 2, 20);

INSERT INTO pdb.country (id, name) VALUES (1, 'Германия');
INSERT INTO pdb.country (id, name) VALUES (2, 'Россия');
INSERT INTO pdb.country (id, name) VALUES (3, 'Китай');

INSERT INTO staff.job (id, name, salary, days_per_week) VALUES (1, 'Менеджер', 5000, 4);
INSERT INTO staff.job (id, name, salary, days_per_week) VALUES (2, 'Кассир', 2500, 5);
INSERT INTO staff.job (id, name, salary, days_per_week) VALUES (3, 'Уборщик', 500, 7);

INSERT INTO staff.employee (id, job, name, active, exp_date) VALUES (1, 1, 'Джон Стоун', true, '2023-12-31');
INSERT INTO staff.employee (id, job, name, active, exp_date) VALUES (2, 2, 'Джек Воробей', true, '2024-06-30');
INSERT INTO staff.employee (id, job, name, active, exp_date) VALUES (3, 3, 'Партос', false, '2023-09-30');

INSERT INTO sales.customer (id, phone, name, reg_date) VALUES (1, 111, 'Вася Пупкин', '2022-01-15');
INSERT INTO sales.customer (id, phone, name, reg_date) VALUES (2, 121, 'Джек Ричер', '2022-02-28');
INSERT INTO sales.customer (id, phone, name, reg_date) VALUES (3, 131, 'Том Сойер', '2022-06-01');

INSERT INTO sales.sale (id, date, employee, customer, bonus, bonus_used) VALUES (1, '2023-06-20 10:30:00', 1, 1, 50, 0);
INSERT INTO sales.sale (id, date, employee, customer, bonus, bonus_used) VALUES (2, '2023-06-22 14:15:00', 2, 2, 25, 0);
INSERT INTO sales.sale (id, date, employee, customer, bonus, bonus_used) VALUES (3, '2023-06-23 11:00:00', 3, 3, 75, 75);

INSERT INTO logistics.supply (id, date, done, employee, price) VALUES (1, '2023-06-01', true, 1, 850);
INSERT INTO logistics.supply (id, date, done, employee, price) VALUES (2, '2023-06-15', true, 2, 750);
INSERT INTO logistics.supply (id, date, done, employee, price) VALUES (3, '2023-06-30', false, 3, 1400);

INSERT INTO inventory.product (id, type, country, price, supply, sold, sale) VALUES (1, 1001, 1, 999, 1, false, null);
INSERT INTO inventory.product (id, type, country, price, supply, sold, sale) VALUES (2, 1002, 2, 899, 2, true, 1);
INSERT INTO inventory.product (id, type, country, price, supply, sold, sale) VALUES (3, 1003, 3, 1499, 3, false, null);
INSERT INTO inventory.product (id, type, country, price, supply, sold, sale) VALUES (4, 1002, 2, 1299, 2, true, 2);
INSERT INTO inventory.product (id, type, country, price, supply, sold, sale) VALUES (5, 1001, 3, 129, 3, true, 3);