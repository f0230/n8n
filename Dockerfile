# syntax=docker/dockerfile:1
ARG N8N_VERSION=1.106.3
# Esta digest/tag es Alpine en tu build, así que tratémosla como Alpine
FROM n8nio/n8n:${N8N_VERSION}

USER root

# 🔧 Herramientas de build y headers para compilar sqlite3 (node-gyp)
# - python3, make, g++: toolchain
# - pkgconfig: ayuda a detectar libs
# - sqlite-dev: headers de sqlite para compilar node-sqlite3
RUN apk add --no-cache python3 make g++ pkgconfig sqlite-dev

# (Opcional, útil en Alpine)
# RUN apk add --no-cache libc6-compat

# Verificación de distro (debug; puedes dejarlo o quitarlo)
RUN cat /etc/os-release || true
RUN node -v && npm -v

# 📁 Carpeta de trabajo/persistencia
WORKDIR /data

# Instala el paquete de nodos LangChain en /data (user folder)
RUN [ -f package.json ] || npm init -y
RUN npm i --legacy-peer-deps @n8n/n8n-nodes-langchain@latest

# (Opcional) si luego empaquetas nodos privados:
# RUN mkdir -p /opt/custom
# COPY custom /opt/custom

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 5678
ENTRYPOINT ["tini","--","/docker-entrypoint.sh"]

