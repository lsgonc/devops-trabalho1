# Estágio de construção (build)
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copiar arquivos do projeto
COPY . .

# Instala o ABP CLI globalmente
RUN dotnet tool install -g Volo.Abp.Studio.Cli

# Configura o PATH permanentemente para incluir as ferramentas do dotnet
ENV PATH="$PATH:/root/.dotnet/tools"

#Instala o nodejs, yarn e o Abp Cli
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Configura o nvm, instala o Node.js 22 e habilita o yarn
RUN . /root/.nvm/nvm.sh && nvm install 22 && corepack enable yarn && cd src/Devops.Trabalho1.AuthServer/ && abp install-libs --verbose


# Gerar certificados durante o build
RUN dotnet dev-certs https -v -ep openiddict.pfx -p 714df2e0-beab-4d73-ab27-545f96ad72ee
RUN chmod 644 openiddict.pfx

# Publicar a aplicação
RUN dotnet publish "src/Devops.Trabalho1.AuthServer/" -c Release -o /app/publish

# Estágio final (runtime)
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

# Copiar os arquivos publicados
COPY --from=build /app/publish .
# Copiar os certificados
COPY --from=build /src/openiddict.pfx .

# Expor as portas
EXPOSE 8080
EXPOSE 8081

# Ponto de entrada
ENTRYPOINT ["dotnet", "Devops.Trabalho1.AuthServer.dll"]
