#!/bin/bash

echo "🔧 Fixing permissions for ${PROJECT_NAME} Docker containers..."

# Change to project root directory
cd "$(dirname "$0")/../.."
PROJECT_ROOT=$(pwd)

# Ensure PROJECT_NAME is set
PROJECT_NAME=${PROJECT_NAME}

# Fix permissions for web-writable directories
docker exec -it ${PROJECT_NAME}_web bash -c "
    chown -R www-data:www-data \
        /var/www/html/application/cache \
        /var/www/html/application/logs \
        /var/www/html/application/config \
        /var/www/html/uploads \
        /var/www/html/assets \
        /var/www/html/install \
        /var/www/html/index.php

    chmod -R ug+rwX \
        /var/www/html/application/cache \
        /var/www/html/application/logs \
        /var/www/html/application/config \
        /var/www/html/uploads \
        /var/www/html/assets \
        /var/www/html/install \
        /var/www/html/index.php
"

echo "✅ Permissions fixed!"
echo ""
echo "📋 Fixed permissions for:"
echo "   - application/cache (CodeIgniter cache)"
echo "   - application/logs (CodeIgniter logs)"
echo "   - application/config (config files)"
echo "   - uploads (file uploads)"
echo "   - assets (CSS/JS/images)"
echo "   - install (installer files)"
echo "   - index.php (main entry point)"
echo ""
echo "🌐 You can now continue with the installation:"
echo "   http://localhost:8080/install/"
