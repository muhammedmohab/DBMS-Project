#! /bin/bash

cat ${line[3]}.csv | awk -F "," '{for(i=1;i<=NF;i++){printf $i;printf "\t"};print "\n"}'