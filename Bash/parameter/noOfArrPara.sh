#!/bin/bash

preDefinedArr=("apple" "banana" "cherry")
echo "No. of elements in the preDefinedArr: ${#preDefinedArr[@]}"  # Output: 3

echo -n "Enter elements: "
read -a readArr
echo "No. of elements in the readArray: ${#readArr[@]}"
