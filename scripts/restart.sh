#!/bin/bash

# Fukoji Docker Restart Script
echo "🔄 Restart containers..."

# Change to project root directory
cd "$(dirname "$0")/../.."
PROJECT_ROOT=$(pwd)
DOCKER_DIR="Server/docker"

# Restart containers
if command -v docker-compose &> /dev/null; then
    docker-compose -f "${DOCKER_DIR}/docker-compose.yml" --env-file "${DOCKER_DIR}/.env" restart
else
    docker compose -f "${DOCKER_DIR}/docker-compose.yml" --env-file "${DOCKER_DIR}/.env" restart
fi

echo "✅ Containers đã được restart!"
