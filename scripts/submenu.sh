#! /bin/bash


while [ true ]
do  
    select subselection in "Create table" "List tables" "Drop table" "Insert into table" "Select from table" "Delete from table" "Update table" "Use SQL" "Back"
    do
        case $subselection in 
        "Create table")
                            echo "Creating table ..."
                            . ../../scripts/createtable.sh
                            ;;
        "List tables")
                            echo "Listing tables ..."
                            . ../../scripts/listtable.sh
                            ;;
        "Drop table")
                            echo "Dropping table ..."
                            . ../../scripts/droptable.sh
                            ;;
        "Insert into table")
                            echo "Inserting into table ..."
                            . ../../scripts/inserttable.sh
                            ;;
        "Select from table")
                            echo "Selecting from table ..."
                            . ../../scripts/selecttable.sh
                            ;;
        "Delete from table")
                            echo "Deleting from table ..."
                            . ../../scripts/deletetable.sh
                            ;;
        "Update table")
                            echo "Updating table ..."
                            . ../../scripts/updatetable.sh
                            ;;
        "Use SQL")
                            echo "Using SQL"
                            . ../../scripts/sqldb.sh
                            ;;
        "Back")
                            echo "Backing ... "
                            break 2
                            ;;
        *)
                            echo -e "${ERRORTYPE}Wrong Entery${NE}"
                            ;;

        esac
    done
done