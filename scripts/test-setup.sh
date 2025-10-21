#!/bin/bash
# Test script for Docker for FullStack Environment

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[TEST]${NC} $1"
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

# Test variables
TEST_PROJECT_NAME="test-laravel-app"
DOCKER_ROOT="/home/quocnho/Development/Docker"
PROJECTS_DIR="/home/quocnho/Development/Projects"
TEST_PROJECT_PATH="$PROJECTS_DIR/$TEST_PROJECT_NAME"

echo "=================================================================="
echo "🧪 Docker for FullStack Environment - Automated Test"
echo "=================================================================="

# Cleanup any existing test project
if [ -d "$TEST_PROJECT_PATH" ]; then
    print_warning "Removing existing test project..."
    rm -rf "$TEST_PROJECT_PATH"
fi

# Create test project manually (simulating setup.new.sh choices)
print_info "Creating test project directory..."
mkdir -p "$TEST_PROJECT_PATH"

# Create .denv file
print_info "Creating .denv configuration..."
cat > "$TEST_PROJECT_PATH/.denv" << EOF
# Docker for FullStack - Project Environment Configuration
# Generated for testing

# === Project Information ===
PROJECT_NAME=$TEST_PROJECT_NAME
CONTAINERS=web,mysql,phpmyadmin
PHP_VERSION=8.3
WEB_SERVER=apache
NODE_VERSION=18

# === Port Configuration ===
WEB_PORT=8080
DB_PORT=3306
REDIS_PORT=6379
NODE_PORT=3000
NGINX_PORT=8081
PMA_PORT=8082
FLUTTER_PORT=5000
VITE_PORT=5173

# === Database Configuration ===
DB_NAME=${TEST_PROJECT_NAME}_db
DB_USER=developer
DB_PASS=dev123
MYSQL_ROOT_PASSWORD=root123

# === Technology Stack ===
TECH_STACK=laravel
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

print_success ".denv file created"

# Copy project scripts
print_info "Copying project management scripts..."
cp "$DOCKER_ROOT/templates/project-scripts"/*.sh "$TEST_PROJECT_PATH/"
chmod +x "$TEST_PROJECT_PATH"/*.sh
print_success "Project scripts copied"

# Copy Laravel template files
print_info "Setting up Laravel project template..."

# Create README
sed -e "s/{PROJECT_NAME}/$TEST_PROJECT_NAME/g" \
    -e "s/{DATE}/$(date)/g" \
    -e "s/{WEB_PORT}/8080/g" \
    -e "s/{PMA_PORT}/8082/g" \
    -e "s/{DB_PORT}/3306/g" \
    -e "s/{DB_NAME}/${TEST_PROJECT_NAME}_db/g" \
    -e "s/{DB_USER}/developer/g" \
    -e "s/{DB_PASS}/dev123/g" \
    -e "s/{PHP_VERSION}/8.3/g" \
    -e "s/{CONTAINERS}/web,mysql,phpmyadmin/g" \
    "$DOCKER_ROOT/templates/laravel/README.project.md" > "$TEST_PROJECT_PATH/README.md"

# Create .env.example
cat > "$TEST_PROJECT_PATH/.env.example" << EOF
APP_NAME=$TEST_PROJECT_NAME
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost:8080

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=${TEST_PROJECT_NAME}_db
DB_USERNAME=developer
DB_PASSWORD=dev123

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120
EOF

# Create GitHub Actions workflow
mkdir -p "$TEST_PROJECT_PATH/.github/workflows"
sed "s/{PROJECT_NAME}/$TEST_PROJECT_NAME/g" \
    "$DOCKER_ROOT/templates/github-actions/laravel.yml" > "$TEST_PROJECT_PATH/.github/workflows/ci-cd.yml"

print_success "Laravel template files created"

# Test script functionality
print_info "Testing project scripts..."

cd "$TEST_PROJECT_PATH"

# Test that scripts exist and are executable
for script in start.sh stop.sh restart.sh container-helper.sh; do
    if [ -x "$script" ]; then
        print_success "$script is executable"
    else
        print_error "$script is not executable"
        exit 1
    fi
done

# Test .denv loading
if [ -f ".denv" ]; then
    source ".denv"
    if [ "$PROJECT_NAME" = "$TEST_PROJECT_NAME" ]; then
        print_success ".denv loads correctly"
    else
        print_error ".denv loading failed"
        exit 1
    fi
else
    print_error ".denv file not found"
    exit 1
fi

# Test Docker Compose configuration
print_info "Testing Docker Compose configuration..."
if [ -f "$DOCKER_ROOT/containers/docker-compose.yml" ]; then
    # Use docker-compose or docker compose
    COMPOSE_CMD="docker-compose"
    if ! command -v docker-compose &> /dev/null; then
        COMPOSE_CMD="docker compose"
    fi

    # Test configuration validity
    if $COMPOSE_CMD -f "$DOCKER_ROOT/containers/docker-compose.yml" --env-file ".denv" config > /dev/null 2>&1; then
        print_success "Docker Compose configuration is valid"
    else
        print_error "Docker Compose configuration is invalid"
        exit 1
    fi
else
    print_error "Docker Compose file not found"
    exit 1
fi

# Test port availability
print_info "Testing port availability..."
check_port() {
    local port=$1
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
        print_warning "Port $port is in use"
        return 1
    else
        print_success "Port $port is available"
        return 0
    fi
}

check_port 8080
check_port 3306
check_port 8082

print_success "All tests passed!"

echo ""
echo "=================================================================="
echo "🎉 Test Project Created Successfully!"
echo "=================================================================="
echo "📁 Project Location: $TEST_PROJECT_PATH"
echo "🔧 Configuration: $TEST_PROJECT_PATH/.denv"
echo ""
echo "To start the test project:"
echo "  cd $TEST_PROJECT_PATH"
echo "  ./start.sh"
echo ""
echo "To clean up the test project:"
echo "  rm -rf $TEST_PROJECT_PATH"
echo "=================================================================="
