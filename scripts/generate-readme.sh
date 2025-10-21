#!/bin/bash
# Generate dynamic README.md from template
# Author: Auto-generated for project infrastructure

# Change to script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/../.."

# Load domain configuration to get PROJECT_NAME
source Server/scripts/get-domain.sh

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}📝 Generating dynamic README.md for project: ${GREEN}$PROJECT_NAME${NC}"

# Check if template exists
TEMPLATE_FILE="Server/README.template.md"
OUTPUT_FILE="Server/README.md"

if [ -f "$TEMPLATE_FILE" ]; then
    # Replace placeholders in template
    sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$TEMPLATE_FILE" > "$OUTPUT_FILE"
    echo -e "${GREEN}✅ README.md generated successfully from template!${NC}"
else
    echo -e "${BLUE}📝 Template not found, skipping README.md generation${NC}"
fi

if [ -f "$OUTPUT_FILE" ]; then
    echo -e "${BLUE}📍 Location: $OUTPUT_FILE${NC}"
    echo -e "${BLUE}🔧 Project: $PROJECT_NAME${NC}"
fi

# Also generate docs/README.md if it doesn't exist
DOCS_README="Server/docs/README.md"
if [ ! -f "$DOCS_README" ]; then
    echo -e "${BLUE}📝 Generating docs/README.md...${NC}"

    cat > "$DOCS_README" << EOF
# $PROJECT_NAME Documentation

This directory contains comprehensive documentation for the $PROJECT_NAME project infrastructure.

## 📚 Available Documentation

### [Server Infrastructure README](../README.md)
Complete guide for server setup, Docker configuration, and deployment.

### [Multi-Project Deployment Guide](MULTI_PROJECT_GUIDE.md)
Advanced guide for running multiple projects simultaneously without conflicts.

## 🔧 Quick Links

### Setup & Deployment
- [System Requirements](../requirements/system/requirements.md)
- [Docker Requirements](../requirements/docker/requirements.md)
- [PHP Requirements](../requirements/php/requirements.md)

### Configuration
- [PHP Configuration](../configs/php/)
- [MySQL Configuration](../configs/mysql/)
- [Environment Templates](../configs/env/)

### Scripts & Automation
- [Setup Script](../scripts/setup.sh) - Complete project setup
- [Container Helper](../scripts/container-helper.sh) - Container management
- [Multi-Project Checker](../scripts/multi-project-check.sh) - Conflict analysis

## 🚀 Getting Started

1. **Check Requirements**
   \`\`\`bash
   ./Server/scripts/check-requirements.sh
   \`\`\`

2. **Setup Project**
   \`\`\`bash
   ./Server/scripts/setup.sh
   \`\`\`

3. **Start Development**
   \`\`\`bash
   ./Server/scripts/start.sh
   \`\`\`

## 🆘 Need Help?

- 📖 Read the [main README](../README.md) for comprehensive information
- 🔍 Run diagnostics: \`./Server/scripts/multi-project-check.sh\`
- 🐛 Check container status: \`./Server/scripts/container-helper.sh status\`
- 📋 View logs: \`./Server/scripts/container-helper.sh logs web\`

---

**Project**: $PROJECT_NAME
**Infrastructure**: Docker + PHP 8.4 + MySQL 8.0
**Domain**: $DOMAIN
EOF

    echo -e "${GREEN}✅ docs/README.md generated successfully!${NC}"
fi
