#!/bin/bash
set -e

echo "🚀 Starting ${PROJECT_NAME} container setup..."

# Function to wait for MySQL
wait_for_mysql() {
    echo "⏳ Waiting for MySQL to be ready..."
    while ! mysqladmin ping -h"${DB_HOST:-mysql}" -u"${DB_USER}" -p"${DB_PASS}" --silent; do
        sleep 2
    done
    echo "✅ MySQL is ready!"
}

# Function to fix permissions
fix_permissions() {
    echo "🔧 Fixing file permissions..."

    # Ensure www-data owns all files
    chown -R www-data:www-data /var/www/html

    # Set base permissions
    find /var/www/html -type d -exec chmod 755 {} \;
    find /var/www/html -type f -exec chmod 644 {} \;

    # Set writable permissions for specific directories
    chmod -R 777 /var/www/html/application/cache
    chmod -R 777 /var/www/html/application/logs
    chmod -R 777 /var/www/html/uploads
    chmod -R 777 /var/www/html/assets
    chmod -R 777 /var/www/html/install

    # Set writable permissions for specific files
    chmod 666 /var/www/html/index.php
    chmod 666 /var/www/html/application/config/config.php
    chmod 666 /var/www/html/application/config/database.php

    echo "✅ Permissions fixed!"
}

# Function to setup database config
setup_database_config() {
    echo "🗄️ Setting up database configuration..."

    # Update database config if environment variables are set
    if [ ! -z "${DB_HOST}" ] || [ ! -z "${DB_USER}" ] || [ ! -z "${DB_PASS}" ] || [ ! -z "${DB_NAME}" ]; then
        cat > /var/www/html/application/config/database.php << EOF
<?php defined('BASEPATH') OR exit('No direct script access allowed');

\$active_group = 'default';
\$query_builder = TRUE;

\$db['default'] = array(
    'dsn'	=> '',
    'hostname' => '${DB_HOST:-mysql}',
    'username' => '${DB_USER}',
    'password' => '${DB_PASS}',
    'database' => '${DB_NAME}',
    'dbdriver' => 'mysqli',
    'dbprefix' => '',
    'pconnect' => FALSE,
    'db_debug' => FALSE,
    'cache_on' => FALSE,
    'cachedir' => '',
    'char_set' => 'utf8',
    'dbcollat' => 'utf8_general_ci',
    'swap_pre' => '',
    'encrypt' => FALSE,
    'compress' => FALSE,
    'stricton' => FALSE,
    'failover' => array(),
    'save_queries' => FALSE
);
EOF
        chown www-data:www-data /var/www/html/application/config/database.php
        chmod 666 /var/www/html/application/config/database.php
        echo "✅ Database config updated!"
    fi
}

# Function to test database connection
test_database_connection() {
    echo "🔌 Testing database connection..."

    DB_HOST_VAR=${DB_HOST:-mysql}
    DB_USER_VAR=${DB_USER}
    DB_PASS_VAR=${DB_PASS}
    DB_NAME_VAR=${DB_NAME}

    if mysql -h"$DB_HOST_VAR" -u"$DB_USER_VAR" -p"$DB_PASS_VAR" -e "USE $DB_NAME_VAR; SHOW TABLES;" > /dev/null 2>&1; then
        echo "✅ Database connection successful!"
        return 0
    else
        echo "⚠️ Database connection failed, but continuing..."
        return 1
    fi
}

# Function to create necessary directories
create_directories() {
    echo "📁 Creating necessary directories..."

    mkdir -p /var/www/html/application/cache
    mkdir -p /var/www/html/application/logs
    mkdir -p /var/www/html/uploads
    mkdir -p /var/www/html/assets/blueimp
    mkdir -p /var/www/html/install/cache

    echo "✅ Directories created!"
}

# Main setup process
main() {
    echo "🐳 ${PROJECT_NAME} Docker Container Starting..."
    echo "=================================="

    # Wait for MySQL if not in development mode
    if [ "${SKIP_MYSQL_WAIT}" != "true" ]; then
        wait_for_mysql
    fi

    # Setup
    create_directories
    fix_permissions
    setup_database_config

    # Test database connection
    if [ "${SKIP_DB_TEST}" != "true" ]; then
        test_database_connection
    fi

    echo ""
    echo "🎉 Container setup complete!"
    echo "=================================="
    echo "🌐 Access your application:"
    echo "   - Main app: http://localhost:8080"
    echo "   - Installer: http://localhost:8080/install/"
    echo "   - phpMyAdmin: http://localhost:8081"
    echo ""
    echo "🗄️ Database info:"
    echo "   - Host: ${DB_HOST:-mysql}"
    echo "   - Database: ${DB_NAME}"
    echo "   - Username: ${DB_USER}"
    echo "   - Password: ${DB_PASS}"
    echo "=================================="
    echo ""
}

# Run main setup
main

# Execute the original command
exec "$@"
