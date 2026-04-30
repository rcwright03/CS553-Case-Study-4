#!/usr/bin/env bash
set -euo pipefail

PROJECT="case-study-4-494720"
REGION="us-central1"
REPO="songbird"
IMAGE="$REGION-docker.pkg.dev/$PROJECT/$REPO/songbird:latest"
SERVICE_NAME="songbird"
PORT="7860"

# First time only: create Artifact Registry repo (skips if already exists)
gcloud artifacts repositories create $REPO \
  --repository-format=docker \
  --location=$REGION \
  --quiet 2>/dev/null || true

# Build in GCP Cloud Build (no local Docker needed!)
gcloud builds submit --tag $IMAGE .

# Deploy to Google Cloud Run
gcloud run deploy $SERVICE_NAME \
  --image $IMAGE \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated \
  --port $PORT \
  --set-env-vars HF_TOKEN=$HF_TOKEN

# Get the deployed service URL
SERVICE_URL=$(gcloud run services describe $SERVICE_NAME \
  --platform managed \
  --region $REGION \
  --format="value(status.url)")

echo "Deployment complete!"
echo "Service name:  $SERVICE_NAME"
echo "Region:        $REGION"
echo "Public URL:    $SERVICE_URL"