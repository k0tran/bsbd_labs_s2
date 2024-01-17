-- should allow
SELECT name FROM staff.employee;

-- should deny
DELETE FROM inventory.product WHERE price > 1000;
