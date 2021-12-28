#! /bin/bash

ERRORTYPE='\033[0;31m';
NE='\033[0m';
PS3="DBMS-Project > ";
current=$PWD;

if [ -d ./database ]
then 
    echo "Established"
else
    mkdir ./database
fi

while [ true ]
do 
    `cd $current` 
    select selection in "Create database" "List databases" "Connect to database" "Drop database" "Exit"
    do
        case $selection in 
        "Create database")
                            echo "Creating database ..."
                            . ./scripts/createdb.sh
                            ;;
        "List databases")
                            echo "Listing databases ..."
                            . ./scripts/listdb.sh
                            ;;
        "Connect to database")
                            echo "Connecting to database ..."
                            ;;
        "Drop database")
                            echo "Dropping database ..."
                            ;;
        "Exit")
                            echo "Exiting ..."
                            exit ;;
        *)
                            echo -e "${ERRORTYPE}Wrong Entery${NE}"
                            ;;

        esac
    done
done