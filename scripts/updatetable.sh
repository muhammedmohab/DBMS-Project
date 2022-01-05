#! /bin/bash

echo "Enter table name"
read table_name;

if [[ -f ${table_name}.csv ]]
then
    echo "Enter column name"
    read col_name;
    i=0
    firstline=`cat ${table_name}.csv | head -1`

    IFS=","; read -ra items <<< "$firstline" #items[0]=field 1 .. etc
    size=${#items[@]};

    while [[ size -gt 0 ]]
    do
        line=${items[$i]};
        IFS=" "; read -ra cols <<< "$line"
        ((i=$i+1))
        ####id = id
        if [[ ${cols[0]} == $col_name ]]
        then
            echo "Enter the old value of ${col_name}"
            read old_value;
            
            NR=`grep -nw $old_value ${table_name}.csv | cut -d: -f1`
            IFS=$'\n' read -rd '' -a update_numbers <<< "$NR"
            if [[ $NR == "" ]]
            then
                echo -e "${ERRORTYPE}Not in table${NE}"
            else
                echo "Enter the new value of ${col_name}";
                read new_value;        
                sed -i "${update_numbers[0]}s/\<$old_value\>/$new_value/" ${table_name}.csv 
                echo "Updated!"
                #\<\> TO FIND EXACT MATCH
            fi
        fi
        ((size=$size-1));
    done
else
    echo -e "${ERRORTYPE}Table is not found${NE}"
fi    