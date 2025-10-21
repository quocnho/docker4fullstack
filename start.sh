#!/bin/bash

# Docker for FullStack - Start Script
echo "🚀 Starting Docker for FullStack environment..."

# Change to script directory (now in project root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
DOCKER_ROOT=$(pwd)

# Load domain configuration
source scripts/get-domain.sh

# Load environment variables if .denv exists
if [ -f ".denv" ]; then
    set -a  # automatically export all variables
    source ".denv"
    set +a  # stop auto-export
fi

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed!"
    exit 1
fi

if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose is not installed!"
    exit 1
fi

# Stop old containers if any
echo "🛑 Stopping old containers..."
docker-compose -f "containers/docker-compose.yml" --env-file ".denv" down 2>/dev/null || docker compose -f "containers/docker-compose.yml" --env-file ".denv" down 2>/dev/null || true

# Start containers (no rebuild, preserve volumes)
echo "🚀 Starting containers..."
if command -v docker-compose &> /dev/null; then
    docker-compose -f "containers/docker-compose.yml" --env-file ".denv" up -d
else
    docker compose -f "containers/docker-compose.yml" --env-file ".denv" up -d
fi

# Wait for MySQL to start
echo "⏳ Waiting for MySQL to start..."
sleep 20

# Check container status
echo "📊 Checking container status..."
if command -v docker-compose &> /dev/null; then
    docker-compose -f "containers/docker-compose.yml" --env-file ".denv" ps
else
    docker compose -f "containers/docker-compose.yml" --env-file ".denv" ps
fi

echo ""
echo "✅ Docker environment is ready!"
echo ""
echo "🌐 Access your application at:"
echo "   - Website: http://$DOMAIN"
echo "   - phpMyAdmin: http://localhost:${PMA_PORT:-8081}"
echo ""
echo "🗄️ Database information:"
echo "   - Host: mysql (in container) or localhost:${DB_PORT:-3306} (from host)"
echo "   - Database: ${DB_NAME}"
echo "   - Username: ${DB_USER}"
echo "   - Password: ${DB_PASS}"
echo "   - Root Password: ${MYSQL_ROOT_PASSWORD:-root123}"
echo ""
echo "🔧 Useful commands:"
echo "   - View status: ./scripts/container-helper.sh status"
echo "   - View logs: ./scripts/container-helper.sh logs web"
echo "   - Stop: ./stop.sh"
echo "   - Restart: ./restart.sh"
echo "   - Enter web container: ./scripts/container-helper.sh exec web bash"
echo "   - MySQL console: ./scripts/container-helper.sh exec mysql mysql -u ${DB_USER} -p ${DB_NAME}"
echo ""
echo "💡 Note: This script USES existing database, no re-import"
echo "    If you need fresh setup, run: ./setup.sh"
