## Clauses
### GROUP BY

- Used to group rows that have the same values into summary rows, like "find the number of customers in each city" or "calculate the total sales for each product."
- It's often used with aggregate functions like `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()` to perform operations on each group.

```sql
SELECT column_name(s), aggregate_function(column_name)
FROM table_name
WHERE condition
GROUP BY column_name(s);
HAVING condition
```

### WHERE

It restricts the data before the grouping.

### HAVING

It restrict grouped data.
### WHERE clause v/s HAVING clause

In SQL, the `WHERE` clause is used to filter individual rows before they are grouped, while the `HAVING` clause is used to filter groups of rows after they have been grouped using the `GROUP BY` clause. Here's an example to illustrate the difference:

Let's say you have a table `orders` with columns `product_id`, `quantity`, and `price`. You want to find the total sales for each product, but you only want to include products with a quantity greater than 10. You can use the `WHERE` clause to filter the rows before they are grouped:

```sql
SELECT product_id, SUM(quantity * price) AS total_sales
FROM orders
WHERE quantity > 10
GROUP BY product_id;
```

In this example, the `WHERE quantity > 10` filters out rows where the quantity is not greater than 10 before the rows are grouped by `product_id`.

Now, let's consider a similar example, but this time you want to find the total sales for each product, but only include products with total sales greater than $100. You can use the `HAVING` clause to filter the groups after they have been grouped:

```sql
SELECT product_id, SUM(quantity * price) AS total_sales
FROM orders
GROUP BY product_id
HAVING SUM(quantity * price) > 100;
```

In this example, the `GROUP BY product_id` groups the rows by `product_id`, and the `SUM(quantity * price)` calculates the total sales for each group. The `HAVING SUM(quantity * price) > 100` filters out groups where the total sales are not greater than $100.

In summary, the `WHERE` clause is used to filter individual rows before they are grouped, while the `HAVING` clause is used to filter groups of rows after they have been grouped using the `GROUP BY` clause.


