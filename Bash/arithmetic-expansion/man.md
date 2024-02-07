Arithmetic expansion is a feature in Bash that allows you to perform arithmetic operations directly within shell scripts. It's often used when you need to perform calculations or manipulate numeric values.

The syntax for arithmetic expansion in Bash is `(( expression ))`. Inside the double parentheses, you can use various arithmetic operators and variables to perform calculations. Here are some examples:

1. **Simple Arithmetic**:
   ```bash
   result=$((3 + 5))
   ```

2. **Variables and Arithmetic**:
   ```bash
   counter=10
   result=$((counter * 2))
   ```

3. **Increment/Decrement**:
   ```bash
   ((counter++))
   ((result--))
   ```

4. **Comparison**:
   ```bash
   if ((counter > 5)); then
       echo "Counter is greater than 5"
   fi
   ```

5. **Using Arithmetic in Conditions**:
   ```bash
   if ((counter == 0)); then
       echo "Counter is zero"
   fi
   ```

Inside the `(( ))`, you can use arithmetic operators like `+`, `-`, `*`, `/`, `%` for addition, subtraction, multiplication, division, and modulus respectively. You can also use comparison operators like `>`, `<`, `>=`, `<=`, `==`, `!=` for numeric comparison.

Arithmetic expansion is powerful and convenient for performing calculations directly within shell scripts without needing external tools or commands.