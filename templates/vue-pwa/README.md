# Vue.js/PWA Project Template - Docker for FullStack

This directory contains a template for Vue.js and Progressive Web App projects.

## Auto-Generated Files

When you create a new Vue.js/PWA project, the following files will be automatically created:

### Project Structure
```
your-project-name/
├── .denv                    # Project configuration
├── start.sh                 # Start containers
├── stop.sh                  # Stop containers
├── restart.sh               # Restart containers
├── container-helper.sh      # Container management
├── README.md                # Project documentation
├── package.json             # Node.js dependencies
├── vite.config.js           # Vite configuration
├── pwa-manifest.json        # PWA configuration
└── docker-compose.override.yml # Optional overrides
```

### Vue.js/PWA-Specific Configuration

The template includes:
- Vue 3 with Composition API
- Vite for fast development and building
- PWA plugin for offline capabilities
- Hot module replacement (HMR)
- TypeScript support (optional)
- Tailwind CSS (optional)

### Getting Started

After project creation:
1. Install dependencies: `npm install` or `yarn install`
2. Start development server: `npm run dev`
3. Build for production: `npm run build`
4. Preview production build: `npm run preview`

### Container Access

```bash
# Enter Node.js container
./container-helper.sh exec nodejs sh

# Run Node.js commands
./container-helper.sh exec nodejs npm install
./container-helper.sh exec nodejs npm run dev
./container-helper.sh exec nodejs npm run build

# View logs
./container-helper.sh logs nodejs
```

### Development Workflow

1. **Development**: Use Vite dev server with HMR
2. **Building**: Production-optimized builds with tree-shaking
3. **PWA**: Service worker for offline functionality
4. **Testing**: Unit tests with Vitest, E2E with Playwright
