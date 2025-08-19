# Usa la imagen oficial (Debian)
ARG N8N_VERSION=1.64.0
FROM n8nio/n8n:${N8N_VERSION}

USER root

# (Opcional) utilidades/ fuentes si las necesitás
RUN apt-get update && apt-get install -y --no-install-recommends \
    graphicsmagick fontconfig fonts-noto \
 && rm -rf /var/lib/apt/lists/*

# Si vas a “sembrar” nodos privados, deja la carpeta lista
RUN mkdir -p /opt/custom
# COPY custom /opt/custom   # <-- descomenta solo si EXISTE /custom en tu repo

WORKDIR /data
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 5678
ENTRYPOINT ["tini","--","/docker-entrypoint.sh"]
