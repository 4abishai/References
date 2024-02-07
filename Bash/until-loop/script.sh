#!/bin/bash

counter=0

until [ $counter -eq 5 ]
do
    echo "counter is $counter"
    var=$((counter++))
done

echo "$var"


counter=0

# We can also use arithmatic expansion
# until (( counter == 5 ))