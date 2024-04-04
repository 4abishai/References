## Sub Query
Subquery is a `SELECT` statement that is nested within another `SELECT` statement, which returns intermediate results.

### Single-row subquery

- It is a subquery that returns only one row of data.
- Single-row subquery returns zero or one row to the outer SQL statement.
- Inner query evaluates first, generates values that are tested in the condition of the outer query.

```sql
SELECT name
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);
```

Department and the departmental average age which are less than the maximum departmental age.

```sql
SELECT deptno, AVG(age) 
FROM Student 
GROUP BY deptno
HAVING AVG(age)<(
	SELECT MAX(AVG(age)) 
	FROM Student
	GROUP BY deptno
);
```

**Inline View**: SELECT statement in the FROM clause is used as the data source for the outer SELECT statement.

```sql
SELECT department_id, avg_salary
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS department_avg_salary;
```

The inner query calculates the average salary for each department using the `AVG()` function and the `GROUP BY` clause. The result is then aliased as `department_avg_salary` and used in the outer query to select the department ID and the average salary.

```sql
SELECT age
FROM (
	SELECT age
	FROM Student
	ORDER BY age DESC;
) 
WHERE ROWNUM <= 2;
```

The query retrieves the top 2 oldest ages from the `Student` table by first sorting the ages in descending order in a subquery and then selecting the top 2 rows from the sorted result in the outer query.

### Multiple-row Subquery
- It is a subquery that returns more than one row of data.
- It uses either `IN`, `ALL` or `ANY` operator.
```sql
SELECT roll, name 
FROM Student 
WHERE age<ANY(
	SELECT age 
	FROM Customer
);

SELECT roll, name 
FROM Student 
WHERE age< IN(
	SELECT age 
	FROM Customer
);

SELECT roll, name 
FROM Student 
WHERE age<ALL(
	SELECT age 
	FROM Customer
);
```

```sql
SELECT roll, deptno, age
FROM Student
WHERE (deptno, age) IN (
	SELECT deptno, MIN(age)
	FROM Student
	GROUP BY deptno;
);
```

The query retrieves the roll, deptno, and age of students who are the youngest in each department by first finding the minimum age for each department in a subquery and then selecting the students whose (deptno, age) tuple matches the (deptno, MIN(age)) tuple for each department in the outer query.

The following is wrong:

```sql
SELECT roll, deptno, MIN(age) AS age 
FROM Student 
GROUP BY deptno;
```

When using `GROUP BY`, any column that is not an aggregate function (like `MIN`, `MAX`, `AVG`, etc.) must be included in the `GROUP BY` clause.
As `roll` is not an aggregate function it must be included in the `GROUP BY` clause for the command to be valid.

```sql
SELECT roll, deptno, MIN(age) AS age 
FROM Student 
GROUP BY deptno, roll;
```

But this will not return the same result. The first query uses the `MIN` function in the `SELECT` statement to find the minimum age for each `deptno` group, while the second query uses a subquery with `IN` to filter out rows where the `(deptno, age)` tuple matches the minimum age for each `deptno` group.

### Correlated Subquery
- In a correlated subquery, the inner query can reference columns from the outer query.
- Unlike the nested subqueries where the inner query is executed first and only one time and only after that outer query executes. Here, the inner query is executed first and once for each row in the outer query.

```sql
SELECT column1, column2, ....
FROM table1 outer
WHERE column1 operator
                    (SELECT column1, column2
                     FROM table2
                     WHERE expr1 = 
                               outer.expr2);
```

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50)
);

CREATE TABLE salaries (
    employee_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
```

```sql
SELECT employee_id, employee_name, salary
FROM salaries s1
WHERE salary > (
    SELECT AVG(salary)
    FROM salaries s2
    WHERE s1.employee_id = s2.employee_id
);
```

In this query, the subquery `(SELECT AVG(salary) FROM salaries s2 WHERE s1.employee_id = s2.employee_id)` is correlated with the outer query `salaries s1`. For each row in the outer query, the subquery calculates the average salary for that specific employee (`s1.employee_id = s2.employee_id`). Then, the outer query selects only those employees whose salary is greater than this average salary.

#### JOIN

Same result can be achieved using a `JOIN` instead of a correlated subquery.

```sql
SELECT e.employee_id, e.employee_name, s.salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
JOIN (
    SELECT AVG(salary) AS avg_salary
    FROM salaries
) AS avg_sal ON s.salary > avg_sal.avg_salary;
```

### UPDATE with Subquery

The column values can be updated with the help of a subquery statement.

```sql
UPDATE Student 
SET age=(
	SELECT AVG(age) FROM
	Student
) 
WHERE roll=4;
```

### DELETE with Subquery

A row or rows from a table can be deleted based on a value returned by a subquery.

```sql
DELETE FROM Student 
WHERE age>(
	SELECT AVG(age)
	FROM Student
);
```

### TOP-N analysis

TOP-N queries are used to sort rows in a table and then find the first N largest or smallest values based on a specified ordering.

```sql
SELECT age
FROM (
    SELECT age
    FROM Student
    ORDER BY age DESC
)
WHERE ROWNUM <= 2;
```

```sql
SELECT roll, name
FROM (
    SELECT roll, name
    FROM (
        SELECT roll, name
        FROM student
        ORDER BY roll DESC
    )
)
WHERE ROWNUM <= 4;
```