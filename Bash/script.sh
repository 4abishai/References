#!/bin/bash

counter=1

while (( counter<=5))
do
    echo "$counter"
    ((counter = counter + 1))
    # or ((counter++))
    # or ((++counter))
done