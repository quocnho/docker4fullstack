#!/bin/bash

# Fukoji Docker Logs Script
echo "📋 Xem logs của containers..."

# Change to project root directory
cd "$(dirname "$0")/../.."
PROJECT_ROOT=$(pwd)
DOCKER_DIR="Server/docker"

# Show logs
if command -v docker-compose &> /dev/null; then
    docker-compose -f "${DOCKER_DIR}/docker-compose.yml" --env-file "${DOCKER_DIR}/.env" logs -f
else
    docker compose -f "${DOCKER_DIR}/docker-compose.yml" --env-file "${DOCKER_DIR}/.env" logs -f
fi
