# PHP Requirements for Fukoji Project

## PHP Version
- **Required**: PHP 8.1 or later
- **Recommended**: PHP 8.4
- **Supported**: PHP 8.1, 8.2, 8.3, 8.4

## Required PHP Extensions

### Core Extensions
```php
// Always required
- pdo_mysql      // MySQL PDO driver
- mysqli         // MySQL improved extension
- mbstring       // Multi-byte string functions
- curl           // HTTP client
- json           // JSON handling
- xml            // XML processing
- zip            // Archive handling
- gd             // Image processing
- intl           // Internationalization
- bcmath         // Arbitrary precision mathematics
```

### CodeIgniter 4 Requirements
```php
// Framework requirements
- filter         // Data filtering
- hash           // Hashing functions
- openssl        // SSL/TLS support
- session        // Session handling
- tokenizer      // PHP tokenizer
- ctype          // Character type functions
```

### Optional Extensions
```php
// Performance and features
- opcache        // PHP opcode cache
- apcu           // User cache
- redis          // Redis client (if using Redis)
- imagick        // Advanced image processing
- xdebug         // Debugging (development only)
```

## Composer Dependencies

### Production Dependencies
```json
{
    "require": {
        "php": "^8.1",
        "codeigniter4/framework": "^4.4",
        "aws/aws-sdk-php": "^3.0",
        "bshaffer/oauth2-server-php": "^1.13",
        "doctrine/dbal": "^3.0",
        "guzzlehttp/guzzle": "^7.0",
        "nikic/fast-route": "^1.3",
        "psr/log": "^3.0",
        "symfony/console": "^6.0",
        "zircote/swagger-php": "^4.0"
    }
}
```

### Development Dependencies
```json
{
    "require-dev": {
        "phpunit/phpunit": "^10.0",
        "friendsofphp/php-cs-fixer": "^3.0",
        "phpstan/phpstan": "^1.10",
        "squizlabs/php_codesniffer": "^3.7",
        "phpmd/phpmd": "^2.13"
    }
}
```

## PHP Configuration

### Memory Settings
```ini
memory_limit = 512M              ; Development
memory_limit = 256M              ; Production
max_execution_time = 300         ; Development
max_execution_time = 60          ; Production
```

### File Upload Settings
```ini
post_max_size = 100M
upload_max_filesize = 100M
max_file_uploads = 50
```

### Error Handling
```ini
; Development
display_errors = On
display_startup_errors = On
log_errors = On
error_reporting = E_ALL

; Production
display_errors = Off
display_startup_errors = Off
log_errors = On
error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT
```

### Session Configuration
```ini
session.gc_maxlifetime = 3600
session.cookie_lifetime = 0
session.cookie_httponly = 1
session.cookie_secure = 1        ; HTTPS only
session.use_strict_mode = 1
```

### Opcache Configuration
```ini
opcache.enable = 1
opcache.memory_consumption = 128
opcache.interned_strings_buffer = 8
opcache.max_accelerated_files = 4000
opcache.revalidate_freq = 60
opcache.fast_shutdown = 1
opcache.validate_timestamps = 0  ; Production
opcache.validate_timestamps = 1  ; Development
```

## Framework Requirements

### CodeIgniter 4 Specific
```php
// Minimum requirements
- PHP 8.1+
- Rewrite module enabled (Apache mod_rewrite)
- mbstring extension
- JSON extension
- MySQLi or PostgreSQL drivers
```

### Database Requirements
```php
// Supported databases
- MySQL 5.7+ / MariaDB 10.3+
- PostgreSQL 10+
- SQLite 3.7.17+
- SQL Server 2012+
```

## Development Tools

### Code Quality Tools
```bash
# PHP CS Fixer
composer require --dev friendsofphp/php-cs-fixer

# PHPStan
composer require --dev phpstan/phpstan

# PHPMD
composer require --dev phpmd/phpmd

# PHP CodeSniffer
composer require --dev squizlabs/php_codesniffer
```

### Testing Framework
```bash
# PHPUnit
composer require --dev phpunit/phpunit

# Mockery
composer require --dev mockery/mockery

# Pest (alternative)
composer require --dev pestphp/pest
```

### Debugging Tools
```bash
# Xdebug (development only)
pecl install xdebug

# Whoops (better error pages)
composer require --dev filp/whoops
```

## Performance Requirements

### Minimum Performance Targets
- **Response Time**: < 200ms for cached pages
- **Memory Usage**: < 64MB per request
- **Concurrent Users**: 100+ on single container

### Optimization Tools
```php
// Recommended optimizations
- Opcache enabled
- Autoloader optimization
- Route caching
- Configuration caching
- View caching
```

## Security Requirements

### Security Extensions
```php
// Security-related extensions
- openssl        // Encryption
- hash           // Secure hashing
- filter         // Input filtering
- ctype          // Character validation
```

### Security Configuration
```ini
; Security settings
expose_php = Off
allow_url_fopen = Off
allow_url_include = Off
disable_functions = exec,passthru,shell_exec,system,proc_open,popen
```
