#!/bin/bash
# QUOCNHO Team - Project Start Script
# This script starts Docker containers for this specific project

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
    print_info "Please run setup first: $DOCKER_ROOT/scripts/setup.new.sh"
    exit 1
fi

# Check if Docker root exists
if [ ! -d "$DOCKER_ROOT" ]; then
    print_error "Docker directory not found: $DOCKER_ROOT"
    print_info "Please ensure the Docker directory is located at: $DOCKER_ROOT"
    exit 1
fi

# Load environment variables
print_info "Loading project configuration..."
set -a
source "$PROJECT_DIR/.denv"
# Set Docker Compose project name to ensure proper container naming
export COMPOSE_PROJECT_NAME="$PROJECT_NAME"
set +a

print_info "Starting containers for project: $PROJECT_NAME"
print_info "Project directory: $PROJECT_DIR"
print_info "Docker compose: $DOCKER_ROOT/containers/docker-compose.yml"

# Determine docker-compose command
if command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
else
    COMPOSE_CMD="docker compose"
fi

# Build profiles list from CONTAINERS
if [ -n "$CONTAINERS" ]; then
    export COMPOSE_PROFILES="$CONTAINERS"
    print_info "Starting containers: $CONTAINERS"
else
    print_error "CONTAINERS not defined in .denv file"
    exit 1
fi

# Stop any existing containers first
print_info "Stopping any existing containers..."
cd "$PROJECT_DIR"
$COMPOSE_CMD -f "$DOCKER_ROOT/containers/docker-compose.yml" --env-file "$PROJECT_DIR/.denv" down 2>/dev/null || true

# Check for conflicts before starting
print_info "Checking for port and container conflicts..."
if [ -f "$DOCKER_ROOT/scripts/check-port-conflicts.sh" ]; then
    if ! "$DOCKER_ROOT/scripts/check-port-conflicts.sh"; then
        print_warning "Conflicts detected! Continue anyway? (y/N)"
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            print_info "Startup cancelled by user"
            exit 1
        fi
    fi
fi

# Start containers
print_info "Starting Docker containers..."
$COMPOSE_CMD -f "$DOCKER_ROOT/containers/docker-compose.yml" --env-file "$PROJECT_DIR/.denv" up -d

# Wait for containers to start
sleep 5

# Check container status
print_info "Checking container status..."
$COMPOSE_CMD -f "$DOCKER_ROOT/containers/docker-compose.yml" --env-file "$PROJECT_DIR/.denv" ps

print_success "Containers started successfully!"

# Display access information
echo ""
echo "=================================================================="
echo "🎉 Project $PROJECT_NAME is now running!"
echo "=================================================================="
echo "🌐 Access Information:"
[ -n "$WEB_PORT" ] && echo "   - Web Application: http://localhost:$WEB_PORT"
[ -n "$PMA_PORT" ] && echo "   - phpMyAdmin: http://localhost:$PMA_PORT"
[ -n "$NODE_PORT" ] && echo "   - Node.js Dev: http://localhost:$NODE_PORT"
[ -n "$FLUTTER_PORT" ] && echo "   - Flutter Web: http://localhost:$FLUTTER_PORT"

echo ""
echo "🔧 Management Commands:"
echo "   - Stop: ./stop.sh"
echo "   - Restart: ./restart.sh"
echo "   - Status: ./container-helper.sh status"
echo "   - Logs: ./container-helper.sh logs web"
echo "   - Shell: ./container-helper.sh exec web bash"
echo "=================================================================="
