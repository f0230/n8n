# syntax=docker/dockerfile:1
ARG N8N_VERSION=1.64.0
# Fuerza rebuild para evitar cache de una base Alpine
ARG CACHE_BUST=2025-08-19-01

FROM n8nio/n8n:${N8N_VERSION}

USER root

# (Opcional) Semillero para nodos privados
RUN mkdir -p /opt/custom
# COPY custom /opt/custom  # <-- descomentar solo si EXISTE en el repo

WORKDIR /data
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 5678
ENTRYPOINT ["tini","--","/docker-entrypoint.sh"]
