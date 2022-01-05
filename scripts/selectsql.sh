#! /bin/bash

if [[ ${line[1]} == ${line[5]} ]]
then
    firstline=$(head -1 ${line[3]}.csv);
    #result=$(cat ${line[3]}.csv | grep ${line[7]});
    echo -e "${CYAN}${firstline}${NE}";
    cat ${line[3]}.csv | grep -w ${line[7]}
else
    echo -e "${ERRORTYPE}Error in selection${NE}"
fi
#echo $result;