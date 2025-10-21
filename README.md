# 🚀 QUOCNHO Team Docker Environment

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-20.10+-blue)](https://docs.docker.com/get-docker/)
[![PHP](https://img.shields.io/badge/PHP-8.1--8.4-purple)](https://www.php.net/)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green)](https://nodejs.org/)
[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue)](https://flutter.dev/)

**Professional multi-technology Docker development environment for modern teams**
*Streamline your development workflow with containerized perfection*

[🌐 Visit Our Website](https://quocnho.com) | [📚 Documentation](./docs/) | [🐛 Report Issues](../../issues) | [💡 Request Features](../../issues/new)

</div>

---

## ⚡ **Development Workflow Made Simple**

### 🚀 **Initial Setup** (One-time, 5 minutes)

```bash
git clone [repo] && cd docker-environment
./scripts/check-requirements.sh    # Auto-installs Docker if needed
./scripts/setup.sh                 # Interactive project setup
```

### 📅 **Monthly Maintenance** (2 minutes)

```bash
docker system prune -f            # Clean unused containers/images
./scripts/check-requirements.sh   # Update system dependencies
```

### 🏃‍♂️ **Daily Development** (10 seconds)

```bash
cd your-project && ./start.sh     # Start your project
# Code, test, commit...
./stop.sh                         # Stop when done
```

**Result**: Multi-technology projects (PHP/Laravel, Flutter, Vue.js) running in isolated containers with zero configuration conflicts! 🎯

---

## 🌟 Why Choose QUOCNHO Docker Environment?Transform your development experience with our **battle-tested, production-ready** Docker environment that supports multiple technology stacks seamlessly. Whether you're building with PHP/Laravel, Flutter mobile apps, or Vue.js PWAs, we've got you covered

### ✨ **Key Features**

🔧 **Multi-Technology Support**

- **PHP** (8.1, 8.2, 8.3, 8.4) with Apache/Nginx
- **Node.js** 18+ for modern JavaScript development
- **Flutter** SDK with Android development tools
- **Vue.js/PWA** with Vite hot-reload support

🐳 **Intelligent Container Management**

- Project-specific isolated environments
- Dynamic container naming prevents conflicts
- Selective service starting (only what you need)
- Automatic dependency management

⚡ **Developer Experience**

- **One-command setup**: `./scripts/setup.sh`
- Interactive project selection menu
- Hot-reload for all supported technologies
- Comprehensive logging and debugging tools

🛡️ **Production-Ready**

- Health checks for all services
- Persistent data volumes
- Environment-specific configurations
- CI/CD ready with GitHub Actions templates

---

## 🚀 Quick Start

### Prerequisites

- **Docker** 20.10+
- **Docker Compose** 2.0+
- **Git** (for cloning)

### Installation

```bash
# Clone the repository
git clone https://github.com/quocnho/docker4fullstack.git
cd docker4fullstack

# Run automated setup (installs Docker if needed)
./scripts/check-requirements.sh

# Create your first project
./scripts/setup.sh
```

**That's it!** 🎉 Your development environment is ready in under 5 minutes.

---

## 🏗️ Supported Project Types

<table>
<tr>
<td align="center">
<img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="120" alt="Laravel">
<br><strong>Laravel</strong>
<br>PHP 8.1-8.4, MySQL, Redis
</td>
<td align="center">
<img src="https://storage.googleapis.com/cms-storage-bucket/ec64036b4eacc9f3fd73.svg" width="120" alt="Flutter">
<br><strong>Flutter</strong>
<br>Mobile & Web, Hot-reload
</td>
<td align="center">
<img src="https://vitejs.dev/logo.svg" width="120" alt="Vue.js">
<br><strong>Vue.js PWA</strong>
<br>Vite, TypeScript, PWA
</td>
</tr>
<tr>
<td align="center">
<img src="https://symfony.com/logos/symfony_black_03.svg" width="120" alt="Symfony">
<br><strong>Symfony</strong>
<br>PHP Framework, Doctrine
</td>
<td align="center">
<img src="https://www.codeigniter.com/assets/images/ci-logo-big.png" width="120" alt="CodeIgniter">
<br><strong>CodeIgniter</strong>
<br>Lightweight PHP, MVC
</td>
<td align="center">
<img src="https://nodejs.org/static/images/logo.svg" width="120" alt="Node.js">
<br><strong>Node.js</strong>
<br>Express, APIs, Microservices
</td>
</tr>
</table>

---

## 📋 What You Get

### 🛠️ **Development Tools**

- **Web Server**: Apache/Nginx with SSL support
- **Database**: MySQL 8.0 with phpMyAdmin
- **Caching**: Redis for session & data caching
- **Debugging**: Xdebug configured for VS Code
- **Process Manager**: PM2 for Node.js applications

### 🔐 **Production Features**

- Environment-specific configurations
- Container health monitoring
- Automated backup scripts
- Security best practices implemented
- Resource usage optimization

### 📊 **Project Management**

- Multi-project support (no port conflicts!)
- Project-specific `.denv` configuration files
- Interactive setup wizard
- One-command start/stop/restart
- Container status monitoring

---

## 🎯 Perfect For

✅ **Development Teams** - Consistent environments across all machines
✅ **Freelancers** - Quick project setup for client work
✅ **Students** - Learn modern development practices
✅ **Agencies** - Manage multiple client projects efficiently
✅ **Startups** - Scale from MVP to production seamlessly

---

## 🏃‍♂️ Usage Examples

### Start a Laravel Project

```bash
# Interactive project setup
./scripts/setup.sh

# Select "Laravel" → Choose PHP 8.3 → MySQL + Redis
# Your project starts at http://localhost:8080
```

### Develop Flutter App

```bash
# Create Flutter project
./scripts/setup.sh

# Select "Flutter" → Enable hot-reload
# Access at http://localhost:5000
```

### Build Vue.js PWA

```bash
# PWA-ready setup
./scripts/setup.sh

# Select "Vue.js PWA" → Vite dev server
# Development at http://localhost:5173
```

---

## 📚 Documentation

- [📖 **Complete Guide**](./docs/README.md) - Detailed setup instructions
- [🔧 **Configuration**](./docs/MULTI_PROJECT_GUIDE.md) - Customize your environment
- [🚀 **Deployment**](./templates/github-actions/) - CI/CD workflow templates
- [❓ **FAQ**](./docs/FAQ.md) - Common questions answered
- [🛠️ **Troubleshooting**](./scripts/check-requirements.sh) - System validation tool

---

## 🌟 Community & Support

<div align="center">

**Love this project? Here's how you can support it:**

### ☕ **Buy Me a Coffee**

*Building and maintaining this Docker environment takes time and effort. Your support helps me continue improving and adding new features!*

[![PayPal](https://img.shields.io/badge/PayPal-Donate-blue?style=for-the-badge&logo=paypal)](https://paypal.me/quocnho)

**Every donation, no matter how small, is greatly appreciated!** 🙏

*Tặng tôi ly cà phê để tiếp tục phát triển những công cụ hữu ích cho cộng đồng developer!*

---

### 🤝 **Other Ways to Support**

- ⭐ **Star this repository** - Show your appreciation
- 🐛 **Report bugs** - Help us improve
- 💡 **Suggest features** - Share your ideas
- 📢 **Share with friends** - Spread the word
- 📝 **Write a review** - Help others discover this project

</div>

---

## 🏆 Why Developers Choose Us

> *"This Docker environment saved our team weeks of setup time. We went from project idea to running code in minutes!"*
> **— Sarah Chen, Lead Developer**

> *"Finally, a Docker setup that actually works out of the box. No more dependency hell!"*
> **— Miguel Rodriguez, Full-Stack Developer**

> *"The multi-project support is a game-changer. We can run 5 different client projects simultaneously without conflicts."*
> **— Alex Thompson, Freelance Developer**

---

## 🛣️ Roadmap

### 🎯 **Coming Soon**

- [ ] **Kubernetes** deployment templates
- [ ] **Python/Django** support
- [ ] **Ruby on Rails** environment
- [ ] **PostgreSQL** database option
- [ ] **Redis Cluster** configuration
- [ ] **Elasticsearch** integration
- [ ] **Monitoring Dashboard** (Grafana + Prometheus)

### 🚀 **Future Plans**

- [ ] **Cloud deployment** automation (AWS, Digital Ocean)
- [ ] **Development VS Code Extension**
- [ ] **Mobile app** for container management
- [ ] **AI-powered** optimization suggestions

---

## 📂 Project Structure

```
QUOCNHO-Docker/
├── 📁 containers/          # Docker definitions
│   ├── docker-compose.yml  # Multi-service orchestration
│   ├── Dockerfile          # PHP/Apache environment
│   └── Dockerfile.flutter  # Flutter development
├── 📁 configs/             # Service configurations
│   ├── php/                # PHP & Xdebug settings
│   ├── mysql/              # Database optimization
│   ├── nginx/              # Web server configs
│   └── redis/              # Cache configuration
├── 📁 scripts/             # Automation tools
│   ├── setup.sh            # Interactive project setup
│   ├── check-requirements.sh # System validation
│   └── container-helper.sh # Container management
├── 📁 templates/           # Project templates
│   ├── laravel/            # Laravel boilerplate
│   ├── flutter/            # Flutter starter
│   ├── vue-pwa/            # Vue.js PWA template
│   └── github-actions/     # CI/CD workflows
└── 📁 docs/                # Documentation
```

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 🙋‍♂️ About the Author

<div align="center">

**Created with ❤️ by QUOCNHO Team**

[![Website](https://img.shields.io/badge/Website-quocnho.com-blue?style=flat-square)](https://quocnho.com)
[![Email](https://img.shields.io/badge/Email-quocnho@gmail.com-red?style=flat-square)](mailto:quocnho@gmail.com)

*Building developer tools that make coding enjoyable again*

---

### 🎯 **Our Mission**

To eliminate the complexity of development environment setup and let developers focus on what they do best: **building amazing applications**.

---

**⭐ If this project helped you, please consider giving it a star! ⭐**

</div>

---

<div align="center">
<sub>Made with 💖 for the developer community</sub>
</div>
