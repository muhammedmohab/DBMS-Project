#!/usr/bin/bash
echo enter your database name
read db_name
if [ -d ~/DBMS-Project/database/$db_name ]
then 
echo this DATABASE exist
./~/DBMS-Project/database/main.sh
else
mkdir ~/DBMS-Project/database/$db_name
fi