# DevOps - T1

| Nome                    | RA     |
|-------------------------|--------|
|   Enzo Youji Murayama   | 813606 |
| Lucas Sciarra Gonçalves | 811948 |

<br>

## 📜 Resumo da aplicação
A aplicação foi desenvolvida com o ABP Studio, utilizando ASP.NET Core no backend e Angular no frontend, com uma arquitetura modular que facilita manutenção, escalabilidade e conteinerização. Trata-se de uma aplicação corporativa genérica, ideal como base para sistemas empresariais como ERPs ou CRMs. Possui funcionalidades básicas como autenticação, autorização, auditoria e integração com banco de dados. Sua estrutura distribuída permite a execução em múltiplos contêineres, tornando-a adequada para orquestração com Docker Compose.

<br>

## 📦 Containers e Funcionalidades
Abaixo, descrevemos a funcionalidade de cada serviço e seus relacionamentos:

1. **trabalho1-angular (Front-end)**
   - Função: Interface web da aplicação (frontend) desenvolvida com Angular.
   - Importância: É a porta de entrada da aplicação para o usuário final. Consumirá os serviços expostos pela API.
   - Relacionamentos:
     - Depende de trabalho1-api para obter dados e enviar ações via REST.
     - É configurado para ser acessado na porta 4200 do host.
<br>

2. **trabalho1-api (Back-end)**
   - Função: API principal da aplicação (backend), construída com ASP.NET Core.
   - Importância: Expõe os endpoints REST que implementam a lógica de negócio e se comunica com o banco de dados e serviços auxiliares.
   - Relacionamentos:
     - Depende do container postgres (banco de dados relacional).
     - Depende de redis para operações de cache e pub/sub.
     - Requer autenticação via trabalho1-authserver.
     - Atende as requisições do frontend (trabalho1-angular).
<br>

3. **trabalho1-authserver**
   - Função: Servidor de autenticação/autorização baseado em OpenIddict.
   - Importância: Garante segurança à aplicação, gerenciando autenticação de usuários e emissão de tokens JWT.
   - Relacionamentos:
     - Consumido por trabalho1-api para validar tokens e autorizar requisições.
     - Utiliza postgres e redis da mesma forma que a API.
     - Os CORS e URLs de redirecionamento são configurados para permitir chamadas de trabalho1-angular.
<br>

4. **db-migrator**
   - Função: Responsável por aplicar migrações de banco de dados automaticamente.
   - Importância: Garante que o banco esteja com a estrutura (schema) correta e atualizado antes do uso da aplicação.
   - Relacionamentos:
     - Depende de postgres para aplicar as migrações.
     - Configura os URLs das aplicações (trabalho1-angular, trabalho1-api, trabalho1-authserver) para o registro de clientes no servidor de identidade (OpenIddict).
<br>

5. **postgres**
   - Função: Banco de dados relacional PostgreSQL.
   - Importância: Armazena dados persistentes da aplicação, como usuários, produtos, etc.
   - Relacionamentos:
     - Utilizado por trabalho1-api, trabalho1-authserver, e db-migrator.
     - Possui verificação de saúde (healthcheck) para garantir disponibilidade antes de iniciar os serviços dependentes.  
<br>

6. **redis**
   - Função: Servidor Redis para cache e mensagens pub/sub.
   - Importância: Otimiza a performance da aplicação e permite comunicação entre serviços.
   - Relacionamentos:
     - Utilizado por trabalho1-api, trabalho1-authserver e db-migrator para caching, tokens, etc.
     - Também possui healthcheck configurado.
  
