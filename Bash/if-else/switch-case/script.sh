#!/bin/bash

read -p "Enter fruit: " fruit

case $fruit in
    "apple")
        echo "fruit: $fruit"
        ;;
    "orange")
        echo "fruit: $fruit" 
        ;;
    "cherry")
        echo "fruit: $fruit"
        ;;
    *)
        echo "INVALID"
        ;;
esac 
