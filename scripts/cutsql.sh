#! /bin/bash

input=${line[@]}

echo "$input" | cut -d "(" -f2 | cut -d ")" -f1 > ${line[2]}.csv # id int, name char