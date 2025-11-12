#!/bin/bash

# Make all scripts executable
echo "🔧 Making scripts executable..."

# Make scripts in root scripts folder executable
chmod +x scripts/*.sh

# Make scripts in configs/backup folder executable
chmod +x configs/backup/*.sh

echo "✅ All scripts are now executable!"
