#! /bin/bash
echo enter TABLE name 
read table_name
line=`cat $table_name | head -1`
IFS=","; read -ra items <<< "$line"
n=${#items[@]}
i=0
while [ $n -gt 0 ]
do
echo ${items[$i]}
read value
echo -n $value >> $table_name
if [ $n -ne 1 ]
then
echo -n , >> $table_name
fi
if [ $n -eq 1 ]
then 
echo "">> $table_name
fi 
((n=$n-1))
((i=$i+1))

done


