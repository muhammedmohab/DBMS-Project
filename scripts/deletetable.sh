#! /bin/bash


echo enter DELETE SQL statement
read line 

j=0
IFS=" "; read -ra sql <<< "$line"

if [ ${#sql[@]} -eq 3 ]
then
    echo `cat ${sql[2]}.csv | head -1` > ${sql[2]}.csv
fi

###########################
# test case 
#delete from table_name where id = 2
#delete from table_name where name = mohamed
if [[ ${#sql[@]} -gt 3 ]]
then 
    size=${#sql[@]}
    numbers=`grep -inw ${sql[6]} ${sql[2]}.csv | cut -d: -f1`
    IFS=$'\n' read -rd '' -a delete_numbers <<<"$numbers"
    size=${#delete_numbers[@]}
    ((j=$size-1))
    while [ $size -gt 0 ]
    do 
        #echo ${delete_numbers[j]}
        sed -i "${delete_numbers[j]}d" ${sql[2]}.csv
        ((size=$size-1))
        ((j=$j-1))
done
fi