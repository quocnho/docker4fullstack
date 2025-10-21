## Quick context

This repo contains a standardized Docker-based development environment for the QUOCNHO team's multi-technology projects (PHP/Laravel/CodeIgniter/Symfony, Flutter, Vue.js/PWA, Node.js). It provides reusable Docker Compose definitions, configuration templates and automation scripts to ensure consistent team development environments across all machines. The stack is modular and supports: PHP (multiple versions), Node.js, MySQL, Redis, nginx, Flutter development tools, and PWA build tools.

Key directories and files you should read before editing code:

- `containers/` — docker compose files and container definitions (renamed from `docker/`)
- `configs/` — technology-specific configs (`php/`, `nodejs/`, `flutter/`, `mysql/`, `nginx/`, `redis/`)
- `scripts/` — automation and developer commands (`setup.sh`, `start.sh`, `stop.sh`, `container-helper.sh`)
- `templates/` — project templates for different tech stacks
- `.denv` files — project-specific environment configurations stored in each project directory
- `README.md` — high-level project purpose and usage examples

## Big picture (how things fit together)

- **Multi-technology support**: Modular container system supporting PHP (8.1-8.4), Node.js, Flutter, Vue.js/PWA development with selective container installation based on project needs.
- **Project-centric workflow**: Each project in `../Projects/` directory has its own `.denv` file storing container selections, PHP version, ports, and environment variables.
- **Interactive setup**: `setup.sh` provides project selection menu (existing projects or create new), technology stack selection, and automatic `.denv` generation/reading.
- **Team consistency**: Standardized container definitions in `containers/` with technology-specific configurations, ensuring identical development environments across QUOCNHO team members.
- **Agile/Scrum integration**: Built-in support for GitHub Actions CI/CD workflows and deployment configurations for VPS/hosting environments.
- **Dynamic naming**: Container/network/volume names use `${PROJECT_NAME}` from `.denv` to allow multiple team projects running simultaneously without conflicts.

## Developer workflows (concrete commands & examples)

- **Team member onboarding**: `./scripts/check-requirements.sh` — validates Docker, Node.js, Flutter SDK, installs missing tools automatically
- **Project setup**: `./scripts/setup.sh` — interactive menu to:
  - List existing projects in `../Projects/` (numbered selection)
  - Create new project (option 0): prompts for name, creates directory and `.denv`
  - Select technology stack: PHP version (8.1, 8.2, 8.3, 8.4), containers (web, mysql, redis, nodejs, flutter, nginx)
  - Read existing `.denv` or create new based on selections
- **Daily development**:
  - Start project: `./scripts/start.sh` (reads `.denv` from current project)
  - Stop: `./scripts/stop.sh`
  - Switch projects: `cd ../Projects/<project-name> && ../../Docker/scripts/start.sh`
- **Container management**:
  - Status: `./scripts/container-helper.sh status`
  - Enter containers: `./scripts/container-helper.sh exec web bash`, `exec nodejs npm install`, `exec flutter flutter doctor`
  - Logs: `./scripts/container-helper.sh logs <service> 100`
- **Deployment workflows**:

  - GitHub Actions setup: templates in `templates/github-actions/`
  - VPS deployment configurations in project `.denv`## Patterns & conventions an AI should follow

- **Project-centric configuration**: Each project in `../Projects/<project-name>/` has a `.denv` file containing `PROJECT_NAME`, `CONTAINERS`, `PHP_VERSION`, ports, and environment variables.
- **Dynamic naming**: All container, network and volume names use `${PROJECT_NAME}` from `.denv`. Always reference via `container-helper.sh` helpers, never hardcode names.
- **Modular containers**: Only selected containers from `.denv` CONTAINERS list are started. Support containers: `web`, `mysql`, `redis`, `nodejs`, `flutter`, `nginx`, `phpmyadmin`.
- **Technology detection**: Scripts should detect project type from files (composer.json → PHP, pubspec.yaml → Flutter, package.json → Node.js/Vue) and suggest appropriate containers.
- **Preserve data**: Volume cleanup preserves data by default. Database imports only during setup, not on normal start.
- **Environment isolation**: `.denv` files are project-specific and never committed to project repos, only stored locally in project directories.

## Integration points & external dependencies

- **Docker ecosystem**: Docker and Docker Compose (auto-detects `docker-compose` binary or `docker compose` plugin).
- **Development tools**: Node.js (for Vue/PWA builds), Flutter SDK (for mobile dev), Git (version control), PHP Composer (for PHP projects).
- **Host tools used by scripts**: `lsof`, `jq`, `curl`, `git`. The `check-requirements.sh` can auto-install missing tools.
- **IDE integration**: Xdebug configured in `configs/php/xdebug.ini` (port 9003, IDE key VSCODE). Flutter debug support via IDE extensions.
- **CI/CD integration**: GitHub Actions templates for automated testing and VPS deployment workflows.
- **Scrum/Agile tools**: Integration points for GitHub Issues, Projects, and Actions for team collaboration.

## Examples an AI can use in edits

- **Adding new technology containers**: When adding services (Redis, Elasticsearch), mirror how existing services are declared in `containers/docker-compose.yml` (healthcheck, network, volumes) and add to `scripts/container-helper.sh` service lists.
- **Project `.denv` example**:
  ```bash
  PROJECT_NAME=restaurant-pos
  CONTAINERS=web,mysql,redis,nodejs
  PHP_VERSION=8.3
  WEB_PORT=8080
  DB_PORT=3306
  REDIS_PORT=6379
  NODE_PORT=3000
  ```
- **Technology stack templates**: Create project templates in `templates/` directory for quick project initialization (Laravel starter, Flutter starter, Vue PWA starter).
- **GitHub Actions workflow**: Template CI/CD workflows for different tech stacks with automated testing and VPS deployment.## Safety checks before making changes

- **Multi-technology validation**: Run `./scripts/check-requirements.sh` to verify Docker, Node.js, Flutter SDK, and other required tools.
- **Project structure verification**: Ensure `../Projects/` directory structure is intact and `.denv` files are properly formatted.
- **Container compatibility**: Test new containers with different technology combinations (PHP+MySQL+Redis, Flutter+Node.js, etc.).
- **Port conflict prevention**: Use `./scripts/check-port-conflicts.sh` to prevent conflicts between multiple projects running simultaneously.
- **Template validation**: Verify project templates in `templates/` work with the interactive setup process.

If anything in this file is unclear or you want me to include additional examples (for example exact env snippets, or a short checklist for editing `docker-compose.yml`), tell me which area to expand and I'll update the file.
