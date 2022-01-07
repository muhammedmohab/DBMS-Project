#! /bin/bash
i=1

echo "Enter table name" 
read table_name;

if [[ -f ${table_name}.csv ]] # if file dont exist then continue "${table_name}.csv" 
then
  echo "$table_name already exists"
else 
  
  touch ${table_name}.csv
  echo "Enter the number of columns"
  read number
  
  while [[ number -gt 0 ]]
  do 
    echo "enter the column number $i"
    read column

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
  done
fi