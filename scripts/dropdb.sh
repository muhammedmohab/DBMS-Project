#! /bin/bash

echo "Enter your database name: "
read db_name;

if [ -d ./database/$db_name ]
then 
    rm -r ./database/$db_name
    echo -e "$db_name DATABASE is deleted..."
    . ./main.sh
else
    echo -e "${ERRORTYPE}$db_name DATABASE didn't exist${NE}"
    . ./main.sh
    
fi
