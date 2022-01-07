# #! /bin/bash

echo "Enter table name"
read table_name;
i=0;
counter=0;
fid=0;

if [[ -f ${table_name}.csv ]]
then
    echo "What do you want to select (* = all)"
    read selection;
    echo "Do you have condition? [y/n]"
    read yesorno;

    firstline=`cat ${table_name}.csv | head -1`
    IFS=","; read -ra items <<< "$firstline"

    # echo "$items" | awk '{print $1}' #id name salary
    # IFS=" "; read -ra wordrec <<< "$word"
    size=${#items[@]};
    innersize=$size;
    #echo "$innersize"


    while [[ $size -gt 0 ]]
    do
        line=${items[$i]}; #line = id, name , salary every itteration
        IFS=" "; read -ra cols <<< "$line" 
        nocols=${#cols[@]};
        ((i=$i+1))
        if [[ $selection == "all" && $yesorno == "n" ]]
        then
            echo "$table_name ==============================="
            cat ${table_name}.csv | awk -F "," '{for(i=1;i<=NF;i++){if(NR==1){printf $i;printf"  "}else{printf $i;printf "\t   "}};print "\n"}'
            break;
        else
                echo "Enter your condition column"
                read col;
                echo "Enter $col value"
                read value;

                for((k=0;k<$innersize;k++)) #Getting fields number
                do
                    #echo "$k this is K"
                    line2=${items[$k]};
                    IFS=" "; read -ra colz <<< "$line2"
                    #echo ""
                    #echo "Inside the for loop $k"
                    #echo "${wordrec[$k]}, ${items[$k]} ,${colz[0]}, $col"
                    #echo "${colz[0]}"
                    if [[ ${colz[0]} == $col ]]
                    then
                        ((fid=$k+1))
                        #echo "inside the where condition if"
                        break;
                    fi
                done
            
            #Handling the where condition
            if [[ $fid == 0 ]]
            then
                echo -e "${ERRORTYPE}Where condition is incorrect${NE}"
                break;
            fi

            if [[ $selection == "all" && $yesorno == "y" ]]
            then
                echo "$table_name ==============================="
                echo -e "${CYAN}$firstline${NE}";
                #Return record number #Searching by cols
                recs=$(cat ${table_name}.csv | awk -F "," '{print $'$fid'}' | grep -n "$value" | cut -d: -f1)
                #echo "$recs";
                IFS=$'\n' read -rd '' -a printed <<<"$recs"
                sizeofrecs=${#printed[@]};

                while [[ sizeofrecs -gt 0 ]]
                do
                    cat ${table_name}.csv | awk '{if(NR=='${printed[counter]}'){print $0}}' | tr "," "\t"
                    ((counter=$counter+1))
                    ((sizeofrecs=$sizeofrecs-1))
                done

                #cat ${table_name}.csv | awk -vv=$value -F "," '{for(i=1;i<NF;i++){if(NR==1){}else{if($i==v){print $i}}}}'
                break;
            elif [[ $selection == cols[0] ]] #if col you want to select is in the table
            then
                echo "$table_name ==============================="
                
                
                break;
            
            elif [[ $selection == "" ]]
            then
                echo -e "${ERRORTYPE}You need to enter something${NE}";
                break;
            else
                echo -e "${ERRORTYPE}Incorrect${NE}";
                break;
            fi
        fi
        ((size=$size-1))
    done
else
    echo -e "${ERRORTYPE}Table not found${NE}";
fi