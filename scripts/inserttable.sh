#! /bin/bash

echo "Enter table name" 
read table_name;
if [[ -f "${table_name}.csv" ]] # if file exist then continue 
then

line=`cat ${table_name}.csv | head -1`
IFS=","; read -ra items <<< "$line" #all cols

size=${#items[@]} #columns size
i=0
j=1

while [ $size -gt 0 ]
do 
line2=${items[$i]}
IFS=" "; read -ra each_col <<< "$line2"
##for PK
if [ ${#each_col[@]} -gt 2 ] 
then
############################
####################### temp is used to check where the PK column in table 
if [[ $i -eq 0 ]]
then
temp=`tail -1 ${table_name}.csv | cut -d, -f$j`
else 
temp=`tail -2 ${table_name}.csv | cut -d, -f$j`
fi 

if [[ $temp =~ ^[+-]?[0-9]+$ ]]
then
  : #skip
 else
 temp=0
fi
#####################
###########################
#$temp=`tail -2 ${table_name}.csv | cut -d, -f$j`
while [ true ]
do
echo "Enter value of: ${each_col[0]}"
#echo $j
####################### to check for last id value 
# if [[ $i -eq 0 ]]
# then
# temp2=`tail -1 ${table_name}.csv | cut -d, -f$j`
# else 
# temp2=`tail -2 ${table_name}.csv | cut -d, -f$j`
# fi 

# if [[ $temp2 =~ ^[+-]?[0-9]+$ ]]
# then
# echo  the last PK value is $temp2
# else echo the last PK value is 0
# fi
#####################
read value
if [ ${each_col[1]} == "int" ]
then
if [ -z $value ]
then 
echo -e "${ERRORTYPE}shouldnt be empty int${NE}"
else 
cre=`cat ${table_name}.csv | awk 'NR>1' |cut -d, -f$j`
IFS=$'\n' read -rd '' -a pks <<<"$cre"
pk_size=${#pks[@]}
count=0
kk=0
while [[ $pk_size -gt 0 ]]
do
if [[ ${pks[$kk]} -eq $value ]]
then 
((count=$count+1))
fi
((kk=$kk+1))
((pk_size=$pk_size-1))
done
if [[ $value =~ ^[+-]?[0-9]+$ && $count -eq 0 ]] #check for integer [0-9]
then
##############################
echo -n $value >> ${table_name}.csv
#to save the value int
if [ $size -ne 1 ]
then
echo -n , >> ${table_name}.csv
fi
if [ $size -eq 1 ]
then 
echo "">> ${table_name}.csv
fi 
break
else 
echo -e "${ERRORTYPE}this is not integer or should value  be unique${NE}"
fi
fi 
elif [ ${each_col[1]} == "string" ]
then 
cre=`cat ${table_name}.csv | awk 'NR>1' |cut -d, -f$j`
IFS=$'\n' read -rd '' -a pks <<<"$cre"
pk_size=${#pks[@]}
count=0
kk=0
while [[ $pk_size -gt 0 ]]
do
if [[ ${pks[$kk]} == $value ]]
then 
((count=$count+1))
fi
((kk=$kk+1))
((pk_size=$pk_size-1))
done
if [[ -z $value || $count -ne 0 ]]
then 
echo "shouldnt be empty string or value should be unique"
else
echo -n $value >> ${table_name}.csv
#to save the value

if [ $size -ne 1 ]
then
echo -n , >> ${table_name}.csv
fi
if [ $size -eq 1 ]
then 
echo "">> ${table_name}.csv
fi 

break
fi 
fi
done 

fi


#for not PK
if [ ${#each_col[@]} -eq 2 ] 
then
while [ true ]
do
echo "Enter the value of: ${each_col[0]}"
read value
if [ ${each_col[1]} == "int" ]
then

if [[ $value =~ ^[+-]?[0-9]+$ || $value == "" ]] #check for integer [0-9]
then
echo -n $value >> ${table_name}.csv
#to save the value int
if [ $size -ne 1 ]
then
echo -n , >> ${table_name}.csv
fi
if [ $size -eq 1 ]
then 
echo "">> ${table_name}.csv
fi 
break
else 
echo -e "${ERRORTYPE}$value is not a NUMBER${NE}"
fi

elif [ ${each_col[1]} == "string" ]
then 

echo -n $value >> ${table_name}.csv
#to save the value 
if [ $size -ne 1 ]
then
echo -n , >> ${table_name}.csv
fi
if [ $size -eq 1 ]
then 
echo "">> ${table_name}.csv
fi 

break
fi 

done 

fi

((size=$size-1))
((i=$i+1))
((j=$j+1))

done

   #cd ../.. #Taking the path to the main script path
else
    echo -e "${ERRORTYPE}Table is not found${NE}";
   # cd ../.. #Taking the path to the main script path
fi