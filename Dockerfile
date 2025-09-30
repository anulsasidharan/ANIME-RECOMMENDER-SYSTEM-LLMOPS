# Parent image
FROM python:3.10-slim

# Essential environment variable
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

## Work Directory inside the docker container
WORKDIR /app

## Installing system dependancies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    python3-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install UV package manager (Universal Virtualenv)
RUN pip install --no-cache-dir uv

## Copying all contents from local to app
COPY . .

# Create a virtual environment for UV
RUN uv venv

## Run setup.py
RUN uv pip install --editable .

# Used PORTS
EXPOSE 8501

## RUN the app
CMD ["streamlit", "run", "app/app.py", "--server.port=8501","--server.address=0.0.0.0", "--server.headless=true"]