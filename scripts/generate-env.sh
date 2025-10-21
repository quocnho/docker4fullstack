#!/bin/bash

# Generate .env file with dynamic domain
# Usage: ./Server/scripts/generate-env.sh

# Load domain configuration
source "$(dirname "$0")/get-domain.sh"

ENV_FILE="Server/docker/.env"
ENV_EXAMPLE="Server/docker/.env.example"

echo "🔧 Generating .env file with dynamic domain..."

# Copy example file
cp "$ENV_EXAMPLE" "$ENV_FILE"

# Replace dynamic values
sed -i "s|APP_URL=http://fukoji.dev|APP_URL=http://$DOMAIN|g" "$ENV_FILE"
sed -i "s|PROJECT_NAME\.dev|$DOMAIN|g" "$ENV_FILE"

echo "✅ Generated $ENV_FILE with:"
echo "   • Domain: $DOMAIN"
echo "   • Project: $PROJECT_NAME"
