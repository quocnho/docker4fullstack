# {PROJECT_NAME} - Laravel Application

QUOCNHO Team Laravel project created on {DATE}.

## 🚀 Quick Start

### Start Development Environment
```bash
./start.sh
```

### Stop Development Environment
```bash
./stop.sh
```

### Container Management
```bash
# Check status
./container-helper.sh status

# Enter web container
./container-helper.sh exec web bash

# View logs
./container-helper.sh logs web
```

## 🛠️ Development Setup

### Initial Setup
1. Install dependencies:
   ```bash
   ./container-helper.sh exec web composer install
   ```

2. Set up environment:
   ```bash
   ./container-helper.sh exec web cp .env.example .env
   ./container-helper.sh exec web php artisan key:generate
   ```

3. Run migrations:
   ```bash
   ./container-helper.sh exec web php artisan migrate
   ```

### Laravel Commands
```bash
# Create controller
./container-helper.sh exec web php artisan make:controller UserController

# Create model
./container-helper.sh exec web php artisan make:model User -m

# Run tests
./container-helper.sh exec web php artisan test

# Clear cache
./container-helper.sh exec web php artisan cache:clear
./container-helper.sh exec web php artisan config:clear
```

## 📊 Access Information

- **Web Application**: http://localhost:{WEB_PORT}
- **phpMyAdmin**: http://localhost:{PMA_PORT}
- **Database**: localhost:{DB_PORT}

## 🗄️ Database Information

- **Host**: localhost:{DB_PORT} (from host) or mysql (from container)
- **Database**: {DB_NAME}
- **Username**: {DB_USER}
- **Password**: {DB_PASS}

## 🔧 Configuration

Project configuration is stored in `.denv` file. Key settings:

- **PHP Version**: {PHP_VERSION}
- **Technology Stack**: Laravel
- **Containers**: {CONTAINERS}

## 📚 Documentation

- [Laravel Documentation](https://laravel.com/docs)
- [QUOCNHO Team Standards](../../Docker/docs/)

## 🤝 Contributing

1. Follow Laravel coding standards
2. Write tests for new features
3. Update documentation
4. Use conventional commits

## 📞 Support

For issues related to:
- **Docker setup**: Check `../../Docker/README.md`
- **Project specific**: Create issue in project repository
- **Team standards**: Contact QUOCNHO team lead
