# syntax=docker/dockerfile:1
FROM n8nio/n8n:latest

COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/n8n-entrypoint.sh

WORKDIR /data
ENV N8N_USER_FOLDER=/data

EXPOSE 5678
ENTRYPOINT ["tini","--","/usr/local/bin/n8n-entrypoint.sh"]
