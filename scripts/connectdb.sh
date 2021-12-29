#! /bin/bash

echo "Enter the name of the database to connect to: "
read database;

if [[ -d ./database/$database ]]
then
    cd ./database/$database
    echo $PWD
    echo "You're in ${database}"
    PS3="DBMS($database)-> "
    . ../../scripts/insertcase.sh
    
    #. ../../scripts/sqldb.sh
else
    echo -e "${ERRORTYPE}Database $database doesn't exists${NE}"
fi

