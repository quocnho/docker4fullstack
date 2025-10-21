#!/bin/bash

# Docker for FullStack - Interactive Docker Environment Setup
# This script provides project selection and technology stack configuration

set -e

# Change to script directory and navigate to project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/../.."
DOCKER_ROOT=$(pwd)
PROJECTS_DIR="../Projects"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}${BOLD}"
    echo "=================================================================="
    echo "🚀 DOCKER FOR FULLSTACK - ENVIRONMENT SETUP"
    echo "=================================================================="
    echo -e "${NC}"
}

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

# Check and setup Docker prerequisites
check_docker_prerequisites() {
    print_info "Checking Docker prerequisites..."

    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed!"
        print_info "Running requirements check to install Docker..."
        if [ -f "$DOCKER_ROOT/scripts/check-requirements.sh" ]; then
            "$DOCKER_ROOT/scripts/check-requirements.sh"
        else
            print_error "Requirements checker not found. Please install Docker manually."
            exit 1
        fi
    else
        print_success "Docker is installed"
    fi

    # Check if Docker daemon is running
    if ! docker info &> /dev/null; then
        print_error "Docker daemon is not running!"
        print_info "Starting Docker service..."
        sudo systemctl start docker 2>/dev/null || true

        # Wait a moment and check again
        sleep 2
        if ! docker info &> /dev/null; then
            print_error "Cannot start Docker daemon. Please check your installation."
            exit 1
        fi
    else
        print_success "Docker daemon is running"
    fi

    # Check if user is in docker group
    if ! groups $USER | grep -q docker; then
        print_warning "User $USER is not in docker group"
        print_info "Adding user to docker group..."

        # Create docker group if it doesn't exist
        if ! getent group docker > /dev/null 2>&1; then
            sudo groupadd docker
        fi

        # Add user to docker group
        sudo usermod -aG docker $USER
        print_success "User $USER added to docker group"
        print_warning "Please log out and log back in, or run: newgrp docker"

        # Set proper permissions for Docker socket
        sudo chmod 666 /var/run/docker.sock 2>/dev/null || true
    else
        print_success "User $USER is in docker group"
    fi

    # Check Docker Compose
    if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
        print_error "Docker Compose is not installed!"
        print_info "Installing Docker Compose..."

        # Download and install Docker Compose
        COMPOSE_VERSION="v2.23.0"
        sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose

        if command -v docker-compose &> /dev/null; then
            print_success "Docker Compose installed successfully"
        else
            print_error "Failed to install Docker Compose"
            exit 1
        fi
    else
        print_success "Docker Compose is available"
    fi

    echo ""
}

print_step() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if Projects directory exists
check_projects_directory() {
    if [ ! -d "$PROJECTS_DIR" ]; then
        print_warning "Projects directory not found. Creating $PROJECTS_DIR"
        mkdir -p "$PROJECTS_DIR"
        print_step "Projects directory created"
    fi
}

# List existing projects
list_projects() {
    echo -e "\n${BOLD}Available Projects:${NC}"
    echo -e "${YELLOW}0.${NC} Create new project"

    local count=1
    local projects=()

    if [ -d "$PROJECTS_DIR" ]; then
        for dir in "$PROJECTS_DIR"*/; do
            if [ -d "$dir" ]; then
                local project_name=$(basename "$dir")
                local tech_info=""
                local denv_file="$dir.denv"

                # Read technology info from .denv if exists
                if [ -f "$denv_file" ]; then
                    local tech_stack=$(grep "^TECH_STACK=" "$denv_file" 2>/dev/null | cut -d'=' -f2 | tr -d '"')
                    local php_version=$(grep "^PHP_VERSION=" "$denv_file" 2>/dev/null | cut -d'=' -f2 | tr -d '"')
                    local containers=$(grep "^CONTAINERS=" "$denv_file" 2>/dev/null | cut -d'=' -f2 | tr -d '"')

                    if [ -n "$tech_stack" ]; then
                        tech_info=" (${tech_stack}"
                        [ -n "$php_version" ] && tech_info="${tech_info}, PHP ${php_version}"
                        tech_info="${tech_info})"
                    fi
                fi

                echo -e "${YELLOW}${count}.${NC} ${project_name}${tech_info}"
                projects[$count]=$project_name
                ((count++))
            fi
        done
    fi

    if [ $count -eq 1 ]; then
        echo -e "${YELLOW}   No existing projects found${NC}"
    fi

    echo ""
    read -p "Select project [0-$((count-1))]: " project_choice

    if [ "$project_choice" = "0" ]; then
        create_new_project
    elif [ "$project_choice" -ge 1 ] && [ "$project_choice" -lt $count ]; then
        SELECTED_PROJECT=${projects[$project_choice]}
        SELECTED_PROJECT_PATH="$PROJECTS_DIR/$SELECTED_PROJECT"
        setup_existing_project
    else
        print_error "Invalid selection. Please try again."
        exit 1
    fi
}

# Create new project
create_new_project() {
    echo -e "\n${BOLD}=== Create New Project ===${NC}"

    read -p "Enter project name: " project_name

    # Validate project name
    if [ -z "$project_name" ]; then
        print_error "Project name cannot be empty"
        exit 1
    fi

    # Convert to lowercase and replace spaces with hyphens
    project_name=$(echo "$project_name" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')

    SELECTED_PROJECT=$project_name
    SELECTED_PROJECT_PATH="$PROJECTS_DIR/$project_name"

    # Create project directory
    if [ -d "$SELECTED_PROJECT_PATH" ]; then
        print_error "Project directory already exists: $SELECTED_PROJECT_PATH"
        exit 1
    fi

    mkdir -p "$SELECTED_PROJECT_PATH"
    print_step "Created project directory: $SELECTED_PROJECT_PATH"

    # Setup new project configuration
    setup_project_configuration
}

# Setup existing project
setup_existing_project() {
    local denv_file="$SELECTED_PROJECT_PATH/.denv"

    echo -e "\n${BOLD}=== Setup Existing Project: $SELECTED_PROJECT ===${NC}"

    if [ -f "$denv_file" ]; then
        print_info "Found existing .denv configuration"

        # Display current configuration
        echo -e "\n${BOLD}Current Configuration:${NC}"
        grep -E "^(PROJECT_NAME|CONTAINERS|PHP_VERSION|TECH_STACK|WEB_PORT|DB_PORT)=" "$denv_file" | while read line; do
            key=$(echo "$line" | cut -d'=' -f1)
            value=$(echo "$line" | cut -d'=' -f2 | tr -d '"')
            echo -e "  ${BLUE}$key:${NC} $value"
        done

        echo ""
        read -p "Use existing configuration? (Y/n): " use_existing

        if [[ $use_existing =~ ^[Nn]$ ]]; then
            setup_project_configuration
        else
            # Use existing configuration
            source "$denv_file"

            # Ask about GitHub Actions setup for existing projects
            echo ""
            read -p "Setup GitHub Actions VPS deployment? (Y/n): " setup_github_actions
            if [[ ! $setup_github_actions =~ ^[Nn]$ ]]; then
                copy_github_actions_template
            fi

            start_containers
        fi
    else
        print_warning "No .denv file found. Setting up new configuration."
        setup_project_configuration
    fi
}

# Setup project configuration
setup_project_configuration() {
    echo -e "\n${BOLD}=== Technology Stack Configuration ===${NC}"

    # Select PHP version
    echo -e "\n${BOLD}Select PHP Version:${NC}"
    echo "1. PHP 8.1"
    echo "2. PHP 8.2"
    echo "3. PHP 8.3 (recommended)"
    echo "4. PHP 8.4"

    read -p "Select PHP version [3]: " php_choice
    case $php_choice in
        1) PHP_VERSION="8.1" ;;
        2) PHP_VERSION="8.2" ;;
        4) PHP_VERSION="8.4" ;;
        *) PHP_VERSION="8.3" ;;
    esac

    # Select web server
    echo -e "\n${BOLD}Select Web Server:${NC}"
    echo "1. Apache (recommended)"
    echo "2. Nginx"

    read -p "Select web server [1]: " web_choice
    case $web_choice in
        2) WEB_SERVER="nginx" ;;
        *) WEB_SERVER="apache" ;;
    esac

    # Select containers
    echo -e "\n${BOLD}Select Containers (comma-separated numbers):${NC}"
    echo "1. web (PHP $PHP_VERSION + $WEB_SERVER)"
    echo "2. mysql (MySQL 8.0)"
    echo "3. redis (Redis Cache)"
    echo "4. nodejs (Node.js + npm/yarn)"
    echo "5. flutter (Flutter Development)"
    echo "6. nginx (Reverse Proxy/PWA)"
    echo "7. phpmyadmin (Database Management)"

    read -p "Select containers [1,2,7]: " container_choice
    [ -z "$container_choice" ] && container_choice="1,2,7"

    # Convert container numbers to names
    CONTAINERS=""
    IFS=',' read -ra CONTAINER_NUMS <<< "$container_choice"
    for num in "${CONTAINER_NUMS[@]}"; do
        case $num in
            1) CONTAINERS="${CONTAINERS},web" ;;
            2) CONTAINERS="${CONTAINERS},mysql" ;;
            3) CONTAINERS="${CONTAINERS},redis" ;;
            4) CONTAINERS="${CONTAINERS},nodejs" ;;
            5) CONTAINERS="${CONTAINERS},flutter" ;;
            6) CONTAINERS="${CONTAINERS},nginx" ;;
            7) CONTAINERS="${CONTAINERS},phpmyadmin" ;;
        esac
    done
    CONTAINERS=${CONTAINERS#,}  # Remove leading comma

    # Select technology stack
    echo -e "\n${BOLD}Select Primary Technology:${NC}"
    echo "1. Laravel"
    echo "2. CodeIgniter"
    echo "3. Symfony"
    echo "4. Flutter"
    echo "5. Vue.js/PWA"
    echo "6. Custom PHP"

    read -p "Select technology [1]: " tech_choice
    case $tech_choice in
        2) TECH_STACK="codeigniter" ;;
        3) TECH_STACK="symfony" ;;
        4) TECH_STACK="flutter" ;;
        5) TECH_STACK="vue" ;;
        6) TECH_STACK="php" ;;
        *) TECH_STACK="laravel" ;;
    esac

    # Configure ports
    configure_ports

    # Configure database
    configure_database

    # Generate .denv file
    generate_denv_file

    # Copy project templates and scripts
    copy_project_files

    # Start containers
    start_containers
}

# Configure ports with conflict detection
configure_ports() {
    echo -e "\n${BOLD}=== Port Configuration ===${NC}"

    # Find available ports
    find_available_port() {
        local start_port=$1
        local port=$start_port
        while lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; do
            ((port++))
        done
        echo $port
    }

    WEB_PORT=$(find_available_port 8080)
    DB_PORT=$(find_available_port 3306)
    REDIS_PORT=$(find_available_port 6379)
    NODE_PORT=$(find_available_port 3000)
    NGINX_PORT=$(find_available_port 8081)
    PMA_PORT=$(find_available_port 8082)
    FLUTTER_PORT=$(find_available_port 5000)

    echo -e "Auto-detected available ports:"
    echo -e "  ${BLUE}Web:${NC} $WEB_PORT"
    echo -e "  ${BLUE}MySQL:${NC} $DB_PORT"
    echo -e "  ${BLUE}Redis:${NC} $REDIS_PORT"
    echo -e "  ${BLUE}Node.js:${NC} $NODE_PORT"
    echo -e "  ${BLUE}Nginx:${NC} $NGINX_PORT"
    echo -e "  ${BLUE}phpMyAdmin:${NC} $PMA_PORT"
    echo -e "  ${BLUE}Flutter:${NC} $FLUTTER_PORT"

    read -p "Use these ports? (Y/n): " use_ports
    if [[ $use_ports =~ ^[Nn]$ ]]; then
        read -p "Web port [$WEB_PORT]: " custom_web_port
        read -p "Database port [$DB_PORT]: " custom_db_port
        read -p "phpMyAdmin port [$PMA_PORT]: " custom_pma_port

        [ -n "$custom_web_port" ] && WEB_PORT=$custom_web_port
        [ -n "$custom_db_port" ] && DB_PORT=$custom_db_port
        [ -n "$custom_pma_port" ] && PMA_PORT=$custom_pma_port
    fi
}

# Configure database settings
configure_database() {
    echo -e "\n${BOLD}=== Database Configuration ===${NC}"

    DB_NAME="${SELECTED_PROJECT}_db"
    DB_USER="developer"
    DB_PASS="dev123"
    MYSQL_ROOT_PASSWORD="root123"

    read -p "Database name [$DB_NAME]: " custom_db_name
    read -p "Database user [$DB_USER]: " custom_db_user
    read -s -p "Database password [$DB_PASS]: " custom_db_pass
    echo
    read -s -p "MySQL root password [$MYSQL_ROOT_PASSWORD]: " custom_root_pass
    echo

    [ -n "$custom_db_name" ] && DB_NAME=$custom_db_name
    [ -n "$custom_db_user" ] && DB_USER=$custom_db_user
    [ -n "$custom_db_pass" ] && DB_PASS=$custom_db_pass
    [ -n "$custom_root_pass" ] && MYSQL_ROOT_PASSWORD=$custom_root_pass
}

# Generate .denv file
generate_denv_file() {
    local denv_file="$SELECTED_PROJECT_PATH/.denv"

    print_info "Generating .denv configuration file..."

    cat > "$denv_file" << EOF
# Docker for FullStack - Project Environment Configuration
# Generated on $(date)

# === Project Information ===
PROJECT_NAME=$SELECTED_PROJECT
CONTAINERS=$CONTAINERS
PHP_VERSION=$PHP_VERSION
WEB_SERVER=$WEB_SERVER
NODE_VERSION=18

# === Port Configuration ===
WEB_PORT=$WEB_PORT
DB_PORT=$DB_PORT
REDIS_PORT=$REDIS_PORT
NODE_PORT=$NODE_PORT
NGINX_PORT=$NGINX_PORT
PMA_PORT=$PMA_PORT
FLUTTER_PORT=$FLUTTER_PORT
VITE_PORT=5173

# === Database Configuration ===
DB_NAME=$DB_NAME
DB_USER=$DB_USER
DB_PASS=$DB_PASS
MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD

# === Technology Stack ===
TECH_STACK=$TECH_STACK
DEPLOYMENT_TARGET=vps
GITHUB_ACTIONS=enabled

# === Development Environment ===
APP_ENV=development
DEBUG=true
XDEBUG=enabled

# === Container Resource Limits ===
PHP_MEMORY_LIMIT=512M
MYSQL_MEMORY_LIMIT=1G
REDIS_MEMORY_LIMIT=256M

# === User Mapping ===
USER_ID=$(id -u)
GROUP_ID=$(id -g)
EOF

    print_step ".denv file created: $denv_file"
}

# Copy project templates and scripts
copy_project_files() {
    print_info "Setting up project files and scripts..."

    # Copy project management scripts
    local scripts_source="$DOCKER_ROOT/templates/project-scripts"
    if [ -d "$scripts_source" ]; then
        print_info "Copying project management scripts..."
        cp "$scripts_source"/*.sh "$SELECTED_PROJECT_PATH/"
        chmod +x "$SELECTED_PROJECT_PATH"/*.sh
        print_step "Project scripts copied and made executable"
    fi

    # Copy technology-specific templates
    case "$TECH_STACK" in
        "laravel")
            copy_laravel_template
            ;;
        "flutter")
            copy_flutter_template
            ;;
        "vue")
            copy_vue_template
            ;;
        "codeigniter"|"symfony"|"php")
            copy_php_template
            ;;
    esac

    # Copy GitHub Actions workflow
    copy_github_actions_template
}

# Copy Laravel-specific template
copy_laravel_template() {
    print_info "Setting up Laravel project template..."

    local template_source="$DOCKER_ROOT/templates/laravel"
    if [ -d "$template_source" ]; then
        # Copy README template and customize it
        if [ -f "$template_source/README.project.md" ]; then
            sed -e "s/{PROJECT_NAME}/$SELECTED_PROJECT/g" \
                -e "s/{DATE}/$(date)/g" \
                -e "s/{WEB_PORT}/$WEB_PORT/g" \
                -e "s/{PMA_PORT}/$PMA_PORT/g" \
                -e "s/{DB_PORT}/$DB_PORT/g" \
                -e "s/{DB_NAME}/$DB_NAME/g" \
                -e "s/{DB_USER}/$DB_USER/g" \
                -e "s/{DB_PASS}/$DB_PASS/g" \
                -e "s/{PHP_VERSION}/$PHP_VERSION/g" \
                -e "s/{CONTAINERS}/$CONTAINERS/g" \
                "$template_source/README.project.md" > "$SELECTED_PROJECT_PATH/README.md"
            print_step "Laravel README created"
        fi

        # Create Laravel-specific files
        cat > "$SELECTED_PROJECT_PATH/.env.example" << EOF
APP_NAME=$SELECTED_PROJECT
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost:$WEB_PORT

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=$DB_NAME
DB_USERNAME=$DB_USER
DB_PASSWORD=$DB_PASS

BROADCAST_DRIVER=log
CACHE_DRIVER=redis
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=redis
SESSION_LIFETIME=120

REDIS_HOST=redis
REDIS_PASSWORD=null
REDIS_PORT=6379
EOF
        print_step "Laravel .env.example created"
    fi
}

# Copy Flutter-specific template
copy_flutter_template() {
    print_info "Setting up Flutter project template..."

    local template_source="$DOCKER_ROOT/templates/flutter"
    if [ -d "$template_source" ]; then
        # Copy README and customize
        if [ -f "$template_source/README.md" ]; then
            cp "$template_source/README.md" "$SELECTED_PROJECT_PATH/README.md"
            print_step "Flutter README created"
        fi

        # Create basic pubspec.yaml
        cat > "$SELECTED_PROJECT_PATH/pubspec.yaml" << EOF
name: $SELECTED_PROJECT
description: Docker for FullStack Flutter project

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true
EOF
        print_step "Flutter pubspec.yaml created"
    fi
}

# Copy Vue/PWA template
copy_vue_template() {
    print_info "Setting up Vue.js/PWA project template..."

    local template_source="$DOCKER_ROOT/templates/vue-pwa"
    if [ -d "$template_source" ]; then
        # Copy README and customize
        if [ -f "$template_source/README.md" ]; then
            cp "$template_source/README.md" "$SELECTED_PROJECT_PATH/README.md"
            print_step "Vue.js README created"
        fi

        # Create basic package.json
        cat > "$SELECTED_PROJECT_PATH/package.json" << EOF
{
  "name": "$SELECTED_PROJECT",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "vue": "^3.3.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^4.4.0",
    "vite": "^4.4.5"
  }
}
EOF
        print_step "Vue.js package.json created"
    fi
}

# Copy PHP template (for CodeIgniter, Symfony, custom PHP)
copy_php_template() {
    print_info "Setting up PHP project template..."

    # Create basic README
    cat > "$SELECTED_PROJECT_PATH/README.md" << EOF
# $SELECTED_PROJECT - $TECH_STACK Application

Docker for FullStack $TECH_STACK project created on $(date).

## 🚀 Quick Start

### Start Development Environment
\`\`\`bash
./start.sh
\`\`\`

### Stop Development Environment
\`\`\`bash
./stop.sh
\`\`\`

## 📊 Access Information

- **Web Application**: http://localhost:$WEB_PORT
- **phpMyAdmin**: http://localhost:$PMA_PORT
- **Database**: localhost:$DB_PORT

## 🗄️ Database Information

- **Host**: localhost:$DB_PORT (from host) or mysql (from container)
- **Database**: $DB_NAME
- **Username**: $DB_USER
- **Password**: $DB_PASS

## 🔧 Configuration

Project configuration is stored in \`.denv\` file.
EOF
    print_step "PHP project README created"
}

# Copy GitHub Actions VPS deployment templates
copy_github_actions_template() {
    print_info "Setting up GitHub Actions VPS deployment workflow..."

    # Create .github/workflows directory
    mkdir -p "$SELECTED_PROJECT_PATH/.github/workflows"

    local workflow_source="$DOCKER_ROOT/templates/github-actions"
    local workflow_file=""

    # Show available deployment options
    echo -e "\n${BOLD}Select GitHub Actions deployment template:${NC}"
    echo "1. General VPS deployment (Static sites, HTML/CSS/JS)"
    echo "2. Laravel VPS deployment (PHP Laravel applications)"
    echo "3. CodeIgniter VPS deployment (PHP CodeIgniter applications)"
    echo "4. Vue.js PWA VPS deployment (Vue.js Progressive Web Apps)"
    echo "5. Flutter Web VPS deployment (Flutter web applications)"
    echo "6. Skip GitHub Actions setup"

    read -p "Select deployment type [1]: " deployment_choice
    case $deployment_choice in
        1|"")
            workflow_file="vps-deployment.yml"
            print_info "Selected: General VPS deployment"
            ;;
        2)
            workflow_file="laravel-vps.yml"
            print_info "Selected: Laravel VPS deployment"
            ;;
        3)
            workflow_file="codeigniter-vps.yml"
            print_info "Selected: CodeIgniter VPS deployment"
            ;;
        4)
            workflow_file="vue-vps.yml"
            print_info "Selected: Vue.js PWA VPS deployment"
            ;;
        5)
            workflow_file="flutter-web-vps.yml"
            print_info "Selected: Flutter Web VPS deployment"
            ;;
        6)
            print_info "Skipping GitHub Actions setup"
            return 0
            ;;
        *)
            print_warning "Invalid selection. Using general VPS deployment."
            workflow_file="vps-deployment.yml"
            ;;
    esac

    if [ -n "$workflow_file" ] && [ -f "$workflow_source/$workflow_file" ]; then
        # Copy VPS deployment workflow
        cp "$workflow_source/$workflow_file" "$SELECTED_PROJECT_PATH/.github/workflows/deploy-vps.yml"
        print_step "GitHub Actions VPS deployment workflow created"

        # Copy README for reference
        if [ -f "$workflow_source/README.md" ]; then
            cp "$workflow_source/README.md" "$SELECTED_PROJECT_PATH/.github/workflows/README.md"
            print_step "GitHub Actions documentation copied"
        fi

        # Display setup instructions
        echo -e "\n${BOLD}=== GitHub Actions Setup Complete ===${NC}"
        echo -e "${BLUE}Next steps:${NC}"
        echo -e "1. Add these secrets to your GitHub repository:"
        echo -e "   - VPS_SSH_KEY (Private SSH key for VPS access)"
        echo -e "   - VPS_HOST (VPS IP address or hostname)"
        echo -e "   - VPS_USER (VPS username)"
        echo -e "   - DOMAIN_NAME (Domain name for deployment)"

        if [ "$workflow_file" = "laravel-vps.yml" ]; then
            echo -e "   - DB_HOST, DB_DATABASE, DB_USERNAME, DB_PASSWORD"
            echo -e "   - APP_KEY, APP_URL"
        elif [ "$workflow_file" = "codeigniter-vps.yml" ]; then
            echo -e "   - DB_HOST, DB_DATABASE, DB_USERNAME, DB_PASSWORD"
            echo -e "   - APP_URL (CodeIgniter base URL)"
        fi

        echo -e "2. Push your project to GitHub"
        echo -e "3. Deployment will trigger automatically on push to main branch"
        echo -e "\n${YELLOW}For detailed setup instructions, see: .github/workflows/README.md${NC}"
    else
        print_error "GitHub Actions template not found: $workflow_file"
    fi
}

# Start containers
start_containers() {
    echo -e "\n${BOLD}=== Starting Docker Containers ===${NC}"

    local denv_file="$SELECTED_PROJECT_PATH/.denv"

    # Change to project directory
    cd "$SELECTED_PROJECT_PATH"

    print_info "Project directory: $(pwd)"
    print_info "Docker root: $DOCKER_ROOT"
    print_info "Using configuration: $denv_file"

    # Load environment variables
    if [ -f "$denv_file" ]; then
        set -a
        source "$denv_file"
        set +a
        print_step "Environment variables loaded"
    else
        print_error ".denv file not found: $denv_file"
        exit 1
    fi

    # Start containers with profiles
    local compose_profiles=""
    IFS=',' read -ra CONTAINER_LIST <<< "$CONTAINERS"
    for container in "${CONTAINER_LIST[@]}"; do
        compose_profiles="${compose_profiles},${container}"
    done
    compose_profiles=${compose_profiles#,}

    print_info "Starting containers: $compose_profiles"

    # Use docker-compose or docker compose
    local compose_cmd="docker-compose"
    if ! command -v docker-compose &> /dev/null; then
        compose_cmd="docker compose"
    fi

    # Stop any existing containers
    $compose_cmd -f "$DOCKER_ROOT/containers/docker-compose.yml" --env-file "$denv_file" down 2>/dev/null || true

    # Start new containers
    COMPOSE_PROFILES="$compose_profiles" $compose_cmd -f "$DOCKER_ROOT/containers/docker-compose.yml" --env-file "$denv_file" up -d

    print_step "Containers started successfully!"

    # Display access information
    display_access_info
}

# Display access information
display_access_info() {
    echo -e "\n${GREEN}${BOLD}🎉 Setup completed successfully!${NC}"
    echo -e "\n${BOLD}=== Access Information ===${NC}"
    echo -e "${BLUE}🌐 Web Application:${NC} http://localhost:$WEB_PORT"

    if [[ $CONTAINERS == *"phpmyadmin"* ]]; then
        echo -e "${BLUE}🗄️ phpMyAdmin:${NC} http://localhost:$PMA_PORT"
    fi

    if [[ $CONTAINERS == *"nodejs"* ]]; then
        echo -e "${BLUE}⚡ Node.js Dev Server:${NC} http://localhost:$NODE_PORT"
    fi

    if [[ $CONTAINERS == *"flutter"* ]]; then
        echo -e "${BLUE}📱 Flutter Web:${NC} http://localhost:$FLUTTER_PORT"
    fi

    echo -e "\n${BOLD}=== Database Information ===${NC}"
    echo -e "${BLUE}Host:${NC} localhost:$DB_PORT"
    echo -e "${BLUE}Database:${NC} $DB_NAME"
    echo -e "${BLUE}Username:${NC} $DB_USER"
    echo -e "${BLUE}Password:${NC} $DB_PASS"

    echo -e "\n${BOLD}=== Useful Commands ===${NC}"
    echo -e "${YELLOW}• View status:${NC} $DOCKER_ROOT/scripts/container-helper.sh status"
    echo -e "${YELLOW}• View logs:${NC} $DOCKER_ROOT/scripts/container-helper.sh logs web"
    echo -e "${YELLOW}• Enter container:${NC} $DOCKER_ROOT/scripts/container-helper.sh exec web bash"
    echo -e "${YELLOW}• Stop containers:${NC} $DOCKER_ROOT/scripts/stop.sh"

    echo -e "\n${BOLD}=== Project Files ===${NC}"
    echo -e "${BLUE}• Project directory:${NC} $SELECTED_PROJECT_PATH"
    echo -e "${BLUE}• Configuration:${NC} $SELECTED_PROJECT_PATH/.denv"
    echo -e "${BLUE}• Docker compose:${NC} $DOCKER_ROOT/containers/docker-compose.yml"

    echo -e "\n${GREEN}Happy coding with Docker for FullStack! 🚀${NC}"
}

# Main execution
main() {
    print_header

    # Check and setup Docker prerequisites
    check_docker_prerequisites

    check_projects_directory
    list_projects
}

# Run main function
main "$@"
