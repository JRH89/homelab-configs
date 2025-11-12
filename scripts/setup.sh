#!/bin/bash

# Homelab Setup Script
# This script automates the initial setup of the homelab environment

set -e

echo "🚀 Starting homelab setup..."

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install essentials
echo "🔧 Installing essential packages..."
sudo apt install curl git -y

# Install Docker
echo "🐳 Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose
echo "🔗 Installing Docker Compose..."
sudo apt install docker-compose-plugin -y

# Add user to docker group
echo "👤 Adding user to docker group..."
sudo usermod -aG docker $USER

# Install desktop environment and tools
echo "🖥️ Installing XFCE and i3..."
sudo apt install xfce4 xfce4-goodies i3 -y

# Install monitoring and dashboard tools
echo "📊 Installing monitoring tools..."
sudo apt install btop chromium-browser -y

# Install hardware acceleration for Jellyfin
echo "🎬 Installing hardware acceleration..."
sudo apt install vainfo i965-va-driver mesa-va-drivers -y

# Create docker directories
echo "📁 Creating Docker directories..."
mkdir -p ~/docker/{gitea,syncthing,jellyfin,filebrowser,netdata,media}
mkdir -p ~/docker/media/{movies,tv,music}

# Set permissions
echo "🔐 Setting permissions..."
sudo chown -R $USER:$USER ~/docker

echo "✅ Setup complete! Please reboot to apply docker group changes."
echo "🔄 After reboot, run: cd ~/docker && docker compose up -d"
