# Flutter Project Template - Docker for FullStack

This directory contains a template for Flutter projects.

## Auto-Generated Files

When you create a new Flutter project, the following files will be automatically created:

### Project Structure
```
your-project-name/
├── .denv                    # Project configuration
├── start.sh                 # Start containers
├── stop.sh                  # Stop containers
├── restart.sh               # Restart containers
├── container-helper.sh      # Container management
├── README.md                # Project documentation
├── pubspec.yaml             # Flutter dependencies
└── docker-compose.override.yml # Optional overrides
```

### Flutter-Specific Configuration

The template includes:
- Flutter SDK with web support enabled
- Android SDK for mobile development
- Hot reload configuration
- Web server for Flutter web apps
- Pub cache optimization

### Getting Started

After project creation:
1. Run `flutter pub get` to install dependencies
2. Enable web support: `flutter config --enable-web`
3. Run on web: `flutter run -d web-server --web-port=5000`
4. Build for production: `flutter build web`

### Container Access

```bash
# Enter Flutter container
./container-helper.sh exec flutter bash

# Run Flutter commands
./container-helper.sh exec flutter flutter pub get
./container-helper.sh exec flutter flutter run -d web-server --web-port=5000

# View logs
./container-helper.sh logs flutter
```

### Development Workflow

1. **Web Development**: Use the Flutter web server for development
2. **Mobile Development**: Connect physical device or use emulator
3. **Hot Reload**: Enabled by default for faster development
4. **Testing**: Run `flutter test` for unit tests
