#!/bin/bash
# QUOCNHO Team - Project Restart Script
# This script restarts Docker containers for this specific project

set -e

# Get project directory and name
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="$(basename "$PROJECT_DIR")"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

echo "=================================================================="
echo "🔄 Restarting project: $PROJECT_NAME"
echo "=================================================================="

# Stop containers
print_info "Stopping containers..."
./stop.sh

# Wait a moment
sleep 2

# Start containers
print_info "Starting containers..."
./start.sh

print_success "Project $PROJECT_NAME restarted successfully!"
