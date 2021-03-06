#! /bin/bash
#cd ./database/$db_name #Just to change my directory to the database that is edited atm
while [ true ]
do

echo "Enter SQL Statment";
read sql;
line=($sql); #Taking a whole SQL steatment and covert it to array

# create table table_name ( id int )
if [[ ${line[0]^^} = "CREATE" && ${line[1]^^} = "TABLE" && ${line[3]:0:1} = "(" && ${line[-1]} = ")" ]]
then
    if [[ -f ${line[2]}.csv ]] 
    then
        echo "The Table ${line[2]} already exists"
    else
        touch ${line[2]}.csv
        . ../../scripts/cutsql.sh
        echo "Table has been created"
    fi

# show tables
elif [[ ${line[0]^^} = "SHOW" && ${line[1]^^} = "TABLES" ]]
then
    echo "Listing tables";
    ls;

# drop table table_name
elif [[ ${line[0]^^} = "DROP" && ${line[1]^^} = "TABLE" ]]
then    
    if [[ -f ${line[2]}.csv ]]
    then 
        rm ${line[2]}.csv
        echo "${line[2]} is removed"
    else
        echo -e "${ERRORTYPE}Table ${line[2]} not found${NE}"
    fi

    # insert into table_name values ( v1,v2,v3 ) 
elif [[ ${line[0]^^} = "INSERT" && ${line[1]^^} = "INTO" && ${line[3]^^} = "VALUES" && ${line[4]} = "(" && ${line[-1]} = ")" ]]
then
    if [[ -f ${line[2]}.csv ]]
    then 
        . ../../scripts/insertsql.sh #calling the insert file which cuts and adds the vales.
        echo "Values have been inserted"
    else
        echo -e "${ERRORTYPE}Table ${line[2]} is not found${NE}"
    fi

    #select * from table (without where conditions)
elif [[ ${line[0]^^} = "SELECT" && ${line[1]} = "all" && ${line[2]^^} = "FROM" && ${line[4]^^} != "WHERE" ]]
then
    if [[ -f ${line[3]}.csv ]]
    then 
        echo "Listing all columns"
        . ../../scripts/selectallsql.sh
    else
        echo -e "${ERRORTYPE}Table ${line[3]} is not found${NE}"
    fi

    #select something_name from table_name where condition = somenumber;
elif [[ ${line[0]^^} = "SELECT" && ${line[2]^^} = "FROM" && ${line[4]^^} = "WHERE" && ${line[6]} = "=" ]]
then
    if [[ -f ${line[3]}.csv ]]
    then 
        #echo "Selecting commands of ${line[1]} from where ${line[5]} = ${line[7]} " #Insert the select commands
        . ../../scripts/selectsql.sh
    else
        echo -e "${ERRORTYPE}Table ${line[3]} is not found${NE}"
    fi

    #delete from table_name;
elif [[ ${line[0]^^} = "DELETE" && ${line[1]^^} = "FROM" && ${line[3]^^} != "WHERE" ]]
then
    if [[ -f ${line[2]}.csv ]]
    then 
        . ../../scripts/deletefromsql.sh
        echo "Delted sucessfully" #Insert delete command
    else
        echo -e "${ERRORTYPE}Table ${line[2]} is not found${NE}"
    fi

    #delete from table_name where condition = something;
elif [[ ${line[0]^^} = "DELETE" && ${line[1]^^} = "FROM" && ${line[3]^^} = "WHERE" && ${line[5]} = "=" ]]
then
    if [[ -f ${line[2]}.csv ]]
    then
        . ../../scripts/deletefromsql.sh
        echo "Deleted sucessfully" #Insert delete command
    else
        echo -e "${ERRORTYPE}Table ${line[2]} is not found${NE}"
    fi

    #update table_name set col = something;
elif [[ ${line[0]^^} = "UPDATE" && ${line[2]^^} = "SET" && ${line[4]} = "=" ]]
then
    if [[ -f ${line[1]}.csv ]]
    then 
        echo "Update statment" #Fill in the update command
    else
        echo -e "${ERRORTYPE}Table ${line[1]} is not found${NE}"
    fi
    #update table_name set col = something where condition = something;
elif [[ ${line[0]^^} = "UPDATE" && ${line[2]^^} = "SET" && ${line[4]} = "=" && ${line[6]^^} = "WHERE" && ${line[8]} = "=" ]]
then
    if [[ -f ${line[1]}.csv ]]
    then 
        echo "Update statment with condition" #fill in the update command by condition
    else
        echo -e "${ERRORTYPE}Table ${line[1]} is not found${NE}"
    fi
elif [[ ${line[0]^^} = "BACK" ]]
then
    break

else
    echo -e "${ERRORTYPE}Wrong SQL Statment${NE}"
fi
done