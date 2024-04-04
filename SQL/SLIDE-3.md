- Constraints can be imposed to the database tables either with the `CREATE` or `ALTER` command.
- The abbreviation for different constraint types are: pk for`PRIMARY` Key, fk for `FOREIGN` Key, uk for `UNIQUE`, chk or ck for `CHECK` and nn for `NOT NULL` constraint.

### Dealing with Constraints in an existing table

#### Dropping Constraint:

```sql
ALTER TABLE tablename DROP CONSTRAINT constraintname;
```

#### Adding Constraint:

```sql
ALTER TABLE tablename ADD CONSTRAINT constraintname <CONSTRAINT-TYPE>(columns);
```

#### NOT NULL Constraint

| Format                                                       | Example                                                | Description                                                        |
| ------------------------------------------------------------ | ------------------------------------------------------ | ------------------------------------------------------------------ |
| columnname datatype(size) NOT NULL                           | `email VARCHAR(50) NOT NULL`                           | Specifies that the column must not contain any NULL values.        |
| columnname datatype(size) CONSTRAINT constraintname NOT NULL | `email VARCHAR(50) CONSTRAINT email_not_null NOT NULL` | Provides a name for the NOT NULL constraint for easier management. |

#### Unique Constraint

| Format                                                         | Example                                                  | Description                                         |
| -------------------------------------------------------------- | -------------------------------------------------------- | --------------------------------------------------- |
| **Column level**: <br>Columnname datatype(size) UNIQUE         | `username VARCHAR(50) UNIQUE`                            | Ensures that each value in the column is unique.    |
| Columnname datatype(size) CONSTRAINT constraintname UNIQUE     | `username VARCHAR(50) CONSTRAINT username_unique UNIQUE` | Assigns a specific name to the unique constraint.   |
| **Table level**: <br>CONSTRAINT constraintname UNIQUE(columns) | `CONSTRAINT user_unique UNIQUE(id,name)`                 | Defines a unique constraint at the **Table level**. |

## Primary Key Constraint (Entity Integrity Constraint)

| Format                                                          | Example                                      | Description                                                 |
| --------------------------------------------------------------- | -------------------------------------------- | ----------------------------------------------------------- |
| **Column level**: <br>Columnname datatype(size) PRIMARY KEY     | `user_id INT PRIMARY KEY`                    | Defines a column as the primary key for the table.          |
| Columnname datatype(size) CONSTRAINT constraintname PRIMARY KEY | `user_id INT CONSTRAINT pk_user PRIMARY KEY` | Names the primary key constraint for easier reference.      |
| **Table level**: CONSTRAINT constraintname PRIMARY KEY(columns) | `CONSTRAINT pk_user PRIMARY KEY(user_id)`    | Declares the primary key constraint at the **Table level**. |

## Foreign Key Constraint (Referential Integrity Constraint)

- Foreign key and the referenced primary key columns need not have the same name, but the data type, size and domain must match.

| Format                                                                                                    | Example                                                        | Description                                                                |
| --------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------------------- |
| **Column level**: <br>Columnname datatype(size) [CONSTRAINT constraintname] REFERENCES tablename(columns) | `user_id INT CONSTRAINT fk_user REFERENCES users(id)`          | Establishes a relationship between two tables.                             |
| Columnname datatype(size) [CONSTRAINT constraintname] REFERENCES tablename                                | `user_id INT CONSTRAINT fk_user REFERENCES users`              | Defines a foreign key constraint without specifying the referenced column. |
| **Table level**: <br>CONSTRAINT constraintname FOREIGN KEY(columns) REFERENCES tablename(columns)         | `CONSTRAINT fk_user FOREIGN KEY(id,name) REFERENCES users(id)` | Defines a foreign key constraint at the **Table level**.                   |

**ON DELETE CASCADE**

| Format                                                                                                                      | Example                                                                          | Description                                                                |
| --------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| **Column level**: <br>Columnname datatype(size) [CONSTRAINT constraintname] REFERENCES tablename(columns) ON DELETE CASCADE | `user_id INT CONSTRAINT fk_user REFERENCES users(id) ON DELETE CASCADE`          | Establishes a relationship between two tables.                             |
| Columnname datatype(size) [CONSTRAINT constraintname] REFERENCES tablename ON DELETE CASCADE                                | `user_id INT CONSTRAINT fk_user REFERENCES users ON DELETE CASCADE`              | Defines a foreign key constraint without specifying the referenced column. |
| **Table level**: <br>CONSTRAINT constraintname FOREIGN KEY(columns) REFERENCES tablename(columns) ON DELETE CASCADE         | `CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE` | Defines a foreign key constraint at the **Table level**.                   |

Specifies that when a referenced row in the parent table is deleted, all corresponding rows in the child table are automatically deleted.

## Check Constraint

| Format                                                                                     | Example                                         | Description                                               |
| ------------------------------------------------------------------------------------------ | ----------------------------------------------- | --------------------------------------------------------- |
| **Column level**: <br>Columnname datatype(size) CONSTRAINT constraintname CHECK(condition) | `age INT CONSTRAINT check_age CHECK(age >= 18)` | Enforces a condition on the values allowed in the column. |
| **Table level**: <br>CONSTRAINT constraintname CHECK(condition)                            | `CONSTRAINT check_age CHECK(age >= 18)`         | Specifies a check constraint at the **Table level**.      |

## DEFAULT Value

- The default value gets overwritten if a user enters another value. 
- The default value is used if a `NULL` value is inserted. 
- The DEFAULT value is defined in the column level.

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
