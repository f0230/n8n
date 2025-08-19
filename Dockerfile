# syntax=docker/dockerfile:1
FROM docker.n8n.io/n8nio/n8n:ai-beta

# Copiamos el entrypoint con permisos correctos (sin usar chmod en RUN)
COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/n8n-entrypoint.sh

# Carpeta de trabajo y datos persistentes (monta tu volumen aquí)
WORKDIR /data
ENV N8N_USER_FOLDER=/data

EXPOSE 5678
ENTRYPOINT ["tini","--","/usr/local/bin/n8n-entrypoint.sh"]
