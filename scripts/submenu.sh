#! /bin/bash


while [ true ]
do  
    select subselection in "Create table" "List tables" "Drop table" "Insert into table" "Select from table" "Delete from table" "Update table" "Use SQL" "Back"
    do
        sleep 1;clear;
        case $subselection in 
        "Create table")
                            echo "Creating table ..."
                            . ../../scripts/createtable.sh
                            break
                            ;;
        "List tables")
                            echo "Listing tables ..."
                            . ../../scripts/listtable.sh
                            break
                            ;;
        "Drop table")
                            echo "Dropping table ..."
                            . ../../scripts/droptable.sh
                            break
                            ;;
        "Insert into table")
                            echo "Inserting into table ..."
                            . ../../scripts/inserttable.sh
                            break
                            ;;
        "Select from table")
                            echo "Selecting from table ..."
                            . ../../scripts/selecttable.sh
                            break
                            ;;
        "Delete from table")
                            echo "Deleting from table ..."
                            . ../../scripts/deletetable.sh
                            break
                            ;;
        "Update table")
                            echo "Updating table ..."
                            . ../../scripts/updatetable.sh
                            break
                            ;;
        "Use SQL")
                            echo "Using SQL"
                            . ../../scripts/sqldb.sh
                            break
                            ;;
        "Back")
                            echo "Backing ... "
                            cd ../..
                            break 2
                            ;;
        *)
                            echo -e "${ERRORTYPE}Wrong Entery${NE}"
                            ;;

        esac
    done
done