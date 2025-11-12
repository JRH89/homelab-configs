#!/bin/bash

# Homelab Restore Script
# Restores from a comprehensive backup

set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <backup_file.tar.gz>"
    echo "Example: $0 /backup/homelab_full_backup_20231201_120000.tar.gz"
    exit 1
fi

BACKUP_FILE="$1"
TEMP_DIR="/tmp/homelab_restore_$(date +%s)"

echo "🔄 Restoring homelab from backup..."

# Check if backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Backup file not found: $BACKUP_FILE"
    exit 1
fi

# Create temporary directory
mkdir -p "$TEMP_DIR"

# Extract backup
echo "📦 Extracting backup..."
tar -xzf "$BACKUP_FILE" -C "$TEMP_DIR"

# Find the extracted backup folder
BACKUP_FOLDER=$(find "$TEMP_DIR" -name "temp_*" -type d | head -1)

if [ -z "$BACKUP_FOLDER" ]; then
    echo "❌ Invalid backup file format"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Stop Docker services
echo "⏹️ Stopping Docker services..."
cd "$HOME/docker" 2>/dev/null || true
docker compose down 2>/dev/null || true

# Restore Docker data
echo "🐳 Restoring Docker data..."
if [ -f "$BACKUP_FOLDER/docker_data.tar.gz" ]; then
    tar -xzf "$BACKUP_FOLDER/docker_data.tar.gz" -C "$HOME"
else
    echo "⚠️ Docker data backup not found"
fi

# Restore configurations
echo "⚙️ Restoring configurations..."
if [ -f "$BACKUP_FOLDER/configs.tar.gz" ]; then
    tar -xzf "$BACKUP_FOLDER/configs.tar.gz" -C "$HOME"
else
    echo "⚠️ Configuration backup not found"
fi

# Restore system settings (with confirmation)
echo "🔧 System settings backup available:"
ls -la "$BACKUP_FOLDER"/*.backup 2>/dev/null || echo "No system settings found"

read -p "Do you want to restore system settings? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🔧 Restoring system settings..."
    [ -f "$BACKUP_FOLDER/fstab.backup" ] && sudo cp "$BACKUP_FOLDER/fstab.backup" /etc/fstab
    [ -f "$BACKUP_FOLDER/hosts.backup" ] && sudo cp "$BACKUP_FOLDER/hosts.backup" /etc/hosts
    [ -f "$BACKUP_FOLDER/interfaces.backup" ] && sudo cp "$BACKUP_FOLDER/interfaces.backup" /etc/network/interfaces
fi

# Start Docker services
echo "▶️ Starting Docker services..."
cd "$HOME/docker"
docker compose up -d

# Cleanup
rm -rf "$TEMP_DIR"

echo "✅ Restore complete!"
echo "🔄 Please reboot your system to ensure all changes take effect."
