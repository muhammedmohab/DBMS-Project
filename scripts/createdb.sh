#!/usr/bin/bash
echo "Enter your database name: "
read db_name;

if [ -d ./database/$db_name ]
then 
    echo -e "${ERRORTYPE}$db_name DATABASE exist${NE}"
    . ./main.sh
else
    mkdir ./database/$db_name
    echo "$db_name Database created";
    cd ./database/$db_name
    echo "Using $db_name"
    . ../../scripts/submenu.sh
    #. ../../scripts/sqldb.sh
fi
