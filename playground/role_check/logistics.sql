-- should allow
SELECT price FROM inventory.product;

-- should deny
SELECT salary, days_per_week FROM sales.employee;