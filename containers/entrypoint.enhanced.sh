#!/bin/bash
# QUOCNHO Team - Enhanced Container Entrypoint Script

set -e

# Color output functions
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

# Display startup banner
echo "=================================================================="
echo "🚀 QUOCNHO Team Development Environment"
echo "=================================================================="
print_info "Project: ${PROJECT_NAME:-unknown}"
print_info "Environment: ${APP_ENV:-development}"
print_info "Technology: ${TECH_STACK:-php}"
if command -v php >/dev/null 2>&1; then
    print_info "PHP Version: $(php -v | head -n1 | cut -d' ' -f2)"
fi
if [ -n "$WEB_SERVER" ]; then
    print_info "Web Server: ${WEB_SERVER}"
fi
echo "=================================================================="

# Install Composer if not present and we're in a PHP container
if command -v php >/dev/null 2>&1 && [ ! -f /usr/local/bin/composer ]; then
    print_info "Installing Composer..."
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    print_success "Composer installed"
fi

# Set up user permissions if USER_ID and GROUP_ID are provided
if [ -n "$USER_ID" ] && [ -n "$GROUP_ID" ]; then
    print_info "Setting up user permissions (UID:$USER_ID, GID:$GROUP_ID)"

    # Create group if it doesn't exist
    if ! getent group $GROUP_ID > /dev/null 2>&1; then
        groupadd -g $GROUP_ID webgroup
    fi

    # Create user if it doesn't exist
    if ! getent passwd $USER_ID > /dev/null 2>&1; then
        useradd -u $USER_ID -g $GROUP_ID -m webuser
    fi

    # Set ownership of web directory
    chown -R $USER_ID:$GROUP_ID /var/www/html 2>/dev/null || true
    print_success "User permissions configured"
else
    # Set proper permissions for www-data
    if [ -d /var/www/html ]; then
        chown -R www-data:www-data /var/www/html 2>/dev/null || true
        chmod -R 755 /var/www/html 2>/dev/null || true
    fi
fi

# Configure Xdebug based on environment
if [ "$XDEBUG" = "enabled" ] && [ "$APP_ENV" = "development" ]; then
    print_info "Enabling Xdebug for development"
    if [ -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini ]; then
        {
            echo "xdebug.mode=debug"
            echo "xdebug.client_host=host.docker.internal"
            echo "xdebug.client_port=9003"
            echo "xdebug.idekey=VSCODE"
            echo "xdebug.start_with_request=yes"
        } >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
        print_success "Xdebug enabled"
    fi
elif [ "$APP_ENV" = "production" ]; then
    print_info "Disabling Xdebug for production"
    if [ -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini ]; then
        rm /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
        print_success "Xdebug disabled"
    fi
fi

# Set PHP memory limit
if [ -n "$PHP_MEMORY_LIMIT" ] && command -v php >/dev/null 2>&1; then
    print_info "Setting PHP memory limit to $PHP_MEMORY_LIMIT"
    echo "memory_limit = $PHP_MEMORY_LIMIT" > /usr/local/etc/php/conf.d/memory.ini
fi

# Wait for database if configured
if [ -n "$DB_HOST" ] && [ -n "$DB_NAME" ]; then
    print_info "Waiting for database connection..."
    timeout=60
    while ! mysqladmin ping -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASS" --silent 2>/dev/null; do
        sleep 2
        timeout=$((timeout - 2))
        if [ $timeout -le 0 ]; then
            print_warning "Database connection timeout, continuing anyway..."
            break
        fi
    done
    if [ $timeout -gt 0 ]; then
        print_success "Database connection established"
    fi
fi

# Wait for Redis if configured
if [ -n "$REDIS_HOST" ]; then
    print_info "Waiting for Redis connection..."
    timeout=30
    while ! redis-cli -h "$REDIS_HOST" ping > /dev/null 2>&1; do
        sleep 2
        timeout=$((timeout - 2))
        if [ $timeout -le 0 ]; then
            print_warning "Redis connection timeout, continuing anyway..."
            break
        fi
    done
    if [ $timeout -gt 0 ]; then
        print_success "Redis connection established"
    fi
fi

# Create necessary directories based on technology stack
create_directories() {
    case "$TECH_STACK" in
        "laravel")
            mkdir -p /var/www/html/storage/logs
            mkdir -p /var/www/html/storage/framework/cache
            mkdir -p /var/www/html/storage/framework/sessions
            mkdir -p /var/www/html/storage/framework/views
            mkdir -p /var/www/html/bootstrap/cache
            ;;
        "codeigniter")
            mkdir -p /var/www/html/application/cache
            mkdir -p /var/www/html/application/logs
            mkdir -p /var/www/html/uploads
            mkdir -p /var/www/html/assets
            ;;
        "symfony")
            mkdir -p /var/www/html/var/cache
            mkdir -p /var/www/html/var/log
            ;;
    esac
}

# Run technology-specific setup
case "$TECH_STACK" in
    "laravel")
        print_info "Setting up Laravel environment"
        if [ -f /var/www/html/artisan ]; then
            cd /var/www/html
            create_directories
            if [ ! -f .env ] && [ -f .env.example ]; then
                cp .env.example .env
            fi
            # Set proper permissions for Laravel
            chmod -R 775 /var/www/html/storage 2>/dev/null || true
            chmod -R 775 /var/www/html/bootstrap/cache 2>/dev/null || true
            # Run Laravel setup commands
            php artisan key:generate --force 2>/dev/null || true
            php artisan config:cache 2>/dev/null || true
            print_success "Laravel setup completed"
        fi
        ;;
    "codeigniter")
        print_info "Setting up CodeIgniter environment"
        create_directories
        # Set writable permissions for CodeIgniter directories
        chmod -R 777 /var/www/html/application/cache 2>/dev/null || true
        chmod -R 777 /var/www/html/application/logs 2>/dev/null || true
        chmod -R 777 /var/www/html/uploads 2>/dev/null || true
        print_success "CodeIgniter setup completed"
        ;;
    "symfony")
        print_info "Setting up Symfony environment"
        if [ -f /var/www/html/bin/console ]; then
            cd /var/www/html
            create_directories
            chmod -R 777 /var/www/html/var 2>/dev/null || true
            php bin/console cache:clear --env=dev 2>/dev/null || true
            print_success "Symfony setup completed"
        fi
        ;;
    *)
        print_info "Generic PHP setup"
        create_directories
        ;;
esac

print_success "Container initialization completed!"
echo "=================================================================="
echo "🌐 Access Information:"
if [ -n "$WEB_PORT" ]; then
    echo "   - Web Application: http://localhost:${WEB_PORT}"
fi
if [ -n "$PMA_PORT" ]; then
    echo "   - phpMyAdmin: http://localhost:${PMA_PORT}"
fi
if [ -n "$DB_HOST" ] && [ -n "$DB_NAME" ]; then
    echo "🗄️ Database Information:"
    echo "   - Host: ${DB_HOST}"
    echo "   - Database: ${DB_NAME}"
    echo "   - User: ${DB_USER}"
fi
echo "=================================================================="

# Execute the main command
exec "$@"
