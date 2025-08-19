#!/bin/sh
set -e

# Carpeta de usuario n8n (persistente)
export N8N_USER_FOLDER="${N8N_USER_FOLDER:-/data}"

# Asegura estructura esperada por n8n para nodos privados
mkdir -p "$N8N_USER_FOLDER/custom/nodes" "$N8N_USER_FOLDER/custom/credentials"

# Si el usuario no los montó previamente, copiamos los nodos incluidos en la imagen
if [ -d "/opt/custom/nodes" ] && [ ! -e "$N8N_USER_FOLDER/custom/.seeded" ]; then
  cp -r /opt/custom/nodes "$N8N_USER_FOLDER/custom/"
  cp -r /opt/custom/credentials "$N8N_USER_FOLDER/custom/" 2>/dev/null || true
  touch "$N8N_USER_FOLDER/custom/.seeded"
  echo "Custom nodes seeded into $N8N_USER_FOLDER/custom"
fi

# En Railway debemos usar el puerto que nos asigna la plataforma
export N8N_PORT="${PORT:-5678}"

# Zona horaria útil para Uruguay
export GENERIC_TIMEZONE="${GENERIC_TIMEZONE:-America/Montevideo}"

# Arranca n8n
exec n8n start
