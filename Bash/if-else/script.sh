#!/bin/bash

# Example 1: Numeric comparison
a=10
if [ $a -gt 10 ]
then
    echo "Greater than 10"
else
    echo "Not greater than 10"
fi

# Example 2: String comparison
string="hello"
if [ "$string" == "hello" ]
then
    echo "The string is 'hello'"
else
    echo "The string is not 'hello'"
fi

a=22

if [ $a -lt 25 ] && [ $a -gt 20 ]
then
      echo "You are in the range: [21, 24]"
else
       echo "not in the range: [21, 24]"
fi
