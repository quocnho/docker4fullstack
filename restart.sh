#!/bin/bash

# Docker for FullStack - Restart Script
echo "🔄 Restarting containers..."

# Change to script directory (now in project root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
DOCKER_ROOT=$(pwd)

# Restart containers
if command -v docker-compose &> /dev/null; then
    docker-compose -f "containers/docker-compose.yml" --env-file ".denv" restart
else
    docker compose -f "containers/docker-compose.yml" --env-file ".denv" restart
fi

echo "✅ Containers have been restarted!"
