docker network create trabalho1 --label=trabalho1
docker-compose -f docker-compose.infrastructure.yml up -d
exit $LASTEXITCODE