#!/bin/bash
# Docker for FullStack - Port & Container Conflict Checker
# This script checks for port conflicts and container/network naming conflicts

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

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

# Function to check if a port is in use
check_port() {
    local port=$1
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
        return 0  # Port is in use
    else
        return 1  # Port is available
    fi
}

# Function to find next available port
find_available_port() {
    local start_port=$1
    local current_port=$start_port

    while check_port $current_port; do
        ((current_port++))
    done

    echo $current_port
}

# Function to display port status
display_port_status() {
    local port=$1
    local service=$2

    if check_port $port; then
        echo -e "${RED}✗${NC} Port $port ($service) is ${RED}OCCUPIED${NC}"
        local available_port=$(find_available_port $port)
        echo -e "  ${YELLOW}→${NC} Suggested alternative: ${GREEN}$available_port${NC}"
        return 1
    else
        echo -e "${GREEN}✓${NC} Port $port ($service) is ${GREEN}AVAILABLE${NC}"
        return 0
    fi
}

# Main function
main() {
    echo -e "${BLUE}=== Port Conflict Detection for Fukoji Project ===${NC}\n"

    # Read current environment or use defaults
    WEB_PORT=${WEB_PORT:-8080}
    DB_PORT=${DB_PORT:-3306}
    PMA_PORT=${PMA_PORT:-8081}

    echo -e "${BLUE}Checking current port configuration:${NC}"
    echo -e "WEB_PORT: $WEB_PORT"
    echo -e "DB_PORT: $DB_PORT"
    echo -e "PMA_PORT: $PMA_PORT\n"

    local conflicts=0

    # Check each port
    if ! display_port_status $WEB_PORT "Web Server"; then
        ((conflicts++))
    fi

    if ! display_port_status $DB_PORT "MySQL Database"; then
        ((conflicts++))
    fi

    if ! display_port_status $PMA_PORT "phpMyAdmin"; then
        ((conflicts++))
    fi

    echo

    if [ $conflicts -eq 0 ]; then
        echo -e "${GREEN}✓ No port conflicts detected! All ports are available.${NC}"
        return 0
    else
        echo -e "${RED}✗ Found $conflicts port conflict(s).${NC}"
        echo -e "${YELLOW}Please update your .env file with the suggested ports or stop the conflicting services.${NC}"
        return 1
    fi
}

# Auto-update .env function
auto_update_env() {
    local env_file=".env"
    local updated=0

    echo -e "\n${BLUE}=== Auto-updating .env file with available ports ===${NC}"

    # Check if .env exists
    if [ ! -f "$env_file" ]; then
        echo -e "${YELLOW}Warning: .env file not found. Creating from .env.example...${NC}"
        if [ -f ".env.example" ]; then
            cp ".env.example" "$env_file"
        else
            echo -e "${RED}Error: Neither .env nor .env.example found!${NC}"
            return 1
        fi
    fi

    # Update WEB_PORT if conflict
    if check_port ${WEB_PORT:-8080}; then
        new_port=$(find_available_port ${WEB_PORT:-8080})
        sed -i "s/^WEB_PORT=.*/WEB_PORT=$new_port/" "$env_file"
        echo -e "Updated WEB_PORT to $new_port"
        ((updated++))
    fi

    # Update DB_PORT if conflict
    if check_port ${DB_PORT:-3306}; then
        new_port=$(find_available_port ${DB_PORT:-3306})
        sed -i "s/^DB_PORT=.*/DB_PORT=$new_port/" "$env_file"
        echo -e "Updated DB_PORT to $new_port"
        ((updated++))
    fi

    # Update PMA_PORT if conflict
    if check_port ${PMA_PORT:-8081}; then
        new_port=$(find_available_port ${PMA_PORT:-8081})
        sed -i "s/^PMA_PORT=.*/PMA_PORT=$new_port/" "$env_file"
        echo -e "Updated PMA_PORT to $new_port"
        ((updated++))
    fi

    if [ $updated -gt 0 ]; then
        echo -e "${GREEN}✓ Updated $updated port(s) in .env file${NC}"
    else
        echo -e "${GREEN}✓ No port updates needed${NC}"
    fi
}

# Handle command line arguments
case "${1:-check}" in
    "check")
        main
        ;;
    "auto-fix")
        main
        if [ $? -ne 0 ]; then
            auto_update_env
        fi
        ;;
    "fix")
        auto_update_env
        ;;
    *)
        echo "Usage: $0 [check|auto-fix|fix]"
        echo "  check    - Check for port conflicts (default)"
        echo "  auto-fix - Check and automatically fix conflicts in .env"
        echo "  fix      - Force update .env with available ports"
        exit 1
        ;;
esac
