# DevOps - T1 e T2

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

<br>

## 🚢 Kubernetes (Minikube) e Helm
Além da criação e execução dos containers, a segunda etapa deste trabalho envolveu a orquestração da aplicação utilizando Kubernetes. Para simular um ambiente de cluster local, foi utilizado o **Minikube**, permitindo testes e validações em um ambiente controlado.

O gerenciamento dos pacotes da aplicação foi realizado com o uso do **Helm**, facilitando a implantação, atualização e versionamento dos recursos no cluster Kubernetes de forma padronizada e eficiente.

<br>

### 1. Pré-requisitos
Antes de começar, garanta que você tenha as seguintes ferramentas instaladas e configuradas em sua máquina:

- **Minikube**: A ferramenta que cria um cluster Kubernetes de um único nó na sua máquina. [Instalação do Minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download)
- **kubectl**: A interface de linha de comando para interagir com o cluster Kubernetes. Geralmente é instalado junto com o Docker Desktop ou pode ser instalado separadamente: [Instalação do kubectl](https://kubernetes.io/docs/tasks/tools/)
- **Helm**: O gerenciador de pacotes para o Kubernetes. [Instalação do Helm](https://helm.sh/docs/intro/install/)

<br>

### 2. Quick start
Para inicializar o ambiente local de desenvolvimento utilizando Minikube e Helm, execute os seguintes comandos no terminal a partir da raiz do projeto:

```
chmod +x start.sh
./start.sh
```
<br>

Este script realiza automaticamente:
- A verificação das dependências necessárias (minikube, kubectl, helm);
- A inicialização do Minikube com o perfil trabalho1;
- A habilitação dos addons essenciais;
- O carregamento das imagens Docker diretamente no Minikube;
- A criação de Secrets utilizados pela aplicação;
- A configuração do domínio k8s.local no arquivo /etc/hosts;
- A implantação da aplicação via Helm, utilizando o chart localizado em Devops.Trabalho1/etc/helm-devops-t2.

<br>

> ℹ️ Observação: É necessário fornecer a senha de administrador (sudo) durante a execução para que o script possa editar o arquivo /etc/hosts.

<br>

Após a execução, a aplicação estará acessível em: https://k8s.local.
