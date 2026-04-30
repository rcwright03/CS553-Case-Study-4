# 1. Check what repositories exist in the registry
az acr repository list \
  --name songbirdregsitry \
  --output table


# 2. Build a clean AMD64 image locally
DOCKER_BUILDKIT=0 docker build \
  --platform linux/amd64 \
  -t songbird .


# 3. Tag the image for your Azure Container Registry
docker tag songbird songbirdregsitry.azurecr.io/songbird:latest


# 4. Push the AMD64 image to Azure
docker push songbirdregsitry.azurecr.io/songbird:latest


# 5. (Optional) Confirm the tag exists in the registry
az acr repository show-tags \
  --name songbirdregsitry \
  --repository songbird \
  --output table
