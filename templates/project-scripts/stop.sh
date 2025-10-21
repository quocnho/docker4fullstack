#!/bin/bash
# QUOCNHO Team - Project Stop Script
# This script stops Docker containers for this specific project

set -e

# Get project directory and name
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="$(basename "$PROJECT_DIR")"
DOCKER_ROOT="$PROJECT_DIR/../../Docker"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if .denv file exists
if [ ! -f "$PROJECT_DIR/.denv" ]; then
    print_error ".denv file not found in project directory"
    exit 1
fi

# Load environment variables
print_info "Loading project configuration..."
set -a
source "$PROJECT_DIR/.denv"
# Set Docker Compose project name to ensure proper container naming
export COMPOSE_PROJECT_NAME="$PROJECT_NAME"
set +a

print_info "Stopping containers for project: $PROJECT_NAME"

# Determine docker-compose command
if command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
else
    COMPOSE_CMD="docker compose"
fi

# Stop containers
cd "$PROJECT_DIR"
$COMPOSE_CMD -f "$DOCKER_ROOT/containers/docker-compose.yml" --env-file "$PROJECT_DIR/.denv" down

print_success "All containers stopped!"

echo ""
echo "=================================================================="
echo "🛑 Project $PROJECT_NAME has been stopped"
echo "=================================================================="
echo "📊 Container Status:"
$COMPOSE_CMD -f "$DOCKER_ROOT/containers/docker-compose.yml" --env-file "$PROJECT_DIR/.denv" ps

echo ""
echo "💡 Note: Volumes and data are preserved"
echo "   - To restart: ./start.sh"
echo "   - To clean up: ./container-helper.sh cleanup"
echo "=================================================================="
