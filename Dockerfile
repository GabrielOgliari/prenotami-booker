FROM python:3.11-slim-bookworm

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    TZ=Europe/Rome

RUN apt-get update \
    && apt-get install -y --no-install-recommends chromium chromium-driver tzdata \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY pyproject.toml README.md ./
COPY src ./src
COPY config.example.yaml ./config.example.yaml
COPY .env.example ./.env.example

RUN pip install --no-cache-dir . \
    && cp config.example.yaml config.yaml

# Safe default: keep the container idle until scheduling is explicitly enabled.
CMD ["sleep", "infinity"]
