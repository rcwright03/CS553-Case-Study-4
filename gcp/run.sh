#!/usr/bin/env bash
set -euo pipefail

IMAGE="dashlipsey/songbird:latest"

docker run --rm \
  -p 7860:7860 \
  -p 8000:8000 \
  -e HF_TOKEN=$HF_TOKEN \
  $IMAGE