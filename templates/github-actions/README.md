# GitHub Actions Templates for VPS Deployment with Virtualmin

This directory contains GitHub Actions workflow templates for deploying different technology stacks to VPS servers with Virtualmin control panel.

## 🚀 Available Templates

### 1. General VPS Deployment (`vps-deployment.yml`)
- **Use for**: Static websites, HTML/CSS/JS projects
- **Features**: Basic file sync, backup, and permissions setup
- **Best for**: Simple static sites, documentation sites

### 2. Laravel VPS Deployment (`laravel-vps.yml`)
- **Use for**: Laravel PHP applications
- **Features**:
  - Composer dependency installation
  - PHPUnit testing
  - Database migrations
  - Laravel optimization (config, route, view caching)
  - Proper Laravel directory structure for Virtualmin
- **Best for**: Laravel web applications, APIs

### 3. CodeIgniter VPS Deployment (`codeigniter-vps.yml`)
- **Use for**: CodeIgniter PHP applications (CI3 & CI4)
- **Features**:
  - Automatic CI3/CI4 detection
  - Composer dependency management
  - Database configuration
  - Environment setup (.env for CI4)
  - Proper file permissions and security
- **Best for**: CodeIgniter web applications, legacy PHP projects

### 4. Vue.js PWA VPS Deployment (`vue-vps.yml`)
- **Use for**: Vue.js Progressive Web Apps
- **Features**:
  - npm build process
  - PWA optimization
  - Service Worker support
  - SPA routing configuration
  - Performance auditing
- **Best for**: Vue.js SPAs, PWAs, frontend applications

### 5. Flutter Web VPS Deployment (`flutter-web-vps.yml`)
- **Use for**: Flutter web applications
- **Features**:
  - Flutter web build
  - Flutter testing
  - CanvasKit support
  - Optimized caching headers
  - Performance monitoring
- **Best for**: Flutter web apps, cross-platform applications

## 🛠️ Setup Instructions

### 1. Choose Your Template
Copy the appropriate `.yml` file to your project's `.github/workflows/` directory.

### 2. Configure Repository Secrets
In your GitHub repository, go to **Settings > Secrets and variables > Actions** and add:

#### Required Secrets (All Templates)

```bash
VPS_SSH_KEY     # Private SSH key for VPS access
VPS_HOST        # VPS IP address or hostname
VPS_USER        # VPS username (usually same as domain)
DOMAIN_NAME     # Domain name (will be used as directory: /home/{DOMAIN_NAME}/public_html)
```

#### Laravel Specific Secrets:

```bash
DB_HOST         # Database host (usually localhost)
DB_DATABASE     # Database name
DB_USERNAME     # Database username
DB_PASSWORD     # Database password
APP_KEY         # Laravel application key
APP_URL         # Full application URL (https://example.com)
```

#### CodeIgniter Specific Secrets:

```bash
DB_HOST         # Database host (usually localhost)
DB_DATABASE     # Database name
DB_USERNAME     # Database username
DB_PASSWORD     # Database password
APP_URL         # Application base URL (https://example.com)
```
APP_URL         # Full application URL (https://example.com)
```

### 3. VPS Directory Structure

Your VPS should have this structure (automatically created by Virtualmin):

```bash
/home/{DOMAIN_NAME}/
├── public_html/          # Web root (where files are served)
├── backups/              # Deployment backups (auto-created)
└── laravel-app/          # Laravel app (Laravel only)
```

**Example for domain "example.com":**

```bash
/home/example.com/
├── public_html/          # Accessible via https://example.com
├── backups/              # Auto-generated backups
└── laravel-app/          # Laravel source (if using Laravel)
```

### 4. SSH Key Setup

#### Generate SSH Key Pair:
```bash
ssh-keygen -t rsa -b 4096 -C "github-actions@yourdomain.com"
```

#### Add Public Key to VPS:
```bash
# On your VPS, add the public key to authorized_keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

#### Add Private Key to GitHub Secrets:
Copy the private key content to `VPS_SSH_KEY` secret.

## 🔧 Customization

### Modify Deployment Paths

Edit the `DOMAIN_NAME` in your workflow or secrets to match your VPS setup:

```yaml
env:
  DOMAIN_NAME: example.com  # Will deploy to /home/example.com/public_html
```

### Add Environment Variables
For applications needing environment variables, modify the deployment script:
```yaml
- name: Create environment file
  run: |
    ssh $VPS_USER@$VPS_HOST "
      cd $VPS_PATH/public_html
      cat > .env << 'ENV'
      APP_ENV=production
      API_URL=https://api.yourdomain.com
      ENV
    "
```

### Custom Post-Deployment Tasks
Add custom tasks after deployment:
```yaml
- name: Custom post-deployment
  run: |
    ssh $VPS_USER@$VPS_HOST "
      cd $VPS_PATH/public_html
      # Your custom commands here
      php artisan queue:restart  # Laravel example
      npm run build:prod        # Build assets
    "
```

## 📋 Deployment Process

### 1. Trigger Events
Deployments trigger on:
- Push to `main` branch
- Merged pull requests to `main`

### 2. Deployment Steps
1. **Backup**: Create timestamped backup of current deployment
2. **Sync**: Upload new files via rsync
3. **Configure**: Set up environment and configuration files
4. **Optimize**: Run framework-specific optimizations
5. **Verify**: Test deployment accessibility
6. **Cleanup**: Set proper permissions and clean old backups

### 3. Backup Management
- Automatic backups before each deployment
- Keeps last 5 backups
- Stored in `{VPS_PATH}/backups/`

## 🔍 Troubleshooting

### Common Issues

#### SSH Connection Failed
```
Permission denied (publickey)
```
**Solution**: Verify SSH key is correctly added to VPS and GitHub secrets.

#### File Permissions
```
403 Forbidden
```
**Solution**: Check file ownership and permissions:
```bash
chown -R username:username /home/username/domains/example.com/public_html
chmod -R 755 /home/username/domains/example.com/public_html
```

#### Laravel 500 Error
```
Internal Server Error
```
**Solution**: Check Laravel logs and ensure:
- `.env` file is properly configured
- `storage` and `bootstrap/cache` are writable
- Database connection is working

#### Vue.js/Flutter Routing Issues
```
404 on refresh
```
**Solution**: Ensure `.htaccess` is properly configured for SPA routing.

### Debug Mode
To enable debug output, add to your workflow:
```yaml
- name: Debug deployment
  run: |
    ssh $VPS_USER@$VPS_HOST "
      cd $VPS_PATH/public_html
      ls -la
      pwd
      whoami
    "
```

## 🚨 Security Best Practices

1. **Use Strong SSH Keys**: 4096-bit RSA minimum
2. **Limit SSH Access**: Configure firewall rules
3. **Regular Updates**: Keep VPS and applications updated
4. **Backup Verification**: Test backup restoration
5. **Monitor Logs**: Check deployment and application logs
6. **Environment Variables**: Never commit secrets to repository

## 📝 Examples

### Basic HTML/CSS Site
Use `vps-deployment.yml` - just sync files and set permissions.

### Laravel API
Use `laravel-vps.yml` - includes database setup, migrations, and caching.

### CodeIgniter Application
Use `codeigniter-vps.yml` - supports both CI3 and CI4 with automatic detection.

### Vue.js SPA
Use `vue-vps.yml` - builds production assets and configures SPA routing.

### Flutter Web App
Use `flutter-web-vps.yml` - optimizes for Flutter web performance.

## 🤝 Contributing

To add new deployment templates:
1. Create new `.yml` file following existing patterns
2. Add comprehensive documentation
3. Include error handling and verification steps
4. Test with real VPS deployment

## 📞 Support

For issues specific to:
- **Virtualmin**: Check Virtualmin documentation
- **GitHub Actions**: Check GitHub Actions documentation
- **SSH/VPS**: Verify server configuration and access
- **Framework**: Check Laravel/Vue.js/Flutter documentation
