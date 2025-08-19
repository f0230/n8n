# syntax=docker/dockerfile:1
FROM docker.n8n.io/n8nio/n8n:ai-beta

# (Opcional) si vas a empaquetar nodos privados tuyos:
# RUN mkdir -p /opt/custom
# COPY custom /opt/custom

WORKDIR /data
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 5678
ENTRYPOINT ["tini","--","/docker-entrypoint.sh"]

