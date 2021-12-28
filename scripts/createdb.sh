#!/usr/bin/bash
PS3="DBMS-Project >";

echo "Enter your database name: "
read db_name;

if [ -d ./database/$db_name ]
then 
    echo "$db_name DATABASE exist"
    exit;
else
    mkdir ./database/$db_name
    echo "$db_name Database created";
    exit;
fi