# 🚀 Fukoji Docker - Multi-Project Support

## Giải pháp triển khai Docker đa dự án không xung đột

### 🌟 Tính năng mới

#### ✅ Dynamic Container Naming
- Container names tự động dựa trên tên thư mục dự án
- Ví dụ: `fukoji_web`, `my-restaurant_web`, `another-project_web`
- Không còn xung đột tên container giữa các dự án

#### ✅ Port Conflict Detection
- Tự động phát hiện port đang sử dụng
- Gợi ý port thay thế khi có xung đột
- Auto-fix ports trong file .env

#### ✅ Dynamic Domain System
- Domain tự động: `{project-name}.dev`
- Tự động cấu hình hosts file
- Hỗ trợ nhiều dự án cùng lúc

#### ✅ Isolated Networks & Volumes
- Network riêng biệt cho mỗi dự án
- Volume prefix theo project name
- Hoàn toàn cô lập giữa các dự án

---

## 🛠️ Scripts Mới

### 1. Multi-Project Analysis
```bash
./Server/scripts/multi-project-check.sh
```
- Phân tích toàn diện xung đột multi-project
- Kiểm tra containers, ports, networks, volumes
- Đưa ra khuyến nghị giải quyết

### 2. Port Conflict Management
```bash
# Chỉ kiểm tra
./Server/scripts/check-port-conflicts.sh check

# Tự động sửa xung đột
./Server/scripts/check-port-conflicts.sh auto-fix

# Force update ports
./Server/scripts/check-port-conflicts.sh fix
```

### 3. Container Helper
```bash
# Xem trạng thái containers
./Server/scripts/container-helper.sh status

# Thực thi lệnh trong container
./Server/scripts/container-helper.sh exec web bash
./Server/scripts/container-helper.sh exec mysql mysql -u fukoji -p

# Xem logs
./Server/scripts/container-helper.sh logs web 100

# Xem tên dynamic đang sử dụng
./Server/scripts/container-helper.sh names

# Cleanup project (giữ volumes)
./Server/scripts/container-helper.sh cleanup
```

---

## 🚀 Quy trình triển khai Multi-Project

### Scenario: Chạy đồng thời 3 dự án Fukoji

```bash
# Project 1: fukoji (port 8080, 3306, 8081)
cd /path/to/fukoji
./Server/scripts/setup.sh

# Project 2: restaurant-pos (port 8090, 3307, 8082)
cd /path/to/restaurant-pos
./Server/scripts/setup.sh

# Project 3: food-delivery (port 8100, 3308, 8083)
cd /path/to/food-delivery
./Server/scripts/setup.sh
```

### Hệ thống tự động:
1. **Phát hiện xung đột port** → Auto-increment ports
2. **Tạo container names** → `fukoji_web`, `restaurant-pos_web`, `food-delivery_web`
3. **Cấu hình domains** → `fukoji.dev`, `restaurant-pos.dev`, `food-delivery.dev`
4. **Tạo networks riêng** → `${PROJECT_NAME}_network`, `restaurant-pos_network`, etc.

---

## 🔍 Troubleshooting Multi-Project

### Lỗi thường gặp và giải pháp:

#### 1. Port đã sử dụng
```bash
# Tự động sửa
./Server/scripts/check-port-conflicts.sh auto-fix

# Hoặc manual trong .env
WEB_PORT=8090
DB_PORT=3307
PMA_PORT=8082
```

#### 2. Container name conflict
```bash
# Kiểm tra dynamic naming
./Server/scripts/container-helper.sh names

# Cleanup containers cũ
./Server/scripts/container-helper.sh cleanup force
```

#### 3. Network subnet conflict
```bash
# Xem networks hiện tại
docker network ls | grep fukoji

# Multi-project analysis
./Server/scripts/multi-project-check.sh
```

#### 4. Volume conflict
- Volumes tự động prefix theo project name
- `fukoji_mysql_data`, `restaurant-pos_mysql_data`
- Không xung đột giữa các dự án

---

## 📊 Monitoring Multi-Project

### Dashboard tổng quan:
```bash
# Xem tất cả projects đang chạy
./Server/scripts/multi-project-check.sh

# Status từng project
cd /path/to/project && ./Server/scripts/container-helper.sh status

# Port summary
netstat -tulpn | grep -E ':(808[0-9]|330[6-9]|808[1-9])'
```

### Log aggregation:
```bash
# Logs project hiện tại
./Server/scripts/container-helper.sh logs web 50

# Logs tất cả web containers
docker logs fukoji_web --tail 20
docker logs restaurant-pos_web --tail 20
docker logs food-delivery_web --tail 20
```

---

## 🎯 Best Practices

### 1. Naming Convention
- Project folder name = Domain name = Container prefix
- Sử dụng lowercase, dashes thay spaces
- Ví dụ: `my-restaurant` → `my-restaurant.dev` → `my-restaurant_web`

### 2. Port Management
- Để hệ thống auto-assign ports
- Backup .env trước khi thay đổi
- Sử dụng port ranges: 8080-8089, 3306-3315, 8081-8090

### 3. Resource Management
- Monitor disk usage: `docker system df`
- Cleanup unused volumes: `docker volume prune`
- Regular health checks: `./Server/scripts/multi-project-check.sh`

### 4. Development Workflow
```bash
# Start new project
git clone project && cd project
./Server/scripts/setup.sh    # Auto-resolves conflicts

# Daily development
./Server/scripts/start.sh     # Uses existing config
./Server/scripts/stop.sh      # Clean shutdown

# Troubleshooting
./Server/scripts/multi-project-check.sh
./Server/scripts/container-helper.sh status
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
# Server/docker/docker-compose.override.yml
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
# Update .env
DOMAIN=my-custom.local
```

---

## 🤝 Contributing

Khi phát triển tính năng multi-project:

1. Test với ít nhất 2 projects đồng thời
2. Đảm bảo cleanup scripts hoạt động
3. Update documentation cho features mới
4. Test trên different OS (Linux, macOS, Windows)

---

## 📞 Support

Nếu gặp vấn đề với multi-project deployment:

1. Chạy diagnostic: `./Server/scripts/multi-project-check.sh`
2. Kiểm tra ports: `./Server/scripts/check-port-conflicts.sh check`
3. Xem container status: `./Server/scripts/container-helper.sh status`
4. Cleanup và restart: `./Server/scripts/container-helper.sh cleanup && ./Server/scripts/setup.sh`

**🎉 Bây giờ bạn có thể chạy unlimited Fukoji projects đồng thời mà không lo xung đột!**
