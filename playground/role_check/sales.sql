-- should allow
SELECT price FROM inventory.product;

-- should deny
DELETE FROM inventory.product WHERE price > 1000;
