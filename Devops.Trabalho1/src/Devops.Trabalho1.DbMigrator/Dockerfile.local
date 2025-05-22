# Estágio de construção
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copiar arquivos do projeto
COPY . .

# Publicar o migrador de banco de dados
RUN dotnet publish "src/Devops.Trabalho1.DbMigrator/" -c Release -o /app/publish

# Estágio final (runtime)
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

# Configurar usuário não-root (opcional para migrador)
ARG APP_UID=1000
RUN if [ "$APP_UID" -ne 0 ]; then \
      useradd -u ${APP_UID} appuser && \
      chown appuser:appuser /app; \
    fi

USER $APP_UID

# Copiar apenas os arquivos necessários
COPY --from=build /app/publish .

# Ponto de entrada
ENTRYPOINT ["dotnet", "Devops.Trabalho1.DbMigrator.dll"]