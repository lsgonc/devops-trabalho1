# Estágio de construção (build)
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copiar arquivos do projeto
COPY . .

# Instala o Nodejs
# Instalar Node.js para o npm
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs

RUN cd src/Devops.Trabalho1.AuthServer/ && npm install 

# Gerar certificados durante o build
RUN dotnet dev-certs https -v -ep openiddict.pfx -p 714df2e0-beab-4d73-ab27-545f96ad72ee
RUN chmod 644 openiddict.pfx

RUN dotnet dev-certs https -v -ep localhost.pfx -p 186744b5-efac-4578-8b34-fb823c44ae8a -t
RUN chmod 644 localhost.pfx

# Publicar a aplicação
RUN dotnet publish "src/Devops.Trabalho1.AuthServer/" -c Release -o /app/publish

# Estágio final (runtime)
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

# Copiar os arquivos publicados
COPY --from=build /app/publish .
# Copiar os certificados
COPY --from=build /src/localhost.pfx ./certs/
COPY --from=build /src/openiddict.pfx .

# Expor as portas
EXPOSE 8080
EXPOSE 8081

# Ponto de entrada
ENTRYPOINT ["dotnet", "Devops.Trabalho1.AuthServer.dll"]
