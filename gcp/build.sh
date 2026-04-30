#!/usr/bin/env bash
set -euo pipefail

PROJECT="case-study-4-494720"
REGION="us-central1"
REPO="songbird"
IMAGE="$REGION-docker.pkg.dev/$PROJECT/$REPO/songbird:latest"
SERVICE_NAME="songbird"
PORT="7860"


gcloud artifacts repositories create $REPO \
  --repository-format=docker \
  --location=$REGION \
  --quiet 2>/dev/null || true


gcloud builds submit --tag $IMAGE .


gcloud run deploy $SERVICE_NAME \
  --image $IMAGE \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated \
  --port $PORT \
  --set-secrets HF_TOKEN=hf-token:latest


SERVICE_URL=$(gcloud run services describe $SERVICE_NAME \
  --platform managed \
  --region $REGION \
  --format="value(status.url)")

echo "Deployment complete!"
echo "Service name:  $SERVICE_NAME"
echo "Region:        $REGION"
echo "Public URL:    $SERVICE_URL"