#!/bin/bash

# Fukoji Docker Stop Script
echo "🛑 Dừng môi trường Docker cho Fukoji..."

# Change to project root directory
cd "$(dirname "$0")/../.."
PROJECT_ROOT=$(pwd)
DOCKER_DIR="Server/docker"

# Load domain configuration
source Server/scripts/get-domain.sh

# Dừng containers (giữ lại volumes và data)
if command -v docker-compose &> /dev/null; then
    docker-compose -f "${DOCKER_DIR}/docker-compose.yml" --env-file "${DOCKER_DIR}/.env" down
else
    docker compose -f "${DOCKER_DIR}/docker-compose.yml" --env-file "${DOCKER_DIR}/.env" down
fi

echo "✅ Tất cả containers đã được dừng!"
echo ""
echo "📊 Trạng thái containers:"
./Server/scripts/container-helper.sh status
echo ""
echo "💡 Lưu ý: Database và volumes vẫn được giữ lại"
echo "    Để khởi động lại: ./Server/scripts/start.sh"
echo "    Để setup lại hoàn toàn: ./Server/scripts/setup.sh"
