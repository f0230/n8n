FROM node:20-alpine

# Valor por defecto para no depender de Build Args
ARG N8N_VERSION=1.64.0

# Paquetes necesarios
RUN apk add --no-cache \
  python3 build-base graphicsmagick tzdata git tini su-exec \
  fontconfig msttcorefonts-installer && \
  update-ms-fonts && fc-cache -f

# Instala n8n + ICU
RUN npm config set python "$(which python3)" && \
  npm_config_user=root npm install -g full-icu n8n@${N8N_VERSION}
ENV NODE_ICU_DATA=/usr/local/lib/node_modules/full-icu

# Si aún no tienes nodos privados, no copies nada:
# COPY custom /opt/custom
RUN mkdir -p /opt/custom

WORKDIR /data

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 5678
ENTRYPOINT ["tini","--","/docker-entrypoint.sh"]
