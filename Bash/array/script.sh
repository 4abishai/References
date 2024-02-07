#!/bin/bash

read -p "Enter array elements: " -a arr 


# ${#parameter} returns the length of parameters
# ${arrName[@]} length of arr
for (( i=0; i < ${#arr[@]}; i++ ))
do
    echo "${arr[i]}"
done
