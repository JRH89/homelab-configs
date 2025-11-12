#!/bin/bash

# Homelab Update Script
# Updates system packages and Docker containers

set -e

echo "🔄 Updating homelab..."

# Update system packages
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Update Docker containers
echo "🐳 Updating Docker containers..."
cd ~/docker
docker compose pull
docker compose up -d

# Clean up old Docker images
echo "🧹 Cleaning up old Docker images..."
docker image prune -f

echo "✅ Update complete!"
