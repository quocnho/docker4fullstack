# 🚀 Docker for FullStack Environment - Multi-Project Support

## Conflict-free multi-project Docker deployment solution

### 🌟 New Features

#### ✅ Dynamic Container Naming

- Automatic container names based on project directory name
- Example: `myproject_web`, `restaurant-pos_web`, `another-project_web`
- No more container name conflicts between projects

#### ✅ Port Conflict Detection

- Automatically detects ports in use
- Suggests alternative ports when conflicts occur
- Auto-fix ports in .denv files

#### ✅ Dynamic Domain System

- Automatic domains: `{project-name}.dev`
- Automatic hosts file configuration
- Support for multiple projects simultaneously

#### ✅ Isolated Networks & Volumes

- Separate network for each project
- Volume prefix based on project name
- Complete isolation between projects

---

## 🛠️ New Scripts

### 1. Multi-Project Analysis

```bash
./scripts/multi-project-check.sh
```

- Comprehensive multi-project conflict analysis
- Check containers, ports, networks, volumes
- Provide resolution recommendations

### 2. Port Conflict Management

```bash
# Check only
./scripts/check-port-conflicts.sh check

# Auto-fix conflicts
./scripts/check-port-conflicts.sh auto-fix

# Force update ports
./scripts/check-port-conflicts.sh fix
```

### 3. Container Helper

```bash
# View container status
./scripts/container-helper.sh status

# Execute commands in container
./scripts/container-helper.sh exec web bash
./scripts/container-helper.sh exec mysql mysql -u root -p

# View logs
./scripts/container-helper.sh logs web 100

# View dynamic names in use
./scripts/container-helper.sh names

# Cleanup project (preserve volumes)
./scripts/container-helper.sh cleanup
```

---

## 🚀 Multi-Project Deployment Workflow

### Scenario: Running 3 projects simultaneously

```bash
# Project 1: main-app (port 8080, 3306, 8081)
cd /path/to/main-app
./scripts/setup.sh

# Project 2: restaurant-pos (port 8090, 3307, 8082)
cd /path/to/restaurant-pos
./scripts/setup.sh

# Project 3: food-delivery (port 8100, 3308, 8083)
cd /path/to/food-delivery
./scripts/setup.sh
```

### Automatic System

1. **Detect port conflicts** → Auto-increment ports
2. **Create container names** → `main-app_web`, `restaurant-pos_web`, `food-delivery_web`
3. **Configure domains** → `main-app.dev`, `restaurant-pos.dev`, `food-delivery.dev`
4. **Create separate networks** → `main-app_network`, `restaurant-pos_network`, etc.

---

## 🔍 Multi-Project Troubleshooting

### Common issues and solutions

#### 1. Port already in use

```bash
# Auto-fix
./scripts/check-port-conflicts.sh auto-fix

# Or manual in .denv
WEB_PORT=8090
DB_PORT=3307
PMA_PORT=8082
```

#### 2. Container name conflict

```bash
# Check dynamic naming
./scripts/container-helper.sh names

# Cleanup old containers
./scripts/container-helper.sh cleanup force
```

#### 3. Network subnet conflict

```bash
# View current networks
docker network ls | grep docker

# Multi-project analysis
./scripts/multi-project-check.sh
```

#### 4. Volume conflict

- Volumes automatically prefixed by project name
- `main-app_mysql_data`, `restaurant-pos_mysql_data`
- No conflicts between projects

---

## 📊 Multi-Project Monitoring

### Overview Dashboard

```bash
# View all running projects
./scripts/multi-project-check.sh

# Status per project
cd /path/to/project && ./scripts/container-helper.sh status

# Port summary
netstat -tulpn | grep -E ':(808[0-9]|330[6-9]|808[1-9])'
```

### Log Aggregation

```bash
# Current project logs
./scripts/container-helper.sh logs web 50

# All web container logs
docker logs main-app_web --tail 20
docker logs restaurant-pos_web --tail 20
docker logs food-delivery_web --tail 20
```

---

## 🎯 Best Practices

### 1. Naming Convention

- Project folder name = Domain name = Container prefix
- Use lowercase, dashes instead of spaces
- Example: `my-restaurant` → `my-restaurant.dev` → `my-restaurant_web`

### 2. Port Management

- Let the system auto-assign ports
- Backup .denv before changes
- Use port ranges: 8080-8089, 3306-3315, 8081-8090

### 3. Resource Management

- Monitor disk usage: `docker system df`
- Cleanup unused volumes: `docker volume prune`
- Regular health checks: `./scripts/multi-project-check.sh`

### 4. Development Workflow

```bash
# Start new project
git clone project && cd project
./scripts/setup.sh    # Auto-resolves conflicts

# Daily development
./scripts/start.sh     # Uses existing config
./scripts/stop.sh      # Clean shutdown

# Troubleshooting
./scripts/multi-project-check.sh
./scripts/container-helper.sh status
```

---

## 🔮 Advanced Features

### Environment Variables

```bash
# Dynamic configuration
PROJECT_NAME=${PROJECT_NAME}
WEB_PORT=${WEB_PORT:-8080}
DB_PORT=${DB_PORT:-3306}
PMA_PORT=${PMA_PORT:-8081}
DOMAIN=${DOMAIN:-${PROJECT_NAME}.dev}
```

### Docker Compose Override

```yaml
# containers/docker-compose.override.yml
version: '3.8'
services:
  web:
    container_name: ${PROJECT_NAME}_web
    networks:
      - ${PROJECT_NAME}_network
```

### Custom Domains

```bash
# Manual domain setup
echo "127.0.0.1 my-custom.local" >> /etc/hosts
# Update .denv
DOMAIN=my-custom.local
```

---

## 🤝 Contributing

When developing multi-project features:

1. Test with at least 2 projects simultaneously
2. Ensure cleanup scripts work properly
3. Update documentation for new features
4. Test on different OS (Linux, macOS, Windows)

---

## 📞 Support

If you encounter issues with multi-project deployment:

1. Run diagnostic: `./scripts/multi-project-check.sh`
2. Check ports: `./scripts/check-port-conflicts.sh check`
3. View container status: `./scripts/container-helper.sh status`
4. Cleanup and restart: `./scripts/container-helper.sh cleanup && ./scripts/setup.sh`

**🎉 Now you can run unlimited Docker for FullStack projects simultaneously without worrying about conflicts!**
