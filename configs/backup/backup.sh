#!/bin/bash

# Comprehensive Backup Script
# Backs up Docker data, configurations, and system settings

set -e

# Configuration
BACKUP_DIR="/backup"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="homelab_full_backup_$DATE"
DOCKER_DIR="$HOME/docker"
CONFIG_DIR="$HOME/homelab-configs"

echo "💾 Creating comprehensive homelab backup..."

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create temporary backup folder
TEMP_BACKUP_DIR="$BACKUP_DIR/temp_$DATE"
mkdir -p "$TEMP_BACKUP_DIR"

# Backup Docker data
echo "📦 Backing up Docker data..."
cd "$DOCKER_DIR"
docker compose down
tar -czf "$TEMP_BACKUP_DIR/docker_data.tar.gz" -C "$HOME" docker
docker compose up -d

# Backup configurations
echo "⚙️ Backing up configurations..."
tar -czf "$TEMP_BACKUP_DIR/configs.tar.gz" -C "$HOME" homelab-configs

# Backup system settings
echo "🔧 Backing up system settings..."
sudo cp /etc/fstab "$TEMP_BACKUP_DIR/fstab.backup" 2>/dev/null || true
sudo cp /etc/hosts "$TEMP_BACKUP_DIR/hosts.backup" 2>/dev/null || true
sudo cp /etc/network/interfaces "$TEMP_BACKUP_DIR/interfaces.backup" 2>/dev/null || true

# Create backup info file
echo "📋 Creating backup info..."
cat > "$TEMP_BACKUP_DIR/backup_info.txt" << EOF
Backup created: $(date)
Hostname: $(hostname)
IP Address: $(hostname -I | awk '{print $1}')
Docker containers: $(docker ps --format "table {{.Names}}\t{{.Status}}")
Disk usage: $(df -h / | tail -1)
Memory usage: $(free -h | grep Mem)
EOF

# Create final backup archive
echo "🗜️ Creating final backup archive..."
cd "$BACKUP_DIR"
tar -czf "$BACKUP_NAME.tar.gz" "temp_$DATE"
rm -rf "temp_$DATE"

# Clean up old backups (keep last 5)
echo "🧹 Cleaning up old backups..."
find "$BACKUP_DIR" -name "homelab_full_backup_*.tar.gz" -mtime +5 -delete

echo "✅ Backup complete: $BACKUP_DIR/$BACKUP_NAME.tar.gz"
echo "💾 Size: $(du -h $BACKUP_DIR/$BACKUP_NAME.tar.gz | cut -f1)"
echo "📋 To restore:"
echo "   1. tar -xzf $BACKUP_DIR/$BACKUP_NAME.tar.gz"
echo "   2. cd temp_$DATE"
echo "   3. tar -xzf docker_data.tar.gz -C \$HOME"
echo "   4. tar -xzf configs.tar.gz -C \$HOME"
echo "   5. sudo cp fstab.backup /etc/fstab (if needed)"
