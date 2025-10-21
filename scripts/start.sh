#!/bin/bash

# Fukoji Docker Start Script
echo "🚀 Khởi động môi trường Docker cho Fukoji..."

# Change to project root directory
cd "$(dirname "$0")/../.."
PROJECT_ROOT=$(pwd)
DOCKER_DIR="Server/docker"

# Load domain configuration
source Server/scripts/get-domain.sh

# Load environment variables if .env exists
if [ -f "${DOCKER_DIR}/.env" ]; then
    set -a  # automatically export all variables
    source "${DOCKER_DIR}/.env"
    set +a  # stop auto-export
fi

# Kiểm tra Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker chưa được cài đặt!"
    exit 1
fi

if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose chưa được cài đặt!"
    exit 1
fi

# Dừng các container cũ nếu có
echo "🛑 Dừng các container cũ..."
docker-compose -f "${DOCKER_DIR}/docker-compose.yml" --env-file "${DOCKER_DIR}/.env" down 2>/dev/null || docker compose -f "${DOCKER_DIR}/docker-compose.yml" --env-file "${DOCKER_DIR}/.env" down 2>/dev/null || true

# Khởi động containers (không rebuild, không xóa volumes)
echo "🚀 Khởi động containers..."
if command -v docker-compose &> /dev/null; then
    docker-compose -f "${DOCKER_DIR}/docker-compose.yml" --env-file "${DOCKER_DIR}/.env" up -d
else
    docker compose -f "${DOCKER_DIR}/docker-compose.yml" --env-file "${DOCKER_DIR}/.env" up -d
fi

# Đợi MySQL khởi động
echo "⏳ Đợi MySQL khởi động..."
sleep 20

# Kiểm tra trạng thái
echo "📊 Kiểm tra trạng thái containers..."
if command -v docker-compose &> /dev/null; then
    docker-compose -f "${DOCKER_DIR}/docker-compose.yml" --env-file "${DOCKER_DIR}/.env" ps
else
    docker compose -f "${DOCKER_DIR}/docker-compose.yml" --env-file "${DOCKER_DIR}/.env" ps
fi

echo ""
echo "✅ Môi trường Docker đã sẵn sàng!"
echo ""
echo "🌐 Truy cập ứng dụng tại:"
echo "   - Website: http://$DOMAIN"
echo "   - phpMyAdmin: http://localhost:${PMA_PORT:-8081}"
echo ""
echo "🗄️ Thông tin database:"
echo "   - Host: mysql (trong container) hoặc localhost:${DB_PORT:-3306} (từ máy host)"
echo "   - Database: ${DB_NAME}"
echo "   - Username: ${DB_USER}"
echo "   - Password: ${DB_PASS}"
echo "   - Root Password: ${MYSQL_ROOT_PASSWORD:-root123}"
echo ""
echo "🔧 Các lệnh hữu ích:"
echo "   - Xem status: ./Server/scripts/container-helper.sh status"
echo "   - Xem logs: ./Server/scripts/container-helper.sh logs web"
echo "   - Dừng: ./Server/scripts/stop.sh"
echo "   - Restart: ./Server/scripts/restart.sh"
echo "   - Vào container web: ./Server/scripts/container-helper.sh exec web bash"
echo "   - Vào MySQL: ./Server/scripts/container-helper.sh exec mysql mysql -u ${DB_USER} -p ${DB_NAME}"
echo ""
echo "💡 Lưu ý: Script này SỬ DỤNG database có sẵn, không import lại"
echo "    Nếu cần setup lại từ đầu, chạy: ./Server/scripts/setup.sh"
