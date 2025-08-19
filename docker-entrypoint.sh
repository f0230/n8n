#!/bin/sh
set -e
export N8N_USER_FOLDER="${N8N_USER_FOLDER:-/data}"
mkdir -p "$N8N_USER_FOLDER/custom/nodes" "$N8N_USER_FOLDER/custom/credentials"

if [ -d "/opt/custom/nodes" ] && [ ! -e "$N8N_USER_FOLDER/custom/.seeded" ]; then
  cp -r /opt/custom/nodes "$N8N_USER_FOLDER/custom/"
  cp -r /opt/custom/credentials "$N8N_USER_FOLDER/custom/" 2>/dev/null || true
  touch "$N8N_USER_FOLDER/custom/.seeded"
  echo "Custom nodes seeded into $N8N_USER_FOLDER/custom"
fi

export N8N_PORT="${PORT:-5678}"
export GENERIC_TIMEZONE="${GENERIC_TIMEZONE:-America/Montevideo}"
exec n8n start
