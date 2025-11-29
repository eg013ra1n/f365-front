#!/bin/bash

# f365-front Deployment Script
# This script builds and deploys the Vue application to a remote server

set -e  # Exit on error

# Load deployment configuration
if [ -f "deploy.config" ]; then
    source deploy.config
else
    echo "Error: deploy.config file not found"
    echo "Please copy deploy.config.example to deploy.config and update with your server details"
    exit 1
fi

BUILD_DIR="dist"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting deployment process...${NC}"

# Step 1: Check if .env.production exists
if [ ! -f ".env.production" ]; then
    echo -e "${RED}Error: .env.production file not found${NC}"
    echo "Please create .env.production with your production environment variables"
    echo "You can copy .env.example and modify it:"
    echo "  cp .env.example .env.production"
    exit 1
fi

# Step 2: Install dependencies
echo -e "${YELLOW}Installing dependencies...${NC}"
npm install

# Step 3: Build for production (skipping type-check for faster deployment)
echo -e "${YELLOW}Building application...${NC}"
npm run build-only

# Check if build was successful
if [ ! -d "$BUILD_DIR" ]; then
    echo -e "${RED}Build failed: $BUILD_DIR directory not found${NC}"
    exit 1
fi

echo -e "${GREEN}Build completed successfully${NC}"

# Step 5: Deploy to remote server
echo -e "${YELLOW}Deploying to remote server...${NC}"

# Create backup of current deployment on remote server
echo "Creating backup on remote server..."
ssh -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" "
    if [ -d $REMOTE_PATH/dist ]; then
        timestamp=\$(date +%Y%m%d_%H%M%S)
        mkdir -p $REMOTE_PATH/backups
        mv $REMOTE_PATH/dist $REMOTE_PATH/backups/dist_\$timestamp
        echo 'Backup created: dist_\$timestamp'
    fi
    mkdir -p $REMOTE_PATH
"

# Upload new build
echo "Uploading new build..."
rsync -avz --delete \
    -e "ssh -p $REMOTE_PORT" \
    --exclude='.git' \
    --exclude='node_modules' \
    --exclude='.env*' \
    $BUILD_DIR/ "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH/dist/"

# Set proper permissions
echo "Setting permissions..."
ssh -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" "
    chmod -R 755 $REMOTE_PATH/dist
    chown -R www-data:www-data $REMOTE_PATH/dist 2>/dev/null || true
"

echo -e "${GREEN}Deployment completed successfully!${NC}"
echo ""
echo "Next steps:"
echo "1. Ensure nginx configuration is in place:"
echo "   sudo cp nginx.conf /etc/nginx/sites-available/f365-front"
echo "   sudo ln -s /etc/nginx/sites-available/f365-front /etc/nginx/sites-enabled/"
echo "2. Test nginx configuration:"
echo "   sudo nginx -t"
echo "3. Reload nginx:"
echo "   sudo systemctl reload nginx"
echo ""
echo -e "${GREEN}Your application should now be live!${NC}"
