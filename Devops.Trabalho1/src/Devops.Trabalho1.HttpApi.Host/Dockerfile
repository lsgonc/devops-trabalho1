# Estágio de construção (build)
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copiar arquivos do projeto
COPY . .

# Publicar a aplicação
RUN dotnet publish "src/Devops.Trabalho1.HttpApi.Host/" -c Release -o /app/publish

# Gerar certificados HTTPS
RUN mkdir -p /app/publish/certs && \
    # Certificado OpenIDDict (na raiz)
    dotnet dev-certs https -v -ep /app/publish/openiddict.pfx -p 714df2e0-beab-4d73-ab27-545f96ad72ee && \
    # Ajustar permissões
    chmod 644 /app/publish/openiddict.pfx

# Estágio final (runtime)
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

# Configurar usuário não-root (mais seguro)
ARG APP_UID=1000
RUN useradd -u ${APP_UID} appuser && \
    mkdir -p /app/certs && \
    chown appuser:appuser /app /app/certs

USER appuser

# Copiar os arquivos publicados
COPY --from=build --chown=appuser:appuser /app/publish .
# Copiar certificados separadamente para locais diferentes
COPY --from=build --chown=appuser:appuser /app/publish/openiddict.pfx .

# Expor as portas
EXPOSE 8080
EXPOSE 8081

# Ponto de entrada
ENTRYPOINT ["dotnet", "Devops.Trabalho1.HttpApi.Host.dll"]
