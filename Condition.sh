#!/bin/bash

NUMBER=$1

# -gt, -lt, -eq, -ge, -le

if [ $NUMBER -gt 500 ]
then
    echo "Given number is greater than 500"
else
    echo "Given number is less than or equal to 500"
fi