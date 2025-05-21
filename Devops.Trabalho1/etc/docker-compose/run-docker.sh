#!/bin/bash

if [[ ! -d certs ]]
then
    mkdir certs
    cd certs/
    if [[ ! -f localhost.pfx ]]
    then
        dotnet dev-certs https -v -ep localhost.pfx -p 186744b5-efac-4578-8b34-fb823c44ae8a -t
    fi
    cd ../
fi

docker-compose up -d
