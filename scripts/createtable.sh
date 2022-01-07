#! /bin/bash
i=1
flag=0;

echo "Enter table name" 
read table_name;

if [[ -f ${table_name}.csv ]] # if file dont exist then continue "${table_name}.csv" 
then
  echo "$table_name already exists"
else 
  
  touch ${table_name}.csv
  echo "Enter the number of columns"
  read number
  
  while [[ $number -gt 0 ]]
  do 
    echo "enter the column number $i"
    read column
    IFS=" "; read -ra colspaced <<< "$column"
    size=${#colspaced[@]};
    #echo "${size}, ${flag}"
    if [[ ${colspaced[1]} == "int" || ${colspaced[1]} == "string" ]]
    then
        if [[ $size -lt 3 || $flag == 0 ]]
        then
            
          echo -n $column >> ${table_name}.csv
          if [[ $number -ne 1 ]]
          then
            echo -n , >> ${table_name}.csv
          fi

          if [[ $number -eq 1 ]]
          then 
            echo "">> ${table_name}.csv
          fi
          ((number=$number-1))
          ((i=$i+1))
        fi
        if [[ $size -eq 3 && $flag == 1 ]]
        then
          echo -e "${ERRORTYPE}Only one PK in table${NE}";
        fi
        if [[ $size == 3 ]]
        then
            flag=1;
            #echo "Flag changed"
        fi
        else
          echo -e "${ERRORTYPE}Wrong data type (int|string)${NE}";
        
      fi
  done
fi