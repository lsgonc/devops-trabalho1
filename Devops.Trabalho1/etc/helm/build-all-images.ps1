./build-image.ps1 -ProjectPath "../../src/Devops.Trabalho1.DbMigrator/Devops.Trabalho1.DbMigrator.csproj" -ImageName trabalho1/dbmigrator
./build-image.ps1 -ProjectPath "../../src/Devops.Trabalho1.HttpApi.Host/Devops.Trabalho1.HttpApi.Host.csproj" -ImageName trabalho1/httpapihost
./build-image.ps1 -ProjectPath "../../angular" -ImageName trabalho1/angular -ProjectType "angular"
./build-image.ps1 -ProjectPath "../../src/Devops.Trabalho1.AuthServer/Devops.Trabalho1.AuthServer.csproj" -ImageName trabalho1/authserver
