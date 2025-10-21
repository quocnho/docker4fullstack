# Docker Requirements for Fukoji Project

## Base Images

### Web Server
```dockerfile
FROM php:8.4-apache
```
- **Source**: Official PHP Docker image
- **Size**: ~500MB
- **Updates**: Regular security updates
- **Documentation**: https://hub.docker.com/_/php

### Database
```dockerfile
FROM mysql:8.0
```
- **Source**: Official MySQL Docker image
- **Size**: ~600MB
- **Updates**: Regular security updates
- **Documentation**: https://hub.docker.com/_/mysql

### Database Management
```dockerfile
FROM phpmyadmin/phpmyadmin:latest
```
- **Source**: Official phpMyAdmin Docker image
- **Size**: ~200MB
- **Updates**: Regular feature updates
- **Documentation**: https://hub.docker.com/r/phpmyadmin/phpmyadmin

## Image Requirements

### Total Storage Space
- **Base Images**: ~1.3GB
- **Application Code**: ~500MB
- **Database Data**: Variable (starts ~50MB)
- **Logs and Cache**: ~100MB
- **Total Recommended**: 5GB free space

### Network Requirements
- **Port Range**: 8080-8090, 3306-3310, 8081-8090
- **Internal Networks**: 172.20.0.0/16 subnet
- **External Access**: Internet for image downloads

## Docker Compose Version Support

### Compose File Version
```yaml
version: '3.8'
```

### Required Features
- Environment variable substitution
- Health checks
- Named volumes
- Custom networks
- Container dependencies

### Compatibility Matrix
| Docker Engine | Compose File Version | Status |
|---------------|---------------------|---------|
| 20.10.0+      | 3.8                | ✅ Recommended |
| 19.03.0+      | 3.7                | ✅ Supported |
| 18.06.0+      | 3.6                | ⚠️ Limited |
| < 18.06.0     | < 3.6              | ❌ Not supported |

## Build Requirements

### Multi-stage Build Support
- Required for optimized images
- Reduces final image size
- Separates build and runtime dependencies

### BuildKit Support
- Enhanced build performance
- Advanced caching mechanisms
- Required for some Dockerfile features

```bash
# Enable BuildKit
export DOCKER_BUILDKIT=1
docker-compose build
```

## Runtime Requirements

### Memory Limits
```yaml
services:
  web:
    deploy:
      resources:
        limits:
          memory: 512M
        reservations:
          memory: 256M
  mysql:
    deploy:
      resources:
        limits:
          memory: 1G
        reservations:
          memory: 512M
```

### Health Check Requirements
- All services must have health checks
- Health check intervals: 10-30 seconds
- Startup grace period: 30-60 seconds
- Retry attempts: 3-5 times

## Security Requirements

### Image Security
- Use official images only
- Regular security updates
- Minimal attack surface
- Non-root user execution

### Network Security
- Internal service communication
- No unnecessary port exposure
- Firewall-friendly configuration
- SSL/TLS ready

### Data Security
- Encrypted volumes (optional)
- Secure secrets management
- Database credential protection
- Log access controls

## Development vs Production

### Development Images
- Larger size (dev tools included)
- More permissive security
- Debug capabilities enabled
- Hot reload support

### Production Images
- Minimal size (production only)
- Hardened security
- Performance optimized
- Multi-stage builds
