FROM python:3.12-bullseye AS builder
WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc

RUN python -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"
COPY . .
RUN --mount=type=cache,target=~/.cache/pip pip install -r requirements.txt

FROM python:3.12-slim AS worker
WORKDIR /app

RUN addgroup --system python && \
    adduser --system --disabled-password --ingroup python python && chown python:python /app

USER python

COPY --chown=python:python --from=builder /app/venv ./venv
COPY --chown=python:python main.py .
ENV PATH="/app/venv/bin:$PATH"

# Запускаем приложение с помощью uvicorn, делая его доступным по сети
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"] 
