# Puedes fijar versión o usar latest estable
ARG N8N_VERSION=1.64.0
FROM n8nio/n8n:${N8N_VERSION}

USER root

# (Opcional) utilidades que a veces se usan para HTML/PDF
RUN apt-get update && apt-get install -y --no-install-recommends \
    graphicsmagick fontconfig fonts-noto \
 && rm -rf /var/lib/apt/lists/*

# Si vas a incluir nodos privados, deja listo el seed
RUN mkdir -p /opt/custom
# COPY custom /opt/custom  # <-- descomenta si tienes /custom en el repo

WORKDIR /data
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 5678
ENTRYPOINT ["tini","--","/docker-entrypoint.sh"]
