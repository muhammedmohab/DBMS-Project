#!/usr/bin/bash
echo "Enter your database name: "
read db_name;

if [ -d ./database/$db_name ]
then 
    echo "$db_name DATABASE exist"
    cd ./database/$db_name
    echo "You are in $db_name DATABASE"
    PS3="DBMS($db_name) -> "
       ./sqldb.sh
else
    mkdir ./database/$db_name
    echo "$db_name Database created";
    exit;
fi
