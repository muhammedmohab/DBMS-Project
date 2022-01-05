#! /bin/bash

# where=$(cat ${line[2]}.csv | grep -n ${line[6]} | cut -d: -f1);
# if [[ $where != 1 ]]
# then
#     sed -i "${where}d" ${line[2]}.csv
# else
#     echo -e "${ERRORTYPE}Error in deleting${NE}"
# fi

if [ ${#line[@]} -eq 3 ]
then
echo `cat ${linel[2]}.csv | head -1` > ${line[2]}.csv
fi

if [[ ${#line[@]} -gt 3 ]]
then 
size=${#line[@]}
numbers=`grep -inw ${line[6]} ${line[2]}.csv | cut -d: -f1`
IFS=$'\n' read -rd '' -a delete_numbers <<<"$numbers"
size=${#delete_numbers[@]}
((j=$size-1))
while [ $size -gt 0 ]
do 

sed -i "${delete_numbers[j]}d" ${line[2]}.csv
((size=$size-1))
((j=$j-1))
done
fi