#! /bin/bash

cat ${line[2]}.csv > .${line[2]}.csv
rm ${line[2]}.csv
cat .${line[2]}.csv | head -1 > ${line[2]}.csv
rm .${line[2]}.csv