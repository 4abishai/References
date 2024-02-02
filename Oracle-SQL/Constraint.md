# Database Constraint Documentation

## NOT NULL Constraint

| Format | Example | Description |
| ------ | ------- | ----------- |
| columnname datatype(size) NOT NULL | `email VARCHAR(50) NOT NULL` | Specifies that the column must not contain any NULL values. |
| columnname datatype(size) CONSTRAINT constraintname NOT NULL | `email VARCHAR(50) CONSTRAINT email_not_null NOT NULL` | Provides a name for the NOT NULL constraint for easier management. |

**Dropping NOT NULL Constraint**

A NOT NULL constraint can be dropped by executing:

```sql
ALTER TABLE tablename DROP CONSTRAINT constraintname;
```

## Unique Constraint

| Format | Example | Description |
| ------ | ------- | ----------- |
| ****Column level****: Columnname datatype(size) UNIQUE | `username VARCHAR(50) UNIQUE` | Ensures that each value in the column is unique. |
| Columnname datatype(size) CONSTRAINT constraintname UNIQUE | `username VARCHAR(50) CONSTRAINT username_unique UNIQUE` | Assigns a specific name to the unique constraint. |
| ****Table level****: CONSTRAINT constraintname UNIQUE(columns) | `CONSTRAINT username_unique UNIQUE(username)` | Defines a unique constraint at the **Table level**. |

**Dealing with Unique Constraint in an existing table**

To add or drop a unique constraint:

```sql
ALTER TABLE tablename ADD CONSTRAINT constraintname UNIQUE(columns);
ALTER TABLE tablename DROP CONSTRAINT constraintname;
```

## Primary Key Constraint (Entity Integrity Constraint)

| Format | Example | Description |
| ------ | ------- | ----------- |
| **Column level**: Columnname datatype(size) PRIMARY KEY | `user_id INT PRIMARY KEY` | Defines a column as the primary key for the table. |
| Columnname datatype(size) CONSTRAINT constraintname PRIMARY KEY | `user_id INT CONSTRAINT pk_user PRIMARY KEY` | Names the primary key constraint for easier reference. |
| ****Table level****: CONSTRAINT constraintname PRIMARY KEY(columns) | `CONSTRAINT pk_user PRIMARY KEY(user_id)` | Declares the primary key constraint at the **Table level**. |

## Foreign Key Constraint (Referential Integrity Constraint)

| Format | Example | Description |
| ------ | ------- | ----------- |
| **Column level**: Columnname datatype(size) [CONSTRAINT constraintname] REFERENCES tablename(columns) | `user_id INT CONSTRAINT fk_user REFERENCES users(id)` | Establishes a relationship between two tables. |
| Columnname datatype(size) [CONSTRAINT constraintname] REFERENCES tablename | `user_id INT CONSTRAINT fk_user REFERENCES users` | Defines a foreign key constraint without specifying the referenced column. |
| **Table level**: CONSTRAINT constraintname FOREIGN KEY(columns) REFERENCES tablename(columns) | `CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id)` | Defines a foreign key constraint at the **Table level**. |

**ON DELETE CASCADE**

Specifies that when a referenced row in the parent table is deleted, all corresponding rows in the child table are automatically deleted.

## Dealing with Primary Key Constraint in an existing table

To add or drop a primary key constraint:

```sql
ALTER TABLE tablename ADD CONSTRAINT constraintname PRIMARY KEY(columns);
ALTER TABLE tablename DROP PRIMARY KEY [CASCADE];
```

## Check Constraint

| Format | Example | Description |
| ------ | ------- | ----------- |
| **Column level**: Columnname datatype(size) CONSTRAINT constraintname CHECK(condition) | `age INT CONSTRAINT check_age CHECK(age >= 18)` | Enforces a condition on the values allowed in the column. |
| **Table level**: CONSTRAINT constraintname CHECK(condition) | `CONSTRAINT check_age CHECK(age >= 18)` | Specifies a check constraint at the **Table level**. |

## Dealing with Check Constraint in an existing table

To add or drop a check constraint:

```sql
ALTER TABLE tablename ADD CONSTRAINT constraintname CHECK (condition);
ALTER TABLE tablename DROP CONSTRAINT constraintname;
```

## DEFAULT Value

| Format | Example | Description |
| ------ | ------- | ----------- |
| Columnname datatype(size) DEFAULT value | `status VARCHAR(10) DEFAULT 'active'` | Sets a default value for the column if no value is specified during insertion. |
| Columnname datatype(size) DEFAULT value constraint definition | `status VARCHAR(10) DEFAULT 'active' CONSTRAINT df_status DEFAULT 'active'` | Assigns a name to the default value constraint. |

## Viewing USER Constraints

You can view all constraints for a user table with:

```sql
SELECT * FROM USER_CONSTRAINTS;
```

To filter constraints for a specific table, use:

```sql
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = tablename;
```


