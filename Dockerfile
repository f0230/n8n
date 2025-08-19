# Usa una versión moderna de Node (cambia si necesitás otra)
FROM node:20-alpine

ARG N8N_VERSION

# Validación del ARG
RUN if [ -z "$N8N_VERSION" ] ; then echo "The N8N_VERSION argument is missing!"; exit 1; fi

# Dependencias del sistema
RUN apk add --no-cache \
    python3 \
    build-base \
    graphicsmagick \
    tzdata \
    git \
    tini \
    su-exec \
    fontconfig \
    msttcorefonts-installer

# Instala fuentes (algunas integraciones lo necesitan para PDFs/HTML)
RUN update-ms-fonts && fc-cache -f

# Instala n8n + ICU completo (soporte i18n)
RUN npm config set python "$(which python3)" && \
    npm_config_user=root npm install -g full-icu n8n@${N8N_VERSION}

ENV NODE_ICU_DATA=/usr/local/lib/node_modules/full-icu

# Copiamos tus nodos privados (ya compilados) al contenedor
# Esto NO es el user folder; los moveremos en el entrypoint si no existen en /data
COPY custom /opt/custom

# Directorio de trabajo (usaremos /data como carpeta persistente)
WORKDIR /data

# Copiamos entrypoint y lo marcamos ejecutable
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# n8n por defecto escucha en 5678, pero en Railway debemos respetar $PORT
# No hace falta EXPOSE en Railway, pero no molesta:
EXPOSE 5678

# Usamos tini como init
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
