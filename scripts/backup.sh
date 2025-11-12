#!/bin/bash

# Homelab Backup Script
# Creates backups of Docker configurations and data

set -e

# Configuration
BACKUP_DIR="/backup"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="homelab_backup_$DATE"
DOCKER_DIR="$HOME/docker"

echo "💾 Creating homelab backup..."

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Stop Docker containers
echo "⏹️ Stopping Docker containers..."
cd "$DOCKER_DIR"
docker compose down

# Create backup archive
echo "📦 Creating backup archive..."
tar -czf "$BACKUP_DIR/$BACKUP_NAME.tar.gz" -C "$HOME" docker

# Start Docker containers
echo "▶️ Starting Docker containers..."
docker compose up -d

# Clean up old backups (keep last 7 days)
echo "🧹 Cleaning up old backups..."
find "$BACKUP_DIR" -name "homelab_backup_*.tar.gz" -mtime +7 -delete

echo "✅ Backup complete: $BACKUP_DIR/$BACKUP_NAME.tar.gz"
echo "💡 To restore: tar -xzf $BACKUP_DIR/$BACKUP_NAME.tar.gz -C $HOME"
