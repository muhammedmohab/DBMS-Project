#! /bin/bash

echo "Enter table name: "
read table_name;

if [[ -f ${table_name}.csv ]]
then
    echo "Table ${table_name} already exist";
else
    touch ${table_name}.csv
    #######################
fi