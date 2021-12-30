#! /bin/bash

files=database/*

if [[ ${#files} -gt 0 ]]
then
    ls 
else
    echo -e "${ERRORTYPE}Couldn't fetch tables from $database ${NE}";
fi