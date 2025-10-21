# 🚀 Docker for FullStack Environment

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-20.10+-blue)](https://docs.docker.com/get-docker/)
[![PHP](https://img.shields.io/badge/PHP-8.1--8.4-purple)](https://www.php.net/)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green)](https://nodejs.org/)
[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue)](https://flutter.dev/)

**Professional multi-technology Docker development environment**
*Streamline your development workflow with containerized perfection*

[📚 Documentation](./docs/README.md) | [🚀 Quick Start](#-quick-start) | [🐛 Report Issues](../../issues) | [💡 Features](#-features)

</div>

---

## ⚡ **Quick Start**

Get your development environment running in 3 simple steps:

```bash
# 1. Clone the repository
git clone https://github.com/quocnho/docker4fullstack.git
cd docker4fullstack

# 2. Run the interactive setup
./scripts/setup.sh

# 3. Start your development environment
./scripts/start.sh
```

**That's it!** Your containerized development environment is ready! 🎉

---

## ✨ **Features**

### 🔧 **Multi-Technology Support**

- **PHP** (8.1-8.4) with Laravel, CodeIgniter, Symfony
- **Node.js** 18+ for Vue.js, React, Angular development
- **Flutter** for cross-platform mobile development
- **Database** MySQL 8.0 + Redis caching
- **Web Server** Apache/Nginx with SSL support

### 🚀 **Professional Deployment**

- **GitHub Actions** integration for VPS deployment
- **Automatic backups** before each deployment
- **Zero-downtime** deployments with health checks
- **Virtualmin** compatible directory structure
- **SSL certificates** automatic management

### 👥 **Team Collaboration**

- **Interactive setup** with technology selection
- **Project isolation** - multiple projects simultaneously
- **Consistent environments** across all team members
- **Hot reload** and live debugging capabilities
- **Easy project switching** and management

### 🛠️ **Developer Experience**

- **VS Code** integration with Xdebug ready
- **Port conflict prevention** automatic detection
- **Requirements checking** automatic validation
- **One-command** start/stop/restart operations
- **Comprehensive logging** and monitoring

---

## 🎯 **Use Cases**

Perfect for:

- 🏢 **Development Agencies** - Multiple client projects with different tech stacks
- 👥 **Team Development** - Consistent environments across team members
- 🚀 **Rapid Prototyping** - Quick project setup with pre-configured templates
- 📱 **Full-Stack Development** - Backend, frontend, and mobile in one environment
- 🌐 **Production Deployment** - Professional VPS deployment workflows

---

## 🛠️ **Technology Stack**

| Technology | Version | Purpose |
|------------|---------|---------|
| **Docker** | 20.10+ | Containerization platform |
| **PHP** | 8.1-8.4 | Backend development |
| **Node.js** | 18+ | Frontend development |
| **Flutter** | 3.0+ | Mobile development |
| **MySQL** | 8.0 | Primary database |
| **Redis** | Latest | Caching and sessions |
| **Apache/Nginx** | Latest | Web server |

---

## 📊 **Project Structure**

```
Docker4FullStack/
├── 📁 containers/              # Docker configurations
│   ├── docker-compose.yml     # Multi-service orchestration
│   ├── Dockerfile              # PHP/Apache environment
│   └── Dockerfile.flutter      # Flutter development
├── 📁 configs/                 # Service configurations
│   ├── php/                    # PHP & Xdebug settings
│   ├── nodejs/                 # Node.js configuration
│   ├── flutter/                # Flutter development setup
│   └── nginx/                  # Web server configuration
├── 📁 scripts/                 # Management scripts
│   ├── setup.sh                # Interactive project setup
│   ├── start.sh                # Start development environment
│   ├── stop.sh                 # Stop all containers
│   └── container-helper.sh     # Container utilities
├── 📁 templates/               # Project templates
│   ├── laravel/                # Laravel starter template
│   ├── vue-pwa/                # Vue.js PWA template
│   ├── flutter/                # Flutter app template
│   └── github-actions/         # VPS deployment workflows
└── 📁 docs/                    # Comprehensive documentation
    ├── README.md               # Detailed documentation
    ├── DEPLOYMENT_GUIDE.md     # VPS deployment guide
    └── MULTI_PROJECT_GUIDE.md  # Multi-project management
```

---

## 🚀 **Development Workflow**

### 1. **Project Setup**

```bash
# Interactive menu for project selection
./scripts/setup.sh

# Choose from existing projects or create new
# Select technology stack (PHP, Node.js, Flutter)
# Configure GitHub Actions for VPS deployment
```

### 2. **Daily Development**

```bash
# Start your development environment
./scripts/start.sh

# Your applications are available at:
# - Main app: http://project-name.dev
# - phpMyAdmin: http://localhost:8081
# - Node.js app: http://localhost:3000
```

### 3. **Container Management**

```bash
# Check container status
./scripts/container-helper.sh status

# Enter containers for debugging
./scripts/container-helper.sh exec web bash
./scripts/container-helper.sh exec nodejs npm install

# View logs
./scripts/container-helper.sh logs web 50
```

### 4. **Deployment**

```bash
# Push to main branch triggers automatic deployment
git push origin main

# GitHub Actions handles:
# ✅ Testing and building
# ✅ VPS deployment with backup
# ✅ Health checks and verification
```

---

## 🎯 **Benefits**

### ✅ **For Developers**

- **Zero setup time** - Works instantly on any machine
- **No conflicts** - Isolated environments for each project
- **Professional tools** - Xdebug, hot reload, live debugging
- **Multi-technology** - PHP, Node.js, Flutter in one environment

### ✅ **For Teams**

- **Consistency** - Identical environments for all team members
- **Collaboration** - Easy project sharing and onboarding
- **Standards** - Enforced coding standards and best practices
- **Scalability** - Support for multiple simultaneous projects

### ✅ **For Production**

- **Automated deployment** - GitHub Actions VPS integration
- **Safety** - Automatic backups and health checks
- **Performance** - Optimized container configurations
- **Monitoring** - Comprehensive logging and error tracking

---

## 🔧 **Requirements**

- **Docker** 20.10 or higher
- **Docker Compose** 2.0 or higher
- **Git** for version control
- **4GB RAM** minimum (8GB recommended)
- **10GB** free disk space

**Automatic validation:** Run `./scripts/check-requirements.sh` to verify your system.

---

## 📚 **Documentation**

- 📖 **[Complete Documentation](./docs/README.md)** - Comprehensive guide
- 🚀 **[Deployment Guide](./docs/DEPLOYMENT_GUIDE.md)** - VPS deployment
- 🔀 **[Multi-Project Guide](./docs/MULTI_PROJECT_GUIDE.md)** - Managing multiple projects
- ⚙️ **[Configuration Guide](./configs/README.md)** - Customization options

---

## 🤝 **Contributing**

We welcome contributions from the community! Please see our [Contributing Guide](./CONTRIBUTING.md) for details.

### 📋 **How to Contribute**

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🌟 **Support the Project**

If this project helps you and your team, please consider giving it a ⭐ on GitHub!

*Building and maintaining this Docker environment takes time and effort. Community support helps continue improving and adding new features!*

[![PayPal](https://img.shields.io/badge/PayPal-Donate-blue?style=for-the-badge&logo=paypal)](https://paypal.me/quocnho)
[![GitHub Sponsors](https://img.shields.io/badge/GitHub-Sponsors-red?style=for-the-badge&logo=github)](https://github.com/sponsors)

**Every contribution, no matter how small, is greatly appreciated!** 🙏

*Tặng tôi ly cà phê để tiếp tục phát triển những công cụ hữu ích cho cộng đồng developer!* ☕

---

## 🙋‍♂️ **About the Project**

<div align="center">

**Created with ❤️ by the Docker for FullStack Community**

[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?style=flat-square&logo=github)](https://github.com/docker4fullstack)
[![Contributions](https://img.shields.io/badge/Contributions-Welcome-green?style=flat-square)](./CONTRIBUTING.md)

*Building developer tools that make coding enjoyable again*

</div>

---

**Ready to revolutionize your development workflow?** Get started now! 🚀

```bash
git clone https://github.com/quocnho/docker4fullstack.git && cd docker4fullstack && ./scripts/setup.sh
```
