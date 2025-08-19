#!/bin/sh
set -e

# Carpeta de datos
export N8N_USER_FOLDER="${N8N_USER_FOLDER:-/data}"
mkdir -p "$N8N_USER_FOLDER"

# 👉 Railway asigna un puerto en $PORT; n8n debe escuchar ahí
export N8N_PORT="${PORT:-5678}"

# 👉 Protocol HTTPS detrás de Railway
export N8N_PROTOCOL="${N8N_PROTOCOL:-https}"

# 👉 Si no configuraste HOST/URLs a mano, intenta deducirlas del dominio de Railway
#    (Railway expone RAILWAY_STATIC_URL o RAILWAY_PUBLIC_DOMAIN tipo n8n-xxxx.up.railway.app)
HOST_CANDIDATE="${RAILWAY_PUBLIC_DOMAIN:-$RAILWAY_STATIC_URL}"
if [ -n "$HOST_CANDIDATE" ]; then
  export N8N_HOST="${N8N_HOST:-$HOST_CANDIDATE}"
  export WEBHOOK_URL="${WEBHOOK_URL:-https://$HOST_CANDIDATE/}"
  export N8N_EDITOR_BASE_URL="${N8N_EDITOR_BASE_URL:-https://$HOST_CANDIDATE/}"
fi

# Zona horaria
export GENERIC_TIMEZONE="${GENERIC_TIMEZONE:-America/Montevideo}"

exec n8n start
