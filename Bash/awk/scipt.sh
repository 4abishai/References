#!/bin/bash

output="Wed Feb 11:45:59 AM"  

echo "$output" | awk '{print $2}'

echo "$output" | awk -F'[ :]' '{print $4}'

fieldSep=$(echo "$output" | awk -F'[ :]' '{print $4}')

echo "$fieldSep"