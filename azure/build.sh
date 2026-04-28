az login
az acr login --name songbirdregsitry
DOCKER_BUILDKIT=0 docker build -t songbird .
docker tag songbird songbirdregsitry.azurecr.io/songbird:latest
docker push songbirdregsitry.azurecr.io/songbird:latest