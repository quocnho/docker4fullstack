#!/bin/bash
# Multi-Project Conflict Resolution Script
# Author: Auto-generated for Fukoji project

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Change to script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/../.."

# Load domain configuration
source Server/scripts/get-domain.sh

# Functions
print_header() {
    echo -e "${BLUE}${BOLD}"
    echo "=================================================================="
    echo "🔍 FUKOJI - MULTI-PROJECT CONFLICT ANALYSIS"
    echo "=================================================================="
    echo -e "${NC}"
}

print_section() {
    echo -e "\n${BLUE}${BOLD}=== $1 ===${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Check current project configuration
check_project_config() {
    print_section "Current Project Configuration"

    echo -e "Project Root: ${BOLD}$PROJECT_ROOT${NC}"
    echo -e "Project Name: ${BOLD}$PROJECT_NAME${NC}"
    echo -e "Domain: ${BOLD}$DOMAIN${NC}"
    echo -e "Docker Dir: ${BOLD}Server/docker${NC}"

    if [ -f "Server/docker/.env" ]; then
        print_success ".env file exists"
        echo ""
        echo "Environment Variables:"
        grep -E "^(WEB_PORT|DB_PORT|PMA_PORT|PROJECT_NAME)" "Server/docker/.env" 2>/dev/null | while read line; do
            echo -e "  ${BLUE}$line${NC}"
        done
    else
        print_warning ".env file not found"
    fi
}

# Check Docker containers
check_docker_containers() {
    print_section "Docker Container Analysis"

    # Check if Docker is running
    if ! docker info >/dev/null 2>&1; then
        print_error "Docker is not running or not accessible"
        return 1
    fi

    print_success "Docker is running"

    # Show all containers related to potential Fukoji projects
    echo -e "\nAll containers containing 'fukoji' or project-related patterns:"
    docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "(fukoji|_web|_mysql|_phpmyadmin)" || echo "No related containers found"

    # Check our specific containers
    echo -e "\nCurrent project containers:"
    ./Server/scripts/container-helper.sh status
}

# Check port conflicts
check_port_conflicts() {
    print_section "Port Conflict Analysis"

    ./Server/scripts/check-port-conflicts.sh check
}

# Check network conflicts
check_network_conflicts() {
    print_section "Network Conflict Analysis"

    echo "Docker networks containing project patterns:"
    docker network ls | grep -E "(fukoji|_network)" || echo "No project networks found"

    # Check for subnet conflicts
    echo -e "\nNetwork subnet analysis:"
    docker network ls --format "table {{.Name}}\t{{.Driver}}" | grep bridge | while read name driver; do
        if [[ "$name" =~ fukoji|_network ]]; then
            subnet=$(docker network inspect "$name" --format '{{range .IPAM.Config}}{{.Subnet}}{{end}}' 2>/dev/null)
            if [ -n "$subnet" ]; then
                echo -e "  ${BLUE}$name${NC}: $subnet"
            fi
        fi
    done
}

# Check volume conflicts
check_volume_conflicts() {
    print_section "Volume Conflict Analysis"

    echo "Docker volumes containing project patterns:"
    docker volume ls | grep -E "(fukoji|mysql_data)" || echo "No project volumes found"

    echo -e "\nVolume details:"
    docker volume ls --format "table {{.Name}}\t{{.Driver}}" | grep -E "(fukoji|mysql)" | while read name driver; do
        size=$(docker system df -v | grep "$name" | awk '{print $3}' || echo "unknown")
        echo -e "  ${BLUE}$name${NC}: $driver ($size)"
    done
}

# Analyze potential conflicts with other projects
analyze_conflicts() {
    print_section "Multi-Project Conflict Analysis"

    # Check for multiple project directories
    parent_dir=$(dirname "$PROJECT_ROOT")
    echo -e "Scanning parent directory: ${BOLD}$parent_dir${NC}"

    find "$parent_dir" -maxdepth 2 -name "docker-compose.yml" -path "*/Server/docker/*" 2>/dev/null | while read compose_file; do
        project_path=$(dirname $(dirname $(dirname "$compose_file")))
        project_name=$(basename "$project_path")

        if [ "$project_path" != "$PROJECT_ROOT" ]; then
            echo -e "  Found potential Fukoji project: ${YELLOW}$project_name${NC} at $project_path"

            # Check if it has similar configuration
            if [ -f "$project_path/Server/docker/.env" ]; then
                other_web_port=$(grep "^WEB_PORT=" "$project_path/Server/docker/.env" 2>/dev/null | cut -d'=' -f2)
                other_db_port=$(grep "^DB_PORT=" "$project_path/Server/docker/.env" 2>/dev/null | cut -d'=' -f2)

                if [ -n "$other_web_port" ] || [ -n "$other_db_port" ]; then
                    echo -e "    Ports: WEB=${other_web_port:-default} DB=${other_db_port:-default}"
                fi
            fi
        fi
    done
}

# Generate conflict resolution report
generate_report() {
    print_section "Conflict Resolution Recommendations"

    # Check current configuration
    web_port=${WEB_PORT:-8080}
    db_port=${DB_PORT:-3306}
    pma_port=${PMA_PORT:-8081}

    echo -e "Current Configuration:"
    echo -e "  WEB_PORT: ${BOLD}$web_port${NC}"
    echo -e "  DB_PORT: ${BOLD}$db_port${NC}"
    echo -e "  PMA_PORT: ${BOLD}$pma_port${NC}"
    echo -e "  PROJECT_NAME: ${BOLD}$PROJECT_NAME${NC}"

    echo -e "\n${GREEN}Recommendations:${NC}"

    # Port recommendations
    if lsof -Pi :$web_port -sTCP:LISTEN -t >/dev/null 2>&1; then
        new_web_port=$((web_port + 10))
        echo -e "  • Change WEB_PORT to ${BOLD}$new_web_port${NC} (current $web_port is occupied)"
    else
        print_success "WEB_PORT $web_port is available"
    fi

    if lsof -Pi :$db_port -sTCP:LISTEN -t >/dev/null 2>&1; then
        new_db_port=$((db_port + 1))
        echo -e "  • Change DB_PORT to ${BOLD}$new_db_port${NC} (current $db_port is occupied)"
    else
        print_success "DB_PORT $db_port is available"
    fi

    if lsof -Pi :$pma_port -sTCP:LISTEN -t >/dev/null 2>&1; then
        new_pma_port=$((pma_port + 1))
        echo -e "  • Change PMA_PORT to ${BOLD}$new_pma_port${NC} (current $pma_port is occupied)"
    else
        print_success "PMA_PORT $pma_port is available"
    fi

    # Container name recommendations
    echo -e "\n${GREEN}Dynamic Naming Status:${NC}"
    if grep -q "\${PROJECT_NAME" "Server/docker/docker-compose.yml" 2>/dev/null; then
        print_success "Container names use dynamic PROJECT_NAME variables"
    else
        print_warning "Container names may be hardcoded"
    fi

    if grep -q "\${PROJECT_NAME" "Server/docker/docker-compose.setup.yml" 2>/dev/null; then
        print_success "Setup containers use dynamic PROJECT_NAME variables"
    else
        print_warning "Setup container names may be hardcoded"
    fi
}

# Main execution
main() {
    print_header

    check_project_config
    check_docker_containers
    check_port_conflicts
    check_network_conflicts
    check_volume_conflicts
    analyze_conflicts
    generate_report

    echo -e "\n${BLUE}${BOLD}=== Available Commands ===${NC}"
    echo -e "Fix port conflicts:     ${YELLOW}./Server/scripts/check-port-conflicts.sh auto-fix${NC}"
    echo -e "Container management:   ${YELLOW}./Server/scripts/container-helper.sh status${NC}"
    echo -e "View dynamic names:     ${YELLOW}./Server/scripts/container-helper.sh names${NC}"
    echo -e "Clean this project:     ${YELLOW}./Server/scripts/container-helper.sh cleanup${NC}"

    echo -e "\n${GREEN}✅ Multi-project analysis completed!${NC}"
}

# Run main function
main "$@"
