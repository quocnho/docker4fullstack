# Laravel Project Template - Docker for FullStack

This directory contains a template for Laravel projects.

## Auto-Generated Files

When you create a new Laravel project, the following files will be automatically created:

### Project Structure
```
your-project-name/
├── .denv                    # Project configuration
├── start.sh                 # Start containers
├── stop.sh                  # Stop containers
├── restart.sh               # Restart containers
├── container-helper.sh      # Container management
├── README.md                # Project documentation
├── .env.example             # Laravel environment template
└── docker-compose.override.yml # Optional overrides
```

### Laravel-Specific Configuration

The template includes:
- Laravel-optimized .denv settings
- Proper volume mounts for storage and cache
- Artisan command helpers
- Database seeding scripts
- Queue worker configuration

### Getting Started

After project creation:
1. Run `composer install` inside the web container
2. Copy `.env.example` to `.env` and configure
3. Generate application key: `php artisan key:generate`
4. Run migrations: `php artisan migrate`
5. Start development: `php artisan serve` (or use the web container)

### Container Access

```bash
# Enter web container
./container-helper.sh exec web bash

# Run Artisan commands
./container-helper.sh exec web php artisan migrate
./container-helper.sh exec web php artisan make:controller UserController

# View logs
./container-helper.sh logs web
```
