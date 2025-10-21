# 🐳 Server - Cấu Hình Docker

Thư mục này chứa tất cả cấu hình Docker đã được tách biệt khỏi source code chính.

## 📁 Cấu Trúc

```
Server/
├── docker/                     # Cấu hình Docker
│   ├── Dockerfile              # Dockerfile chính
│   ├── docker-compose.yml      # Production compose (không auto-import DB)
│   ├── docker-compose.setup.yml # Setup compose (có auto-import DB)
│   ├── .env.example            # Template environment
│   ├── entrypoint.sh           # Script khởi động container
│   └── mysql/                  # Database initialization
│       ├── fukoji.sql          # Database schema & data
│       └── init.sql            # Additional init scripts
└── scripts/                    # Management scripts
    ├── setup.sh                # Setup lần đầu
    ├── start.sh                # Khởi động hằng ngày
    ├── stop.sh                 # Dừng containers
    ├── restart.sh              # Restart containers
    └── logs.sh                 # Xem logs
```

## 🚀 Sử Dụng

### Từ Root Project:
```bash
# Interactive menu
./docker.sh

# Hoặc chạy trực tiếp
./Server/scripts/setup.sh      # Lần đầu
./Server/scripts/start.sh      # Khởi động
./Server/scripts/stop.sh       # Dừng
```

## 🔧 Sự Khác Biệt Giữa Các Files

| File | Mục đích | Auto-import DB |
|------|----------|----------------|
| `docker-compose.setup.yml` | Setup ban đầu | ✅ Có |
| `docker-compose.yml` | Production daily | ❌ Không |

## 🌐 Environment

Copy và chỉnh sửa file environment:
```bash
cp Server/docker/.env.example Server/docker/.env
```

## 🏠 Local Domain

Hệ thống tự động tạo domain local từ **tên thư mục project + .dev**

- **URL chính**: http://[project-name].dev (ví dụ: fukoji.dev)
- **phpMyAdmin**: http://localhost:8081
- **Port**: 80 (HTTP default)

Script setup sẽ tự động:
- Tạo domain từ tên thư mục
- Thêm domain vào `/etc/hosts`
- Generate file .env với domain phù hợp## 💡 Lợi Ích Của Cấu Trúc Này

1. **Tách biệt cấu hình** - Docker config tách khỏi source code
2. **Dễ backup** - Chỉ cần backup thư mục Server
3. **Dễ maintain** - Tất cả Docker scripts ở một chỗ
4. **Portable** - Có thể copy Server folder sang project khác
5. **Clean root** - Root project không bị lộn xộn với Docker files

## 🎯 Migration Từ Config Cũ

Files cũ trong root đã được di chuyển:
- `docker-compose.optimized.yml` → `Server/docker/docker-compose.setup.yml`
- `docker-compose.simple.yml` → `Server/docker/docker-compose.yml`
- `Dockerfile.optimized` → `Server/docker/Dockerfile`
- `setup-docker.sh` → `Server/scripts/setup.sh`
- `start-docker.sh` → `Server/scripts/start.sh`
- `stop-docker.sh` → `Server/scripts/stop.sh`
