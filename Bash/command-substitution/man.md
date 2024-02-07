Command substitution is a feature in Unix-like shells such as bash, which allows you to run a command and capture its output into a variable or directly use it within another command. There are two common syntaxes for command substitution:

1. Using backticks (``)
2. Using `$()`

Here's how each syntax works:

1. Using backticks (``):

```bash
output=`command`
```

Example:
```bash
current_date=`date`
echo "The current date is $current_date"
```

2. Using `$()`:

```bash
output=$(command)
```

Example:
```bash
current_date=$(date)
echo "The current date is $current_date"
```

In both cases, the shell executes the command within the backticks or `$()` and captures the output. Then, the output is assigned to the variable (`output` in the examples above) which can be used later in the script.

Using `$()` is preferred over backticks because it is more readable and allows nesting of commands more easily. Additionally, backticks can be confused with single quotes in some situations, leading to potential issues. Therefore, `$()` is generally recommended for command substitution.