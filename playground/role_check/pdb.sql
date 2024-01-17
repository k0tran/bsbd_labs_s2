-- should allow
SELECT vendor FROM pdb.product_type;

-- should deny
SELECT salary, days_per_week FROM sales.employee;
