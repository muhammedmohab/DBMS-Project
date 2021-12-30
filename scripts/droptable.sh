#! /bin/bash

echo "Enter table name"
read table_name

if [[ -f ${table_name}.csv ]]
then
	echo "Table deleted"
    rm ${table_name}.csv;
else
	echo "${ERRORTYPE}Table is not found${NE}";