#! /bin/bash
echo $PWD
if [[ -n "$(ls)" ]]
then
    ls $database
else
    echo -e "${ERRORTYPE}Couldn't fetch tables from $database ${NE}";
fi