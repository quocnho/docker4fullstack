#!/bin/bash

# Helper script to get project domain
# Usage: source Server/scripts/get-domain.sh

# Get project root and name
if [ -n "${BASH_SOURCE[0]}" ]; then
    # When sourced
    PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
else
    # When called directly
    PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
fi

PROJECT_NAME=$(basename "$PROJECT_ROOT")
DOMAIN="${PROJECT_NAME}.dev"

# Export for use in other scripts
export PROJECT_ROOT
export PROJECT_NAME
export DOMAIN

# If called directly, print the domain
if [ "${BASH_SOURCE[0]}" == "${0}" ] 2>/dev/null; then
    echo "Project: $PROJECT_NAME"
    echo "Domain: $DOMAIN"
fi
