#!/bin/bash

# Default version is 'latest' if not provided
version=${1:-latest}

# Get the directory where the script is located
current_folder=$(dirname "$(realpath "$0")")
sln_folder="${current_folder}/../../"

echo -e "\033[32m********* BUILDING DbMigrator *********\033[0m"
db_migrator_folder="${sln_folder}src/Devops.Trabalho1.DbMigrator"
cd "$db_migrator_folder" || exit
dotnet publish -c Release
docker build -f Dockerfile.local -t devops/trabalho1-db-migrator:"$version" .

echo -e "\033[32m********* BUILDING Angular Application *********\033[0m"
angular_app_folder="${sln_folder}angular"
cd "$angular_app_folder" || exit
npx yarn
npm run build:prod
docker build -f Dockerfile.local -t devops/trabalho1-angular:"$version" .

echo -e "\033[32m********* BUILDING Api.Host Application *********\033[0m"
host_folder="${sln_folder}src/Devops.Trabalho1.HttpApi.Host"
cd "$host_folder" || exit
dotnet publish -c Release
docker build -f Dockerfile.local -t devops/trabalho1-api:"$version" .

echo -e "\033[32m********* BUILDING AuthServer Application *********\033[0m"
auth_server_app_folder="${sln_folder}src/Devops.Trabalho1.AuthServer"
cd "$auth_server_app_folder" || exit
dotnet publish -c Release
docker build -f Dockerfile.local -t devops/trabalho1-authserver:"$version" .
