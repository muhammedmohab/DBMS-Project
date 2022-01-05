#! /bin/bash

where=$(cat ${line[2]}.csv | grep -n ${line[6]} | cut -d: -f1);
if [[ $where != 1 ]]
then
    sed -i "${where}d" ${line[2]}.csv
else
    echo -e "${ERRORTYPE}Error in deleting${NE}"
fi