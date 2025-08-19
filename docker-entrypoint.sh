#!/bin/sh
set -e
export N8N_USER_FOLDER="${N8N_USER_FOLDER:-/data}"
mkdir -p "$N8N_USER_FOLDER"

# usar el puerto que asigna Railway y autoconfigurar URLs
export N8N_PORT="${PORT:-5678}"
export N8N_PROTOCOL="${N8N_PROTOCOL:-https}"
HOST_CANDIDATE="${RAILWAY_PUBLIC_DOMAIN:-$RAILWAY_STATIC_URL}"
if [ -n "$HOST_CANDIDATE" ]; then
  export N8N_HOST="${N8N_HOST:-$HOST_CANDIDATE}"
  export WEBHOOK_URL="${WEBHOOK_URL:-https://$HOST_CANDIDATE/}"
  export N8N_EDITOR_BASE_URL="${N8N_EDITOR_BASE_URL:-https://$HOST_CANDIDATE/}"
fi

exec n8n start
