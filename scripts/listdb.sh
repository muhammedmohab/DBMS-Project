#! /bin/bash

if [[ -d ./database ]]
then
    ls ./database    
else
    echo -e "${ERRORTYPE}There is no databases to list${NE}"
fi