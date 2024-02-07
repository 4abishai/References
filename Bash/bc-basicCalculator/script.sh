#!/bin/bash

# !/bin/bash

a=22
b=7

echo "$a/$b"

echo "$((a/b))"

echo "scale=3; $a/$b" | bc

var=$(echo "scale=3; $a/$b" | bc)

echo "$var"

echo "$((a / 10)) is an arithmetic"

