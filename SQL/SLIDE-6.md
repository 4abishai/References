When the required data are present in more than one table, related tables are joined using a join condition.
### CROSS JOIN

A cross join, also known as a Cartesian join, is a type of join operation in a relational database management system (RDBMS) that combines each row from one table with each row from another table. It produces a result set that is the Cartesian product of the two input tables. 

```sql
SELECT Department.deptno, location, ename, eid 
FROM Employee, Department;
   ```

```sql
SELECT d.deptno, d.location, e.ename, e.eid 
FROM Employee e, Department d;
   ```

 ```sql
SELECT * 
FROM Employee 
CROSS JOIN Department;
   ```

### INNER JOIN

- Tuples with `NULL` values in the join attributes are eliminated.
- It is the default `JOIN` operation.

Let's say we have two tables, `table1` and `table2`, with the following data:

```plaintext
table1
+----+-------+
| id | value |
+----+-------+
| 1  | 10    |
| 2  | 20    |
| 3  | NULL  |
+----+-------+

table2
+----+-------+
| id | value |
+----+-------+
| 1  | 100   |
| 2  | 200   |
| 4  | NULL  |
+----+-------+
```

If we perform an inner join on `id`, we would get the following result:

```plaintext
result
+----+-------+----+-------+
| id | value | id | value |
+----+-------+----+-------+
| 1  | 10    | 1  | 100   |
| 2  | 20    | 2  | 200   |
+----+-------+----+-------+
```

The tuple from `table1` with `id=3` is not included in the result because it has a NULL value in the join attribute. 
Similarly, the tuple from `table2` with `id=4` is not included in the result for the same reason.

#### Theta JOIN

Theta join is a join with a specified condition involving a column from each table.

```sql
SELECT columns
FROM table1
JOIN table2 ON condition;
```

```sql
SELECT employees.*, departments.*
FROM employees
JOIN departments ON employees.salary > departments.budget;

-- same as
SELECT employees.*, departments.*
FROM employees
INNER JOIN departments ON employees.salary > departments.budget;

-- same as
SELECT employees.*, departments.* 
FROM employees, departments 
WHERE employees.salary > departments.budget;
```

#### Equi JOIN

An equi join, on the other hand, is a specific type of theta join where the condition used for joining is an equality condition between two columns.

```sql
SELECT columns
FROM table1
JOIN table2 ON table1.column_name = table2.column_name;
```

```sql
SELECT employees.*, departments.*
FROM employees
JOIN departments ON employees.department_id = departments.department_id;
```


```sql
SELECT employees.*, departments.*
FROM employees
JOIN departments ON employees.id = departments.id 
WHERE employees.salary > departments.budget;
```

- The join condition `employees.id = departments.id` is an equality condition, which is characteristic of an equi join.
- The filtering condition `employees.salary > departments.budget` is not part of the join condition, but rather it's used to filter the result set after the join is performed.
#### NATURAL JOIN

- In a natural join, the join condition is implicit and based on *columns with the same name* in both tables.
- This is not the correct syntax because `NATURAL JOIN` does not require an `ON` clause to specify the join condition.

```sql
SELECT columns
FROM table1
NATURAL JOIN table2;
```

Here's an example of using a natural join to combine these tables based on the `department_id` column, which is common to both tables:

```sql
CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT
);

CREATE TABLE departments (
    department_id INT,
    department_name VARCHAR(50)
);
```

```sql
SELECT *
FROM employees
NATURAL JOIN departments;
```

In this example, the natural join will automatically match rows from the `employees` table with rows from the `departments` table where the `department_id` values are equal. The result set will include columns from both tables, but only one `department_id` column since the columns with the same name are merged into a single column in the result set.

### OUTER JOIN

- In an outer join, tuples with NULL-valued join attributes are retained in the result.
- The `OUTER` keyword is optional and can be omitted without changing the behavior of the query.

####  LEFT OUTER JOIN

Left outer join preserves all rows in left table even though there is no matching tuples present in the right table.

```plaintext
result
+----+-------+------+-------+
| id | value |  id  | value |
+----+-------+------+-------+
| 1  | 10    |  1   | 100   |
| 2  | 20    |  2   | 200   |
| 3  | NULL  | NULL | NULL  |
+----+-------+------+-------+
```

In this result, the tuple from `table1` with `id=3` is included, even though it has a NULL value in the join attribute. The tuple from `table2` with `id=4` is not included, but a row with NULL values is added to the result to indicate that there was no match for `id=3` in `table2`.

```sql
SELECT columns
FROM table1
LEFT JOIN table2 ON table1.column = table2.column;
```

```sql
SELECT * 
FROM Employee 
LEFT JOIN Department
ON Employee.deptno= Department.deptno;

-- same as
SELECT * 
FROM Employee 
LEFT OUTER JOIN Department
ON Employee.deptno= Department.deptno;
```

#### RIGHT OUTER JOIN

Left outer join preserves all rows in left table even though there is no matching tuples present in the right table.

```plaintext
result
+------+-------+----+-------+
|  id  | value | id | value |
+------+-------+----+-------+
|  1   |  10   |  1 |  100  |
|  2   |  20   |  2 |  200  |
| NULL | NULL  |  4 | NULL  |
+------+-------+----+-------+
```

In this result, the tuple from `table2` with `id=4` is included, even though it has a NULL value in the join attribute. A row with NULL values is added to the result to indicate that there was no match for `id=4` in `table1`.

```sql
SELECT columns
FROM table1
RIGHT JOIN table2 ON table1.column = table2.column;
```

```sql
SELECT * 
FROM Employee 
RIGHT JOIN Department
ON Employee.deptno = Department.deptno;
```

#### FULL OUTER JOIN

In a full outer join, tuples with NULL-valued join attributes from both tables are retained in the result.

```plaintext
result
+------+-------+------+-------+
|  id  | value |  id  | value |
+------+-------+------+-------+
|   1  |  10   |   1  |  100  |
|   2  |  20   |   2  |  200  |
|   3  | NULL  | NULL |  NULL |
| NULL | NULL  |   4  | NULL  |
+------+-------+------+-------+
```

In this result, all tuples from both `table1` and `table2` are included, even those with NULL values in the join attributes. Rows with NULL values are added to indicate the absence of matches in the respective tables.

**Oracle:**
```sql
SELECT *
FROM table1
FULL OUTER JOIN table2
ON table1.column = table2.column;
```

**MySQL:**

MySQL does not directly support the `FULL OUTER JOIN` syntax. So,

```sql
SELECT *
FROM table1
LEFT JOIN table2 ON table1.column = table2.column

UNION

SELECT *
FROM table1
RIGHT JOIN table2 ON table1.column = table2.column;
```

```sql
-- Oracle example
SELECT e.emp_id, e.emp_name, d.dept_id, d.dept_name
FROM employees e
FULL OUTER JOIN departments d
ON e.dept_id = d.dept_id;
```

### Self JOIN

It joins a relation to itself by a condition.

```sql
SELECT columns
FROM table1 alias1
JOIN table2 alias2 ON alias1.column condition alias2.column;
```

```sql
SELECT e1.Name AS Employee, e2.Name AS Manager
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.EmployeeID;
```

## Set Operators
### UNION

Union is used to combine data from two relations.
```sql
SELECT name, job FROM Employee WHERE dept=20 UNION
SELECT name, job FROM Employee WHERE dept=30;
```

### DIFFERENCE

Difference is used to identify the rows that are in one relation and not in another.
```sql
SELECT name, job FROM Employee WHERE dept=20 MINUS
SELECT name, job FROM Employee WHERE dept=30;
```

### INTERSECTION

```sql
SELECT name, job FROM Employee WHERE dept=20 INTERSECT
SELECT name, job FROM Employee WHERE dept=30;
```
