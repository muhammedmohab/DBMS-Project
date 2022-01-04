#! /bin/bash

input=${line[@]}

insidep=$(echo "$input" | cut -d "(" -f2 | cut -d ")" -f1) # id int, name char

insidep="${insidep:1:-1}"; #Removes the first and last letter which are spaces.

echo "$insidep" > ${line[2]}.csv;