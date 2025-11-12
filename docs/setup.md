# Mini PC Home Lab — Setup Guide

## Overview
This guide sets up a Ryzen 5 mini PC (32 GB RAM, 500 GB SSD) for:
- Local development / file sharing
- Self-hosted Git (Gitea)
- Media streaming (Jellyfin)
- File syncing (Syncthing)
- Web-based file management (FileBrowser)
- System & Docker monitoring (Netdata, btop)
- Always-on dashboard on a plugged-in HDMI monitor

The system uses:
- Ubuntu Desktop 24.04 LTS
- Docker + Docker Compose
- i3 tiling window manager for dashboard layout
- btop for terminal monitoring
- Chromium in kiosk mode for Netdata

## Step 0 — Hardware & Prep
- Mini PC: Ryzen 5 5500U, 32 GB RAM, 500 GB SSD
- HDMI monitor (5–7 inch or TV)
- Ethernet cable (recommended for stable LAN)
- USB drive for Ubuntu Desktop 24.04 LTS

## Step 1 — Install Ubuntu Desktop
1. Flash USB using Balena Etcher
2. Boot mini PC from USB
3. During installation:
   - Create username/password (e.g., jared)
   - Optional: enable SSH
   - Install system updates

## Step 2 — Update System & Essentials
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl git -y
```

## Step 3 — Install Docker & Docker Compose
```bash
# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Docker Compose plugin
sudo apt install docker-compose-plugin -y

# Optional: run Docker without sudo
sudo usermod -aG docker $USER
newgrp docker

# Test Docker
docker run hello-world
```

## Step 4 — Create Docker Project Structure
```bash
mkdir -p ~/docker/{gitea,syncthing,jellyfin,filebrowser,netdata,media}
cd ~/docker
```

- `media` → movies, TV, music
- Other folders → persistent service config/data

## Step 5 — Docker Compose File
Create `~/docker/docker-compose.yml`:

```yaml
version: "3"
services:
  gitea:
    image: gitea/gitea:latest
    restart: unless-stopped
    ports:
      - "3000:3000"
      - "2222:22"
    volumes:
      - ./gitea:/data

  syncthing:
    image: syncthing/syncthing
    restart: unless-stopped
    ports:
      - "8384:8384"
      - "22000:22000"
      - "21027:21027/udp"
    volumes:
      - ./syncthing:/var/syncthing

  jellyfin:
    image: jellyfin/jellyfin:latest
    restart: unless-stopped
    ports:
      - "8096:8096"
      - "8920:8920"
    devices:
      - "/dev/dri:/dev/dri"
    volumes:
      - ./jellyfin/config:/config
      - ./media:/media

  filebrowser:
    image: filebrowser/filebrowser:latest
    restart: unless-stopped
    ports:
      - "8080:80"
    volumes:
      - ./filebrowser:/srv
      - ./filebrowser/config:/config

  netdata:
    image: netdata/netdata:latest
    restart: unless-stopped
    ports:
      - "19999:19999"
    cap_add:
      - SYS_PTRACE
      - NET_ADMIN
```

## Step 6 — Launch Docker Services
```bash
cd ~/docker
docker compose up -d
docker ps   # verify containers are running
```

## Step 7 — Install XFCE + i3 + Dashboard Tools
```bash
sudo apt install xfce4 xfce4-goodies -y
sudo apt install i3 -y
sudo apt install btop -y
sudo apt install chromium-browser -y
```

## Step 8 — Configure i3 Autostart Dashboard
Create i3 config directory:
```bash
mkdir -p ~/.config/i3
nano ~/.config/i3/config
```

Add autostart entries:
```
# Start btop terminal
exec --no-startup-id gnome-terminal -- bash -c "btop; exec bash"

# Start Chromium in kiosk mode for Netdata
exec --no-startup-id chromium --kiosk http://localhost:19999
```

Optional tiling tweaks:
```
workspace_layout tabbed
```

## Step 9 — Enable Auto-Login
```bash
sudo nano /etc/gdm3/custom.conf
```

Uncomment/set:
```
AutomaticLoginEnable = true
AutomaticLogin = your_username
```

Replace `your_username` with your Ubuntu user.

## Step 10 — Optional Jellyfin Hardware Acceleration
```bash
sudo apt install vainfo i965-va-driver mesa-va-drivers -y
```

`/dev/dri` is passed to Jellyfin Docker container for transcoding.

## Step 11 — Access Services on LAN

| Service | URL |
|---------|-----|
| Gitea | `http://<mini_pc_ip>:3000` |
| Syncthing | `http://<mini_pc_ip>:8384` |
| Jellyfin | `http://<mini_pc_ip>:8096` |
| FileBrowser | `http://<mini_pc_ip>:8080` |
| Netdata | `http://<mini_pc_ip>:19999` |

## Step 12 — Dashboard Behavior
Plug in HDMI monitor → automatically shows i3 desktop with:
- Top-left: btop terminal
- Top-right: Netdata fullscreen (Chromium kiosk)
- Optional bottom panes: Jellyfin / FileBrowser / Syncthing

i3 allows resizing/swapping panes with keyboard shortcuts. Auto-start apps ensure dashboard appears without manual intervention.

## 🚀 On the Mini PC (Ubuntu):

### 1. **Clone Your Repository**
```bash
git clone https://github.com/yourusername/homelab-configs.git
cd homelab-configs
```

### 2. **Setup Environment**
```bash
cp .env.example .env
nano .env  # Edit your IP, domain, etc.
./scripts/make-executable.sh
```

### 3. **Run Setup**
```bash
./scripts/setup.sh
```
> The setup script automatically:
> - Updates system packages
> - Installs Docker and Docker Compose
> - Sets up desktop environment (XFCE + i3)
> - Installs monitoring tools (btop, Chromium)
> - Enables hardware acceleration for Jellyfin
> - Creates `~/docker/` directory structure
> - **Copies Docker compose file to `~/docker/`**

### 4. **Reboot**
```bash
sudo reboot
```
> Required for Docker group permissions to take effect

### 5. **Start Services**
```bash
cd ~/docker
docker compose up -d
```

## 🎯 **Result:**
All services running at:
- **Gitea**: `http://<your-ip>:3000`
- **Jellyfin**: `http://<your-ip>:8096`
- **Syncthing**: `http://<your-ip>:8384`
- **FileBrowser**: `http://<your-ip>:8080`
- **Netdata**: `http://<your-ip>:19999`

## 🛠️ Maintenance

### Update Ubuntu:
```bash
sudo apt update && sudo apt upgrade -y
```

### Update Docker containers:
```bash
cd ~/docker
docker compose pull
docker compose up -d
```

### Automated Updates:
```bash
cd ~/homelab-configs
./scripts/update.sh
```

### Backup:
```bash
# Quick backup (Docker data only)
cd ~/homelab-configs
./scripts/backup.sh

# Comprehensive backup (configs + system)
./configs/backup/backup.sh
```

## ✅ Final Result:
- Local home lab with Docker services: Gitea, Syncthing, Jellyfin, FileBrowser, Netdata
- Always-on monitor dashboard showing btop + Netdata
- Full control over files, media, and development environment
- Automated setup, updates, and backup solutions
- Efficient, lightweight, and expandable
