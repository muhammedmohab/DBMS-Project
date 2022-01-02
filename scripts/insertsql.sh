#! /bin/bash

input=${line[@]}

insidep=$(echo "$input" | cut -d "(" -f2 | cut -d ")" -f1| tr -s ' ' ',')

insidep="${insidep:1:-1}"; #Removes the first and last letter which are commas.

echo "$insidep" >> ${line[2]}.csv;