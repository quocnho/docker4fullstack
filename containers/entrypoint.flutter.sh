#!/bin/bash
# QUOCNHO Team - Flutter Container Entrypoint Script

set -e

print_info() {
    echo -e "\033[0;34m[INFO]\033[0m $1"
}

print_success() {
    echo -e "\033[0;32m[SUCCESS]\033[0m $1"
}

print_warning() {
    echo -e "\033[1;33m[WARNING]\033[0m $1"
}

print_error() {
    echo -e "\033[0;31m[ERROR]\033[0m $1"
}

echo "=================================================================="
echo "🚀 QUOCNHO Team - Flutter Development Environment"
echo "=================================================================="
print_info "Project: ${PROJECT_NAME:-unknown}"
print_info "Flutter Version: $(flutter --version | head -n1)"
print_info "Environment: ${APP_ENV:-development}"
echo "=================================================================="

# Check if this is a Flutter project
if [ -f /app/pubspec.yaml ]; then
    print_info "Flutter project detected"
    cd /app

    # Get dependencies
    print_info "Getting Flutter dependencies..."
    flutter pub get

    # Enable web support if not already enabled
    flutter config --enable-web

    # Run flutter doctor to check setup
    print_info "Running Flutter doctor..."
    flutter doctor

    print_success "Flutter project setup completed"

    # Start Flutter web server if requested
    if [ "$1" = "web" ]; then
        print_info "Starting Flutter web server on port ${FLUTTER_WEB_PORT:-5000}"
        exec flutter run -d web-server --web-port=${FLUTTER_WEB_PORT:-5000} --web-hostname=0.0.0.0
    fi
else
    print_warning "No pubspec.yaml found - not a Flutter project"
fi

# If no specific command provided, start bash
if [ "$#" -eq 0 ]; then
    print_info "Starting interactive shell..."
    exec /bin/bash
else
    exec "$@"
fi
