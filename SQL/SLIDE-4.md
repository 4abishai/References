## Built-in Functions

```sql
SELECT FUNCTION FROM table_name;
```
### Group Functions

| Function                 | Example                                                            | Description                                                             |
| ------------------------ | ------------------------------------------------------------------ | ----------------------------------------------------------------------- |
| COUNT([DISTINCT] column) | `SELECT COUNT(MGR) FROM EMP; SELECT COUNT(DISTINCT MGR) FROM EMP;` | This function counts the number of rows without considering NULL values |
| COUNT(*)                 | `SELECT COUNT(*) FROM EMP;`                                        | It counts the number of rows including NULL values.                     |
| SUM([DISTINCT] column)   | `SELECT SUM(DISTINCT STUD) FROM SCHOOL`                            | It finds the sum of all values in a column ignoring the NULL values     |
| AVG([DISTINCT] column)   | `SELECT AVG(SAL) FROM EMP;`                                        | It finds the average of all values in a column ignoring the NULL values |
| MAX([DISTINCT] column)   | `SELECT MAX(SAL) FROM EMP;`                                        | It finds the maximum value in the column ignoring the NULL values       |
| MIN([DISTINCT] column)   | `SELECT MIN(SAL) FROM EMP;`                                        | It finds the minimum value in the column ignoring the NULL values       |
### Scalar Functions
#### Date Functions

| Function                          | Example                                                      | Description                                                    |
| --------------------------------- | ------------------------------------------------------------ | -------------------------------------------------------------- |
| SYSDATE                           | `SELECT SYSDATE FROM DUAL;`                                  | It is the pseudo column that returns the system’s current date |
| ADD_MONTHS(date, n)               | `SELECT ADD_MONTHS(HIREDATE, 4) FROM EMP WHERE EMP_NO=7369;` | It adds calendar months to a date                              |
| LAST_DAY(date)                    | `SELECT LAST_DAY(SYSDATE) FROM DUAL;`                        | It returns the last day of the month                           |
| MONTHS_BETWEEN(date1, date2)      | `SELECT MONTHS_BETWEEN(SYSDATE,’23-JAN-89’) FROM DUAL;`      | It finds the number of months between two dates                |
| NEXT_DAY(date, ’day’)             | `SELECT NEXT_DAY(SYSDATE, ’MONDAY’) FROM DUAL;`              | It finds the next occurrence of a day from the given date      |
| EXTRACT(YEAR/MONTH/DAY FROM date) | `SELECT EXTRACT(MONTH FROM SYSDATE) FROM DUAL;`              | This extracts the year, month, or day from a date value        |
#### Numeric Functions

| Function                          | Example                                                      | Description                                                                   |
| --------------------------------- | ------------------------------------------------------------ | ----------------------------------------------------------------------------- |
| ABS(n)                            | `SELECT ABS(5), ABS(-100) FROM DUAL;`                        | It returns the absolute value of n                                            |
| CEIL(n)                           | `SELECT CEIL(-5.2), CEIL(5.7) FROM DUAL;`                    | This returns the smallest integer greater than or equal to the<br>given value |
| FLOOR(n)                          | `SELECT FLOOR(-5.2), FLOOR(5.7) FROM DUAL;`                  | This returns the largest integer less than or equal to the given<br>value     |
| EXP(n)                            | `SELECT EXP(5) FROM DUAL;`                                   | It returns the exponent e raised to power n                                   |
| LN(n)                             | `SELECT LN(2) FROM DUAL;`                                    | It returns the natural logarithm of n                                         |
| LOG(b, n)                         | `SELECT LOG(4,10) FROM DUAL;`                                | It returns logbn value                                                        |
| MOD(n, m)                         | `SELECT MOD(15,4) FROM DUAL;`                                | It returns the integer remainder of n/m                                       |
| POWER(m, n)                       | `SELECT POWER(4,3) FROM DUAL;`                               | It returns m raised to power n                                                |
| SQRT(n)                           | `SELECT SQRT(25) FROM DUAL;`                                 | It returns the square root of the number n                                    |
| ROUND(m, [n])                     | `SELECT ROUND(15.19,1), ROUND(15.19) FROM DUAL;`             | It returns m, rounded to n places to the right of a decimal point             |
| TRUNC(m, n)                       | `SELECT TRUNC(15.19,1) FROM DUAL;`                           | It returns the truncated value of m up to n positions                         |
| SIGN(n)                           | `SELECT SIGN(-8.5) FROM DUAL;`                               | It returns the sign of number n: -1 for negative, 0 for zero, 1 for positive  |
| SIN(n)                            | `SELECT SIN(60), SIN(1.047167) FROM DUAL;`                   | It returns sine of n, where n is in radian                                    |
#### Character Functions

| Function           | Example                                                           | Description                                                                                  |
| ------------------ | ----------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| CHR(n)             | `SELECT CHR(70) FROM DUAL;`                                       | It returns the ASCII character corresponding to the integer n                                |
| CONCAT(s1, s2)     | `SELECT CONCAT(’RAM’,’KRISHNA’), ’RAM’\|\|’KRISHNA’ FROM DUAL;`   | It joins the first string to the second string. It is similar to the \|\|<br>operator        |
| LPAD(s, n, c)      | `SELECT LPAD(’ORACLE’,10,’*’) FROM DUAL;`                         | It pads the string s with the character c to the left to a total width of n                  |
| RPAD(s, n, c)      | `SELECT RPAD(’ORACLE’,10,’*’) FROM DUAL;`                         | It pads the string s with the character c to the right to a total width of n                 |
| INITCAP(s)         | `SELECT INITCAP(’HELLO’) FROM DUAL;`                              | It returns the string with capitalization of the first letter in each word                   |
| LOWER(s)           | `SELECT LOWER(’HELLO’) FROM DUAL;`                                | It converts each letter to lowercase                                                         |
| UPPER(s)           | `SELECT UPPER(’HeLLo’) FROM DUAL;`                                | It converts each letter to uppercase                                                         |
| LTRIM(s, c)        | `SELECT LTRIM(E_NAME,’S’) FROM EMP;`                              | It trims the string s from the left when the characters specified, c, is present in s        |
| RTRIM(s, c)        | `SELECT RTRIM(E_NAME,’I’) FROM EMP;`                              | It trims the string s from the right when the characters<br>specified, c, is present in s    |
| REPLACE(s, s1, s2) | `SELECT REPLACE(’ORACLE’,’RAC’,’V’) FROM DUAL;`                   | It returns the string s with the replacement of s2 in place of s1                            |
| SUBSTR(s, n, m)    | `SELECT SUBSTR(’DATABASE’,3,2) FROM DUAL;`                        | It returns a substring, starting at character position n, and returns m number of characters |
| LENGTH(s)          | `SELECT LENGTH(’ORACLE’) FROM DUAL;`                              | It returns the number of characters present in the string s                                  |
| SOUNDEX(s)         | `SELECT E_NAME FROM EMP WHERE SOUNDEX(E_NAME)=SOUNDEX(’KEEING’);` | It compares words that are spell differently, but sound alike                                |
#### Conversion Functions


| Function                  | Example                                                                                            | Description                                                                                                                                 |
| ------------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| TO_NUMBER(char [,format]) | `SELECT SUM(TO_NUMBER(SAL)) FROM EMP;`                                                             | It converts a character value with valid digits to a number using the given format                                                          |
| TO_DATE(char [,format])   | `SELECT TO_DATE(’January 7, 1988’,’MONTH DD, YYYY’) FROM DUAL;`                                    | It converts a character value to date value based on the format provided                                                                    |
| TO_CHAR(number [,format]) | `SELECT TO_CHAR(17145,’$999,999’) FROM DUAL;`<br>`SELECT TO_CHAR(17145,’$000,000’) FROM DUAL;`<br> | It converts a number to a `VARCHAR` value based on the format provided. 0 is used for compulsory purpose and 9 is used for optional purpose |
| TO_CHAR(date [,format])   | `SELECT TO_CHAR(HIREDATE,’MONTH DD, YYYY’) FROM EMP WHERE EMP_NO=7566;`                            | It converts a date to a `VARCHAR` value based on the format provided                                                                        |



