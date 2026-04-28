FROM python:3.13.5-slim

RUN pip install --no-cache-dir gradio huggingface_hub

WORKDIR /app

COPY src/frontend.py /app/src/
COPY src/backend.py /app/src/

EXPOSE 7860

CMD ["python", "src/frontend.py"]