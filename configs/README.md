# Server Configuration Files

Thư mục này chứa các file cấu hình cho server và các services.

## Cấu trúc:

### `php/`
- Cấu hình PHP và extensions
- Custom php.ini settings
- Xdebug configuration

### `nginx/` (nếu sử dụng)
- Nginx configuration files
- Virtual hosts setup
- SSL certificates

### `mysql/`
- MySQL configuration files
- Custom my.cnf settings
- Init scripts

### `apache/`
- Apache configuration files
- Virtual hosts
- .htaccess templates

### `env/`
- Environment configuration templates
- Different env files for different stages
- Security configurations

## Sử dụng:
Các file cấu hình này được mount vào containers tương ứng trong docker-compose.yml
