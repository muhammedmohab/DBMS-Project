#! /bin/bash

PS3="DBMS-Project >";
current=$PWD;

if [ -d ./database ]
then 
    echo "Established"
else
    mkdir ./database
fi

while [ true ]
do 
    `cd $current` #Going to current path of the main script
    select selection in "Create database" "List databases" "Connect to database" "Drop database" "Exit"
    do
        case $selection in 
        "Create database")
                            echo "Creating database ..."
                            ./scripts/createdb.sh
                            ;;
        "List databases")
                            echo "Listing databases ..."
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
                            echo "Wrong Entery"
                            ;;

        esac
    done
done