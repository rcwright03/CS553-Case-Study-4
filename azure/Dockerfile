FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir gradio huggingface_hub

WORKDIR /app

COPY frontend_azure.py /app/
COPY backend_azure.py /app/

EXPOSE 7860

CMD ["python", "frontend_azure.py"]