
# Usa la variante Debian (sin "-alpine")
ARG N8N_VERSION=1.106.3

FROM n8nio/n8n:${N8N_VERSION}

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 make g++ \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /data
RUN test -f package.json || npm init -y
RUN npm i --legacy-peer-deps @n8n/n8n-nodes-langchain@latest

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
EXPOSE 5678
ENTRYPOINT ["tini","--","/docker-entrypoint.sh"]

