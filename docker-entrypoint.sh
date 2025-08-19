#!/bin/sh
set -e

# Asegura que /data exista
mkdir -p "${N8N_USER_FOLDER:-/data}"

# Opcional: timezone
export GENERIC_TIMEZONE="${GENERIC_TIMEZONE:-America/Montevideo}"

# ¡Listo! Arranca n8n (la imagen ai-beta ya trae los nodos AI)
exec n8n start
