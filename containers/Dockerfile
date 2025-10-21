# Multi-stage Dockerfile for QUOCNHO Team Development Environment
# Supports multiple PHP versions (8.1, 8.2, 8.3, 8.4) and web servers (Apache, Nginx)

ARG PHP_VERSION=8.3
ARG WEB_SERVER=apache

# Base PHP image selection
FROM php:${PHP_VERSION}-${WEB_SERVER} as base

# Set build arguments for user mapping
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG WEB_SERVER=apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    default-mysql-client \
    nano \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo pdo_mysql mysqli zip exif

# Enable Apache modules
RUN a2enmod rewrite ssl headers

# Configure PHP for production and development
RUN echo "upload_max_filesize = 64M" >> /usr/local/etc/php/php.ini \
    && echo "post_max_size = 64M" >> /usr/local/etc/php/php.ini \
    && echo "max_execution_time = 300" >> /usr/local/etc/php/php.ini \
    && echo "memory_limit = 512M" >> /usr/local/etc/php/php.ini \
    && echo "date.timezone = Asia/Ho_Chi_Minh" >> /usr/local/etc/php/php.ini \
    && echo "log_errors = On" >> /usr/local/etc/php/php.ini \
    && echo "error_log = /var/log/php_errors.log" >> /usr/local/etc/php/php.ini \
    && echo "display_errors = Off" >> /usr/local/etc/php/php.ini

# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Create optimized Apache virtual host
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html\n\
    ServerName localhost\n\
    <Directory /var/www/html>\n\
        Options Indexes FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
        DirectoryIndex index.php index.html\n\
    </Directory>\n\
    <Directory /var/www/html/install>\n\
        Options Indexes FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
    ErrorLog ${APACHE_LOG_DIR}/error.log\n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
    LogLevel warn\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Create www-data user with matching UID/GID if needed
RUN if [ ${USER_ID} -ne 33 ]; then \
        groupmod -g ${GROUP_ID} www-data && \
        usermod -u ${USER_ID} -g ${GROUP_ID} www-data; \
    fi

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . /var/www/html/

# Create necessary directories
RUN mkdir -p /var/www/html/uploads \
    && mkdir -p /var/www/html/application/cache \
    && mkdir -p /var/www/html/application/logs \
    && mkdir -p /var/www/html/assets/blueimp \
    && mkdir -p /var/www/html/install/cache

# Set comprehensive permissions
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \; \
    && chmod -R 777 /var/www/html/application/cache \
    && chmod -R 777 /var/www/html/application/logs \
    && chmod -R 777 /var/www/html/uploads \
    && chmod -R 777 /var/www/html/assets \
    && chmod -R 777 /var/www/html/install \
    && chmod 666 /var/www/html/index.php \
    && chmod 666 /var/www/html/application/config/config.php \
    && chmod 666 /var/www/html/application/config/database.php

# Copy entrypoint script
COPY Docker/containers/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose port 80
EXPOSE 80

# Use entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["apache2-foreground"]
