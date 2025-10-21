# System Requirements for Fukoji Project

## Minimum Requirements

### Operating System
- **Linux**: Ubuntu 20.04 LTS or later, CentOS 8 or later
- **macOS**: macOS 10.15 (Catalina) or later
- **Windows**: Windows 10 Pro/Enterprise with WSL2

### Hardware
- **CPU**: 2 cores minimum, 4 cores recommended
- **RAM**: 4GB minimum, 8GB recommended
- **Storage**: 20GB free space minimum, 50GB recommended
- **Network**: Stable internet connection for Docker image downloads

## Required Software

### Docker
- **Docker Engine**: 20.10.0 or later
- **Docker Compose**: 2.0.0 or later (or docker-compose 1.29.0)
- **Docker Desktop**: Latest version (for Windows/macOS)

### Git
- **Git**: 2.20.0 or later
- SSH key configured for repository access

### Text Editor/IDE
- **VS Code**: Latest version (recommended)
- **PHP Extensions**: PHP Intelephense, Docker extension
- **Alternative**: PhpStorm, Sublime Text, Vim

## Optional Tools

### Development Tools
- **Node.js**: 16.0.0 or later (for frontend assets)
- **Composer**: 2.0.0 or later (if developing outside container)
- **PHP**: 8.1 or later (for local development)

### Database Tools
- **MySQL Workbench**: For database management
- **phpMyAdmin**: Included in Docker setup
- **DBeaver**: Universal database tool

### System Monitoring
- **htop**: System monitoring
- **docker stats**: Container resource monitoring
- **netstat**: Network monitoring

## Verification Commands

```bash
# Check Docker
docker --version
docker-compose --version

# Check Git
git --version

# Check system resources
free -h
df -h
lscpu
```

## Installation Scripts

### Ubuntu/Debian
```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### CentOS/RHEL
```bash
# Install Docker
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
```

### macOS
```bash
# Install Docker Desktop
# Download from https://docs.docker.com/desktop/mac/install/

# Install via Homebrew
brew install --cask docker
```

### Windows
```powershell
# Install Docker Desktop
# Download from https://docs.docker.com/desktop/windows/install/

# Install via Chocolatey
choco install docker-desktop
```
