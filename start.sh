#!/bin/bash

# SCRIPT DE INICIALIZAÇÃO PARA O AMBIENTE DE DESENVOLVIMENTO DO TRABALHO 1
#
# Este script automatiza os seguintes passos:
# 1. Verifica se as dependências (minikube, kubectl, helm) estão instaladas.
# 2. Inicia o Minikube com o perfil 'trabalho1' e monta o diretório de certificados.
# 3. Habilita os addons essenciais (ingress, storage-provisioner).
# 4. Carrega as imagens Docker da aplicação para dentro do Minikube.
# 5. Secrets são criados via kubectl.
# 6. Adiciona a entrada 'k8s.local' ao arquivo /etc/hosts (solicitará sudo).
# 7. Desinstala qualquer release anterior e instala o chart Helm do projeto.

# Configurações
set -e # Encerra o script imediatamente se um comando falhar

# Nome do perfil do Minikube (para isolar este ambiente)
MINIKUBE_PROFILE="trabalho1"

# Nome do release do Helm
RELEASE_NAME="meu-app"

# Caminho para o diretório do chart Helm
CHART_DIR="Devops.Trabalho1/etc/helm-devops-t2"

# Caminho para o diretório de certificados
CERTS_MOUNT_STRING="$(pwd)/Devops.Trabalho1/etc/docker-compose/certs:/certs"

# Lista de imagens Docker a serem carregadas no Minikube
IMAGES_TO_LOAD=(
  "lucasjjgg/trabalho1-angular:latest"
  "lucasjjgg/trabalho1-api:latest"
  "lucasjjgg/trabalho1-authserver:latest"
  "lucasjjgg/trabalho1-db-migrator:latest"
)

# Funções Auxiliares

# Função para imprimir mensagens coloridas
print_info() {
  echo -e "\n\033[1;34m--- $1 ---\033[0m"
}

print_success() {
  echo -e "\033[1;32m✅ $1\033[0m"
}

print_warning() {
  echo -e "\033[1;33m⚠️  $1\033[0m"
}

# Lógica Principal

# 1. Verificar Dependências
print_info "Verificando dependências (minikube, kubectl, helm)..."
for cmd in minikube kubectl helm; do
  if ! command -v $cmd &> /dev/null; then
    echo "Erro: O comando '$cmd' não foi encontrado. Por favor, instale-o e tente novamente."
    exit 1
  fi
done
print_success "Todas as dependências foram encontradas."

# 2. Iniciar e Configurar o Minikube
print_info "Iniciando o Minikube com o perfil '$MINIKUBE_PROFILE'..."
if ! minikube status -p "$MINIKUBE_PROFILE" &> /dev/null; then
  echo "Minikube não está rodando. Iniciando com as configurações do projeto..."
  minikube start --profile "$MINIKUBE_PROFILE" \
                 --memory=4096 \
                 --cpus=2 \
                 --driver=docker \
                 --mount \
                 --mount-string="$CERTS_MOUNT_STRING"
else
  print_success "Minikube já está rodando com o perfil '$MINIKUBE_PROFILE'."
fi

print_info "Habilitando addons do Minikube..."
minikube addons enable ingress -p "$MINIKUBE_PROFILE"
minikube addons enable storage-provisioner -p "$MINIKUBE_PROFILE"
minikube addons enable default-storageclass -p "$MINIKUBE_PROFILE"
print_success "Addons habilitados."

# 3. Carregar Imagens Docker
print_info "Carregando imagens Docker para o ambiente Minikube..."
for image in "${IMAGES_TO_LOAD[@]}"; do
  echo ">> Carregando: $image"
  minikube image load "$image" -p "$MINIKUBE_PROFILE"
done
print_success "Imagens carregadas."

kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: ${RELEASE_NAME}-trabalho1-secrets
type: Opaque
data:
  postgres-password: bXlQYXNzdzByZA==
  certificate-password: MTIzNA==
  localhost-pfx: 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
EOF

# --- Secret TLS para o Ingress ---
# O nome foi ajustado para 'meu-app-trabalho1-certs-secrets' para corresponder ao que o Helm espera.
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: ${RELEASE_NAME}-trabalho1-certs-secrets
type: kubernetes.io/tls
data:
  tls.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMrRENDQWVDZ0F3SUJBZ0lVSVdoeVJWdWNSU1QrRjVxdHk0NTNZQ0wzOFlRd0RRWUpLb1pJaHZjTkFRRUwKQlFBd0ZERVNNQkFHQTFVRUF3d0phemh6TG14dlkyRnNNQjRYRFRJMU1EY3hNREV5TkRVME5Wb1hEVEkyTURjeApNREV5TkRVME5Wb3dGREVTTUJBR0ExVUVBd3dKYXpoekxteHZZMkZzTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGCkFBT0NBUThBTUlJQkNnS0NBUUVBd3VvZDVOb1NRNDc3Unpxb1drVk5SZmUwYmVrYkh4ZStDRVhmVm44N0FkTHgKanl4V3Q2bWNBZjZIb0FHcHhsbTdPYThlZW53bTNyQmR1L3VPVFN0Y0h6RmtONFptbUluVjhmV2NRTWFCN05lUgp3VXZ6bXo0OWM1MVRrTVFiSGVpdUFvc3Y5YzVwTDFHa3ZiMzBvcEIyWStTQml2SE5sMkNsSUZxNVQ0U1JsZWh5CmZRemdWMVY2Y0xmUlprYkNJcjRZWkxlL3lCVGJzdXhHVE1mUm9qWk1DMlQ2YnB4VTBDUWRnN2VVY25PcDZCS1AKRVdrVkZJTU9aamRHMnRiMW9rdjVURGJSTEdrREcxaTdTVGMrdnZDWWtjcnJBYk1aQzViSEpualA3SGpIeVZ3dApRdndpWlZFUndzS1NyN1dKbXB0QzdMUGRzVlJORUhNdjlCOE5IS0UvaHdJREFRQUJvMEl3UURBZkJnTlZIUkVFCkdEQVdnZ2xyT0hNdWJHOWpZV3lDQ1d4dlkyRnNhRzl6ZERBZEJnTlZIUTRFRmdRVVJDSy9uM2ozbjFoK2FzVHkKbG15QUkydXFQT2N3RFFZSktvWklodmNOQVFFTEJRQURnZ0VCQUtEZ05XM0V0Nm1LTm1FZmZJOG9ScFlNbUpGZgptODBUNWd1eGFrNjhsSlZaWG0weVpOcjhjWHFLclRUYW9pMFoxN1hYWWlEYm96QTJSa0hYRWdHempIdlpaa0YrCmNLVDMzVnhVRUdCZWs3MnEzMkVtTWwwbXZzSDV0bHFRSTdMQjdsM01FWlNiZUtpSjRxaW5wTVhsRmRqb2hjaWQKWWlwZFJnQUdCZllzN24vRzRDWmFyOHowV0wzaFhwUDVCaHFzOWdSRUMwOWxuL3pwSHY3UDZiNmdpN2FJN3pQLwpDSHQvMW1KdWd0V2dGNHdLVkFUNmQxMDNhRkh1MDJXcXJnZGt1bTc2amJLbVlTK09GUDY4aDdhUTRhN3ZzVnhPCjNRNkxBRlpCZnNEUldtaU5pU3YrUXZiNUFhQWdOOGhJTVJHZ3k1VEN2Z25McWZmWFdFOW91MHlLcVJJPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
  tls.key: LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2UUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktjd2dnU2pBZ0VBQW9JQkFRREM2aDNrMmhKRGp2dEgKT3FoYVJVMUY5N1J0NlJzZkY3NElSZDlXZnpzQjB2R1BMRmEzcVp3Qi9vZWdBYW5HV2JzNXJ4NTZmQ2Jlc0YyNworNDVOSzF3Zk1XUTNobWFZaWRYeDlaeEF4b0hzMTVIQlMvT2JQajF6blZPUXhCc2Q2SzRDaXkvMXpta3ZVYVM5CnZmU2lrSFpqNUlHSzhjMlhZS1VnV3JsUGhKR1Y2SEo5RE9CWFZYcHd0OUZtUnNJaXZoaGt0Ny9JRk51eTdFWk0KeDlHaU5rd0xaUHB1bkZUUUpCMkR0NVJ5YzZub0VvOFJhUlVVZ3c1bU4wYmExdldpUy9sTU50RXNhUU1iV0x0SgpOejYrOEppUnl1c0JzeGtMbHNjbWVNL3NlTWZKWEMxQy9DSmxVUkhDd3BLdnRZbWFtMExzczkyeFZFMFFjeS8wCkh3MGNvVCtIQWdNQkFBRUNnZjlRRWpLSys3V0ZDMktFQ3hUSXExbzk1QVJselRLQnZoUjlwdUZEZkt1V1B1ZFMKYWJuZ3VVeUlMOTB5Q05JMTFGR1ZpNFhQSU53c1NmSTN4MG91RkNIdXJvWlNTUTdjbXhoemVFZmkvdjYySW9NKwpEOHJZME9OdHhna09STmJlOG95SmZ2bTAxa0ZmcnYvVG5XQU12YUU2YUNUUGI0WXdmd05XeDBPdWtaeVNlQWVrCjN3NTg1UGJ6c0NTUXE2WVVmVjNINENZUHpiZjV1ODBhdmxranphMnBlMkxTRkhReCtrT0FUc25NSU40d0ViTzEKVUt6LzJ6dllDNDNuaGVrbmh5RmhPbFBRVzNEK09oMnE1eDZOUytrUjFIUzdCQXk4N2JScVRrNlZ1dndjRUl4ZApaZ1V1R1FPeHVLTnFvdkhnMXNTTFMzT2pTcTdBNjBPdWN1bG56NzBDZ1lFQS9Ka0theVRJT0R2VXJUWnlnamVIClNzaGJ4UFUwNHV3RVZhRzcxU0Vka0xhZHh3MWErZkhjVW54VzJydFhHUzlFdUNWYmlEN1NsYmM1dDJaMjZMU0YKb1BDU1dBbmJNUXdNV2pYeWFCOUJEeSt3UWcyY1Z3TWpDa2liSWErdlZTckVvaDJpNmxJSHZsVlBYR09TOXB3awpwblZBaUxFUzFyYUNUOGxka3pDU1I4TUNnWUVBeFlvdkFMSjMzeTdWN1p5YlZnZEd3WmUybjdGUlN0eUdUWkFwClQvVXFOci9tVXJHcSswTjN4QzcyaVpZTDcwc0MyWDRRckI2alU2NjNudjZJUW5TZVRHbGdOMDhqVDJHbS9lOGQKbVJFVkRmZ0pKdnNOOWlnbVl5NHJjTllOYjhOa0NrMmtqZVMvdVZ3K0VRcjFlUDR0b201ZmRtN1RqQ1lyUU9MVgpJUVY2OE8wQ2dZRUF3ZVN2ektMRlZmVUhRWlpqdTNUb1V3ME05RmpNcWN0RllIM3ZjcUFpMDZ4NTNBdHlaQjIxClkxT3lUK0F4OFZFSlROalFNL3NWSm5zb3dKRFVnYmZnUXpPbkFoRSt3WjFmOWZjbkJhbklCT0kwUjkrdXZGUGEKRjlDMzA5bkptblJqejVVME11MllxQTlRQmJraFhFOXJDcU5DVUNxc0xVaVhLcXVGT3JDeitJVUNnWUVBZzIrYwpNcVNNNmUwcDNuM3pSVngyRWQyMlg2OEYzZis1Uk9hRTluU3o3OVhqbEdZdTFCeGlGaUVCWFM1L0ptc01yRlliCkZjc1U5VnN0UmhjcDVyM2RqZzRYUFBYbEVxNXhCRWtUc29NUk5VZ3lIc093MkhhQ2hEOTJIQS93eE1xSFIrdTkKYjhRaVpWMGcxd29wcHFYSkMyalJEK1pSejlDZHV3Q3l1dFFBcDBrQ2dZRUEwMVJ4OGNBTnZzSUlNOXI2WFlaOApOMEFjN2FrWlNKWHpnbExtZ3RkNHNxb0dVMmtQdndKUGRtUlV3ZVpjajZmU1Z4eVk2czNnQzAzWnJsajNKM3FLCjBJbzFvSDkzUC9qU1R3VVBndHBZVVE1RHF3WklzVnRZNWhmb3Vzc2VmQ0V4VVY0dUx2NGE5b1hTRzZuQ3VXSjAKbmRZZ1JOV0Zsd1RYWXNvckpRWEhMbmM9Ci0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0K
EOF

print_success "Secrets criados ou já existentes."

# 5. Configurar o arquivo /etc/hosts
print_info "Configurando o arquivo /etc/hosts para o domínio 'k8s.local'..."
MINIKUBE_IP=$(minikube ip -p "$MINIKUBE_PROFILE")
HOSTS_ENTRY="$MINIKUBE_IP k8s.local"

if [ -z "$MINIKUBE_IP" ]; then
    echo "Erro: Não foi possível obter o IP do Minikube."
    exit 1
fi

if grep -q "$HOSTS_ENTRY" /etc/hosts; then
  print_success "A entrada '$HOSTS_ENTRY' já existe em /etc/hosts."
else
  print_warning "A sua senha de administrador (sudo) será solicitada para editar o arquivo /etc/hosts."
  echo "$HOSTS_ENTRY" | sudo tee -a /etc/hosts > /dev/null
  print_success "Entrada '$HOSTS_ENTRY' adicionada com sucesso a /etc/hosts."
fi

# 6. Instalar o Chart Helm
print_info "Verificando a sintaxe do chart Helm..."
helm lint "$CHART_DIR"
print_success "Sintaxe do chart está OK."

print_info "Implantando a aplicação com o Helm..."
# Primeiro, desinstala qualquer release anterior para garantir uma instalação limpa
helm uninstall "$RELEASE_NAME" &> /dev/null || true

# Instala o chart
helm install "$RELEASE_NAME" "$CHART_DIR"

# --- Conclusão ---
print_info "🎉 AMBIENTE DE DESENVOLVIMENTO PRONTO! 🎉"
echo
echo "Sua aplicação foi implantada. Pode levar alguns minutos para todos os pods estarem 'Running'."
echo
print_warning "Lembre-se de aceitar o certificado autoassinado no navegador."
echo -e "Acesse a aplicação em: \033[1;32mhttps://k8s.local\033[0m"
echo
echo "Comandos úteis para verificar o status:"
echo "  kubectl get pods -w"
echo "  kubectl get services"
echo "  kubectl get ingress"
echo "  helm status $RELEASE_NAME"
echo