#!/bin/bash
# Helper script for dynamic container management
# Author: Auto-generated for Fukoji project

# Source the get-domain script to get PROJECT_NAME
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/get-domain.sh"

# Function to get container name with project prefix
get_container_name() {
    local service=$1
    echo "${PROJECT_NAME}_${service}"
}

# Function to get network name with project prefix
get_network_name() {
    echo "${PROJECT_NAME}_network"
}

# Function to get volume name with project prefix
get_volume_name() {
    local volume_suffix=$1
    echo "${PROJECT_NAME}_${volume_suffix}"
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
        echo "Executing in container: $container_name"
        docker exec -it "$container_name" "$@"
    else
        echo "Error: Container $container_name is not running"
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
        docker logs --tail "$lines" "$container_name"
    else
        echo "Error: Container $container_name does not exist"
        return 1
    fi
}

# Function to display container status
show_container_status() {
    echo "=== Container Status for Project: $PROJECT_NAME ==="
    echo

    local services=("web" "mysql" "phpmyadmin")

    for service in "${services[@]}"; do
        local container_name=$(get_container_name "$service")

        if is_container_running "$container_name"; then
            echo "✓ $service ($container_name): RUNNING"
        elif container_exists "$container_name"; then
            echo "⚠ $service ($container_name): STOPPED"
        else
            echo "✗ $service ($container_name): NOT CREATED"
        fi
    done

    echo
    echo "Network: $(get_network_name)"
    echo "Volumes: $(get_volume_name "mysql_data"), mysql_logs, web_logs"
}

# Function to cleanup project containers
cleanup_project() {
    local force=${1:-false}

    echo "=== Cleaning up containers for project: $PROJECT_NAME ==="

    local services=("web" "mysql" "phpmyadmin")

    for service in "${services[@]}"; do
        local container_name=$(get_container_name "$service")

        if container_exists "$container_name"; then
            if [ "$force" = "true" ]; then
                echo "Force removing container: $container_name"
                docker rm -f "$container_name" 2>/dev/null || true
            else
                echo "Stopping and removing container: $container_name"
                docker stop "$container_name" 2>/dev/null || true
                docker rm "$container_name" 2>/dev/null || true
            fi
        fi
    done

    # Cleanup network
    local network_name=$(get_network_name)
    echo "Removing network: $network_name"
    docker network rm "$network_name" 2>/dev/null || true

    # Note: Volumes are not removed to preserve data
    echo "✓ Cleanup completed. Volumes preserved for data safety."
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
            exit 1
        fi
        exec_in_container "$2" "${@:3}"
        ;;
    "logs")
        if [ $# -lt 2 ]; then
            echo "Usage: $0 logs <service> [lines]"
            echo "Example: $0 logs web 50"
            exit 1
        fi
        get_container_logs "$2" "$3"
        ;;
    "cleanup")
        cleanup_project "$2"
        ;;
    "names")
        echo "Project: $PROJECT_NAME"
        echo "Web container: $(get_container_name "web")"
        echo "MySQL container: $(get_container_name "mysql")"
        echo "phpMyAdmin container: $(get_container_name "phpmyadmin")"
        echo "Network: $(get_network_name)"
        echo "MySQL volume: $(get_volume_name "mysql_data")"
        ;;
    *)
        echo "Usage: $0 [status|exec|logs|cleanup|names]"
        echo ""
        echo "Commands:"
        echo "  status          - Show container status (default)"
        echo "  exec <svc> <cmd> - Execute command in container"
        echo "  logs <svc> [lines] - Show container logs"
        echo "  cleanup [force] - Remove project containers"
        echo "  names          - Show dynamic names being used"
        echo ""
        echo "Services: web, mysql, phpmyadmin"
        exit 1
        ;;
esac
