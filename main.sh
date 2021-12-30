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
                            break
                            ;;
        "List databases")
                            echo "Listing databases ..."
                            . ./scripts/listdb.sh
                            break
                            ;;
        "Connect to database")
                            echo "Connecting to database ..."
                            . ./scripts/connectdb.sh
                            break
                            ;;
        "Drop database")
                            echo "Dropping database ..."
                            . ./scripts/dropdb.sh
                            break
                            ;;
        "Exit")
                            echo "Exiting ..."
                            exit ;;
        *)
                            echo -e "${ERRORTYPE}Wrong Entery, Try again!${NE}"
                            break
                            ;;

        esac
    done
done