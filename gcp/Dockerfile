FROM python:3.13-slim

WORKDIR /opt/app

# Install system packages (rarely changes, cache early)
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*

# Install Python deps (changes less often than code)
RUN pip install --no-cache-dir \
    torch --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir \
    fastapi \
    "uvicorn[standard]" \
    transformers \
    accelerate \
    huggingface_hub \
    prometheus-client \
    python-dotenv \
    gradio \
    requests

# Environment variables that rarely change
EXPOSE 7860
EXPOSE 8000
ENV GRADIO_SERVER_NAME="0.0.0.0"
# Backend is in the same container, so frontend talks to localhost
ENV BACKEND_URL="http://localhost:8000"

# Copy source code last (changes most often)
COPY frontend.py .
COPY backend.py .

# Start backend (uvicorn) in background, then launch frontend (gradio)
# Cloud Run injects $PORT — Gradio binds to it; backend stays on 8000 internally
CMD bash -c "uvicorn backend:song_app --host 0.0.0.0 --port 8000 & python frontend.py"
