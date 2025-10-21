#!/bin/bash

# Docker for FullStack - Stop Script
echo "🛑 Stopping Docker for FullStack environment..."

# Change to script directory (now in project root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
DOCKER_ROOT=$(pwd)

# Load domain configuration
source scripts/get-domain.sh

# Stop containers (preserve volumes and data)
if command -v docker-compose &> /dev/null; then
    docker-compose -f "containers/docker-compose.yml" --env-file ".denv" down
else
    docker compose -f "containers/docker-compose.yml" --env-file ".denv" down
fi

echo "✅ All containers have been stopped!"
echo ""
echo "📊 Container status:"
./scripts/container-helper.sh status
echo ""
echo "💡 Note: Database and volumes are preserved"
echo "    To start again: ./start.sh"
echo "    To setup completely: ./setup.sh"
