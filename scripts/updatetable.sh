#! /bin/bash

echo "Enter table name"
read table_name;

if [[ -f ${table_name}.csv ]]
then
    echo "Enter column name you want to change"
    read col_name;
    i=0 #iteration in loop
    colxfound="";
    firstline=`cat ${table_name}.csv | head -1`
    fid=0; #The filed to change
    pkid=0;

    IFS=","; read -ra items <<< "$firstline" #items[0]=field 1 .. etc
    size=${#items[@]}; #size of the table header items
    sizeinloop=$size;

    echo "Enter where condition column name"
    read colx;

    while [[ size -gt 0 ]]
    do
        line=${items[$i]}; #line = id, name , salary every itteration
        IFS=" "; read -ra cols <<< "$line"

        ((i=$i+1))
        
        colxfound=${cols[0]}; # id, name, salary
        ####id = id

        if [[ $colxfound == $colx ]]
        then
            fid=$i;
        fi

        if [[ ${cols[0]} == $col_name ]]
        then
            echo "Enter ${colx} value"
            read colx_value;
            
            NR=`grep -nw $colx_value ${table_name}.csv | cut -d: -f1` #record
            IFS=$'\n' read -rd '' -a update_numbers <<< "$NR"
            
            if [[ $NR == "" ]]
            then
                echo -e "${ERRORTYPE}Not in table or Empty${NE}"
            else
                    echo "Enter the new value of ${col_name}";
                    read new_value;
                    j=0
                    sizeloop=${#update_numbers[@]}
                   
                ###########################################
                for((cc=0;cc<sizeinloop;cc++))
                do
                    line2=${items[$cc]};
                    IFS=" "; read -ra colz <<< "$line2"
                    if [[ ${#colz[@]} -gt 2 ]]
                    then
                        ((pkid=$cc+1)); #primary key field number;
                    fi

                done
                cre=`cat ${table_name}.csv | awk 'NR>1' |cut -d, -f$pkid`
                IFS=$'\n' read -rd '' -a pks <<<"$cre"
                pk_size=${#pks[@]}
                count=0
                kk=0
                while [[ pk_size -gt 0 ]]
                do
                    if [[ ${pks[kk]} == $new_value ]]
                    then 
                        ((count=$count+1)) 
                        #Change in counter if counter=0 then it's not pk if counter=anything then it's dublicate value;
                    fi
                    ((kk=$kk+1))
                    ((pk_size=$pk_size-1))
                done

                #############################################
                    while [[ sizeloop -gt 0 ]]
                    do 
                        if [[ $count == 0 ]]
                        then
                            awk -F "," 'FNR=='${update_numbers[j]}'{$'$i'="'${new_value}'"}1' OFS="," ${table_name}.csv > .${table_name}.csv && mv .${table_name}.csv ${table_name}.csv
                            ((j=$j+1))
                            ((sizeloop=$sizeloop-1))
                        else
                            echo -e "${ERRORTYPE}Value is dublicated in pk${NE}";
                            break;
                        fi
                    done
                    echo "Updated!"
                    
                    #TESTS TO BE DELETED
                    # awk -F "," 'FNR=='${update_numbers[0]}'{$'$i'="'${new_value}'"}1' OFS="," ${table_name}.csv > .${table_name}.csv && mv .${table_name}.csv ${table_name}.csv    
                    # awk -F "," 'FNR=='${update_numbers[0]}'{$'$i'="'${new_value}'"}1' OFS="," ${table_name}.csv > .${table_name}.csv && mv .${table_name}.csv ${table_name}.csv    
                    # awk -F "," 'NR=='${update_numbers[0]}'{sub(/'$old_value'/,'$new_value')}'
                    # awk -F "," 'BEGIN{if(NR=='${update_numbers[0]}'){if($'$i' = '$old_value') print '$new_value'}}' ${table_name}.csv > .${table_name}.csv;
                    # sed -i "${update_numbers[0]}s/\<$old_value\>/$new_value/${i}" ${table_name}.csv 
                    # \<\> TO FIND EXACT MATCH
            fi
        fi
        ((size=$size-1));
    done
else
    echo -e "${ERRORTYPE}Table is not found${NE}"
fi    