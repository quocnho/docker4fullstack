#!/bin/bash
# QUOCNHO Team - Project Container Helper Script
# This script provides container management utilities for this specific project

# Get project directory and name
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="$(basename "$PROJECT_DIR")"
DOCKER_ROOT="$PROJECT_DIR/../../Docker"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
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

# Load environment variables if .denv exists
if [ -f "$PROJECT_DIR/.denv" ]; then
    set -a
    source "$PROJECT_DIR/.denv"
    # Set Docker Compose project name to ensure proper container naming
    export COMPOSE_PROJECT_NAME="$PROJECT_NAME"
    set +a
else
    print_error ".denv file not found in project directory"
    exit 1
fi

# Function to get container name with project prefix
get_container_name() {
    local service=$1
    echo "${PROJECT_NAME}_${service}"
}

# Function to check if container exists and is running
is_container_running() {
    local container_name=$1
    docker ps --format "table {{.Names}}" | grep -q "^${container_name}$"
}

# Function to check if container exists (running or stopped)
container_exists() {
    local container_name=$1
    docker ps -a --format "table {{.Names}}" | grep -q "^${container_name}$"
}

# Function to execute command in container
exec_in_container() {
    local service=$1
    shift # Remove first argument, keep the rest as command
    local container_name=$(get_container_name "$service")

    if is_container_running "$container_name"; then
        print_info "Executing in container: $container_name"
        docker exec -it "$container_name" "$@"
    else
        print_error "Container $container_name is not running"
        print_info "Start the project first: ./start.sh"
        return 1
    fi
}

# Function to get container logs
get_container_logs() {
    local service=$1
    local lines=${2:-100}
    local container_name=$(get_container_name "$service")

    if container_exists "$container_name"; then
        echo "=== Logs for $container_name (last $lines lines) ==="
        docker logs --tail "$lines" -f "$container_name"
    else
        print_error "Container $container_name does not exist"
        return 1
    fi
}

# Function to display container status
show_container_status() {
    echo -e "${BOLD}=== Container Status for Project: $PROJECT_NAME ===${NC}"
    echo

    # Parse containers from CONTAINERS variable
    if [ -n "$CONTAINERS" ]; then
        IFS=',' read -ra CONTAINER_LIST <<< "$CONTAINERS"

        for service in "${CONTAINER_LIST[@]}"; do
            local container_name=$(get_container_name "$service")

            if is_container_running "$container_name"; then
                echo -e "${GREEN}✓${NC} $service ($container_name): ${GREEN}RUNNING${NC}"

                # Show port mappings
                local ports=$(docker port "$container_name" 2>/dev/null | head -3)
                if [ -n "$ports" ]; then
                    echo "$ports" | while read line; do
                        echo -e "  ${BLUE}└─${NC} $line"
                    done
                fi
            elif container_exists "$container_name"; then
                echo -e "${YELLOW}⚠${NC} $service ($container_name): ${YELLOW}STOPPED${NC}"
            else
                echo -e "${RED}✗${NC} $service ($container_name): ${RED}NOT CREATED${NC}"
            fi
        done
    else
        print_warning "No containers defined in CONTAINERS variable"
    fi

    echo
    echo -e "${BOLD}Network:${NC} ${PROJECT_NAME}_network"

    # Show volumes
    echo -e "${BOLD}Volumes:${NC}"
    docker volume ls | grep "^local.*${PROJECT_NAME}_" | while read driver name; do
        echo -e "  ${BLUE}•${NC} $name"
    done
}

# Function to cleanup project containers
cleanup_project() {
    local force=${1:-false}

    echo -e "${BOLD}=== Cleaning up containers for project: $PROJECT_NAME ===${NC}"

    # Parse containers from CONTAINERS variable
    if [ -n "$CONTAINERS" ]; then
        IFS=',' read -ra CONTAINER_LIST <<< "$CONTAINERS"

        for service in "${CONTAINER_LIST[@]}"; do
            local container_name=$(get_container_name "$service")

            if container_exists "$container_name"; then
                if [ "$force" = "true" ]; then
                    print_info "Force removing container: $container_name"
                    docker rm -f "$container_name" 2>/dev/null || true
                else
                    print_info "Stopping and removing container: $container_name"
                    docker stop "$container_name" 2>/dev/null || true
                    docker rm "$container_name" 2>/dev/null || true
                fi
            fi
        done
    fi

    # Cleanup network
    local network_name="${PROJECT_NAME}_network"
    print_info "Removing network: $network_name"
    docker network rm "$network_name" 2>/dev/null || true

    print_success "Cleanup completed. Volumes preserved for data safety."
    print_info "To remove volumes as well, use: docker volume rm \$(docker volume ls -q | grep ${PROJECT_NAME}_)"
}

# Function to show available services
show_services() {
    echo -e "${BOLD}Available services for $PROJECT_NAME:${NC}"
    if [ -n "$CONTAINERS" ]; then
        IFS=',' read -ra CONTAINER_LIST <<< "$CONTAINERS"
        for service in "${CONTAINER_LIST[@]}"; do
            echo -e "  ${BLUE}•${NC} $service"
        done
    else
        print_warning "No services defined"
    fi
}

# Main command dispatcher
case "${1:-status}" in
    "status")
        show_container_status
        ;;
    "exec")
        if [ $# -lt 3 ]; then
            echo "Usage: $0 exec <service> <command>"
            echo "Example: $0 exec web bash"
            echo "Example: $0 exec mysql mysql -u root -p"
            show_services
            exit 1
        fi
        exec_in_container "$2" "${@:3}"
        ;;
    "logs")
        if [ $# -lt 2 ]; then
            echo "Usage: $0 logs <service> [lines]"
            echo "Example: $0 logs web 50"
            show_services
            exit 1
        fi
        get_container_logs "$2" "$3"
        ;;
    "cleanup")
        cleanup_project "$2"
        ;;
    "services")
        show_services
        ;;
    "restart")
        print_info "Restarting all containers..."
        ./restart.sh
        ;;
    *)
        echo "Usage: $0 [status|exec|logs|cleanup|services|restart]"
        echo ""
        echo "Commands:"
        echo "  status              - Show container status (default)"
        echo "  exec <svc> <cmd>    - Execute command in container"
        echo "  logs <svc> [lines]  - Show container logs"
        echo "  cleanup [force]     - Remove project containers"
        echo "  services            - List available services"
        echo "  restart             - Restart all containers"
        echo ""
        show_services
        exit 1
        ;;
esac
