#! /bin/bash
echo "Enter table name" 
read table_name;

line=`cat ${table_name}.csv | head -1` #Reading the first line which has the cols
IFS=","; read -ra items <<< "$line"

numberOfCols=${#items[@]} #number of cols to loop on
counter=0
while [ $numberOfCols -gt 0 ]
do
    echo "${items[$counter]}"
    read value
    echo -n $value >> ${table_name}.csv
    if [ $numberOfCols -ne 1 ]
    then
        echo -n , >> ${table_name}.csv
    fi
    
    if [ $numberOfCols -eq 1 ]
    then 
        echo "">> ${table_name}.csv
    fi 
    ((numberOfCols=$numberOfCols-1))
    ((counter=$counter+1))
done
    cd ../.. #Taking the path to the main script path