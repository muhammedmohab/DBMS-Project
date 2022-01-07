# #! /bin/bash

echo "Enter table name"
read table_name;
i=0;
counter=0;
fid=0;
condfid=0;

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
            #print everything you have
            echo "$table_name ==============================="
            cat ${table_name}.csv | awk -F "," '{for(i=1;i<=NF;i++){if(NR==1){printf $i;printf"  "}else{printf $i;printf "\t   "}};print "\n"}'
            break;
        elif [[ $selection == "all" && $yesorno == "y" ]]
        then
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
                recs=$(cat ${table_name}.csv | awk -F "," '{print $'$fid'}' | grep -nw "$value" | cut -d: -f1)
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
            fi #closing the all select with condition     
        fi #closing the all select with no condtion

        if [[ $selection != "all" && $yesorno == "n" ]]
        then
            #echo "not all with no condtion"
                for((k=0;k<$innersize;k++)) #Getting fields number
                do
                    #echo "$k this is K"
                    line2=${items[$k]};
                    IFS=" "; read -ra colz <<< "$line2"
                    #echo ""
                    #echo "Inside the for loop $k"
                    #echo "${wordrec[$k]}, ${items[$k]} ,${colz[0]}, $col"
                    #echo "${colz[0]}"
                    if [[ ${colz[0]} == $selection ]]
                    then
                        ((fid=$k+1))
                        #echo "inside the where condition if"
                        break;
                    fi
                done
            
            #Handling the selection field with no condition
            if [[ $fid == 0 ]]
            then
                echo -e "${ERRORTYPE}This ${selection} not found in table${NE}"
                break;
            fi
            #printing the selected field with no condition
            echo "$table_name ==============================="
            cat ${table_name}.csv | awk -F "," '{print $'${fid}'}';

            break;
        elif [[ $selection != "all" && $yesorno == "y" ]] 
        then
            echo "Enter your condition column"
            read col;
            echo "Enter $col value"
            read value;

            
            #condition--------------------------------
            
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
                    ((condfid=$k+1))
                    #echo "$k, $condfid"
                    #echo "inside the where condition if"
                    break;
                fi
            done
            
            #Handling the where condition
            if [[ $condfid == 0 ]]
            then
                echo -e "${ERRORTYPE}This ${selection} not found in table${NE}"
                break;
            fi

            #selction--------------------------------
            for((k=0;k<$innersize;k++)) #Getting fields number
            do
                #echo "$k this is K"
                line2=${items[$k]};
                IFS=" "; read -ra colz <<< "$line2"
                #echo ""
                #echo "Inside the for loop $k"
                #echo "${wordrec[$k]}, ${items[$k]} ,${colz[0]}, $col"
                #echo "${colz[0]}"
                if [[ ${colz[0]} == $selection ]]
                then
                    ((fid=$k+1))
                    #echo "$k, $fid"
                    #echo "inside the where condition if"
                    break;
                fi
            done
            
            #Handling the selection field with condition
            if [[ $fid == 0 ]]
            then
                echo -e "${ERRORTYPE}This ${selection} not found in table${NE}"
                break;
            fi

            echo "$table_name ==============================="

            #Return record number #Searching by cols
            recs=$(cat ${table_name}.csv | awk -F "," '{print $'$condfid'}' | grep -nw "$value" | cut -d: -f1)
            #echo "$recs";
            IFS=$'\n' read -rd '' -a printed <<<"$recs"
            sizeofrecs=${#printed[@]};

            counter=0;

            echo -e "${CYAN}$selection${NE}"
            while [[ sizeofrecs -gt 0 ]]
            do
                #echo "$fid , $condfid"
                
                cat ${table_name}.csv | awk -F "," '{if(NR=='${printed[counter]}'){print $'${fid}'}}'
                ((counter=$counter+1))
                ((sizeofrecs=$sizeofrecs-1))
            done


            break;
        fi #closing of selection of not all
        
        ((size=$size-1)) #while loop condition
    done #closing of while loop

else
    echo -e "${ERRORTYPE}Table not found${NE}";
fi