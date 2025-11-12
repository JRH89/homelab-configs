# 🏠 **ONE-COMMAND HOMELAB - Transform Any Mini PC into a Private Cloud!**

> **TL;DR:** Buy a mini PC → Run 5 commands → Get your own private GitHub, Netflix, Dropbox, Google Drive, and system monitoring dashboard.

---

## 🤯 **WHAT YOU GET (This is INSANE)**

### 🎯 **5 Self-Hosted Services That Replace Big Tech:**
- **🔧 Gitea** - Your PRIVATE GitHub (no Microsoft, no tracking)
- **🎬 Jellyfin** - Your PERSONAL Netflix (stream your own movies/TV in 4K)
- **📁 Syncthing** - Your SECURE Dropbox (sync files between all devices)
- **📂 FileBrowser** - Your PRIVATE Google Drive (access files from any browser)
- **📊 Netdata** - Your SYSTEM DASHBOARD (see everything happening on your server)

### 🖥️ **ALWAYS-ON DASHBOARD (This is the COOL part):**
Plug in ANY HDMI monitor → Instantly see:
```
+-------------------------------------------------------+
|          🏠 HOMELAB DASHBOARD - ALWAYS ON             |
|-------------------------------------------------------|
|                                                       |
|  +----------------------+   +---------------------+  |
|  |   💻 btop Terminal    |   |  📊 Netdata Full    |  |
|  |  CPU: ████████ 85%    |   |    Screen Stats     |  |
|  |  RAM: █████████ 92%   |   |  CPU, RAM, Disk,    |  |
|  |  NET: ⬇️2.5MB ⬆️1.1MB |   |  Network, Docker,   |  |
|  |  🌡️  45°C             |   |  Services Health    |  |
|  +----------------------+   +---------------------+  |
|                                                       |
|  +----------------------+   +---------------------+  |
|  | 🎬 Jellyfin Admin    |   | 📂 FileBrowser /    |  |
|  | 📁 Syncthing Web UI  |   | 📱 Optional Pages   |  |
|  | (Click to manage)    |   | (Your files online) |  |
|  +----------------------+   +---------------------+  |
|                                                       |
+-------------------------------------------------------+
```

---

## 🚀 **LITERALLY ONE COMMAND SETUP**

```bash
# 🎯 FIVE COMMANDS TO COMPLETE HOMELAB:
git clone https://github.com/yourusername/homelab-configs.git
cd homelab-configs
cp .env.example .env && nano .env  # Edit your IP once
./scripts/make-executable.sh
./scripts/setup.sh && sudo reboot  # 🎯 THIS INSTALLS EVERYTHING
cd ~/docker && docker compose up -d  # 🚀 STARTS ALL SERVICES
```

**That's it.** No complex setup. No manual configuration. No BS.

---

## 🏗️ **HOW IT WORKS - The Architecture**

```
🏠 YOUR HOME NETWORK (This becomes your private cloud)
                   |
    🌐 INTERNET ←→ 📶 ROUTER ←→ 🖥️ YOUR MINI PC HOMELAB
                   |
    ┌─────────────────────────────────────────────────────┐
    │              🖥️ MINI PC SERVER                     │
    │         Ryzen 5 5500U • 32GB RAM • 500GB SSD       │
    │                                                     │
    │  ┌─────────────────────────────────────────────┐   │
    │  │            🐳 DOCKER CONTAINERS             │   │
    │  │                                             │   │
    │  │ 🔧 Gitea     :3000  ←→ 📁 Your Git repos    │   │
    │  │ 🎬 Jellyfin  :8096  ←→ 🎬 Your movies/TV    │   │
    │  │ 📁 Syncthing :8384  ←→ 📱 Device sync       │   │
    │  │ 📂 FileBrowser:8080  ←→ 🌐 Web file access │   │
    │  │ 📊 Netdata   :19999 ←📈 System monitoring  │   │
    │  └─────────────────────────────────────────────┘   │
    └─────────────────────────────────────────────────────┘
                   |
    ┌─────────────────────────────────────────────────────┐
    │              📱 ALL YOUR DEVICES                   │
    │                                                     │
    │ 💻 PC1    💻 PC2    📱 Phone    📱 Tablet    📺 TV   │
    │    │         │         │          │          │      │
    │  Git Push  Stream    Sync    Browse Files  Cast     │
    │    └─────────┴─────────┴──────────┴──────────┘      │
    └─────────────────────────────────────────────────────┘
```

---

## 📁 **REPOSITORY STRUCTURE - Everything Organized**

```
homelab-configs/                    # 🏠 Your complete homelab
├── .gitignore                      # 🚫 Blocks sensitive files
├── .env.example                    # ⚙️ Your settings template
├── README.md                       # 📖 This awesome guide
├── 📊 DIAGRAMS:
│   ├── homelab_dashboard.txt       # 🖥️ Dashboard layout
│   ├── homelab_folder_cheatsheet.txt # 📁 Docker folders
│   └── homelab_schema.txt          # 🌐 Network diagram
├── 🤖 scripts/                     # 🎯 Automation magic
│   ├── setup.sh                   # 🚀 ONE COMMAND TO RULE THEM ALL
│   ├── update.sh                  # 🔄 Updates everything
│   ├── backup.sh                  # 💾 Quick backup
│   └── make-executable.sh         # 🔧 Fix permissions
├── ⚙️ configs/                     # 📋 All configurations
│   ├── docker/                    # 🐳 Docker services
│   │   └── docker-compose.yml     # 📦 All 5 services defined
│   ├── i3/                        # 🖥️ Dashboard window manager
│   │   └── config                 # 📐 Tiling layout
│   ├── nginx/                     # 🌐 Reverse proxy (optional)
│   │   ├── nginx.conf             # 🔄 URL routing
│   │   └── docker-compose.yml     # 🌐 Proxy service
│   └── backup/                    # 💾 Backup solutions
│       ├── backup.sh              # 📦 Complete backup
│       └── restore.sh             # 🔄 Restore from backup
└── 📚 docs/                       # 📖 Documentation
    └── setup.md                   # 📋 Detailed setup guide
```

---

## 🎯 **WHAT EACH SERVICE DOES (The "Why This is Awesome")**

### 🔧 **Gitea - Your Private GitHub**
- **Why it's cool:** No Microsoft tracking, no API limits, no monthly fees
- **What you get:** Private Git repos, issue tracking, wikis, teams
- **Access:** `http://<your-ip>:3000`
- **Perfect for:** Personal projects, learning Git, private code

### 🎬 **Jellyfin - Your Personal Netflix**
- **Why it's cool:** Stream your own movie collection in 4K, no subscriptions
- **What you get:** Media server, transcoding, user accounts, mobile apps
- **Access:** `http://<your-ip>:8096`
- **Perfect for:** Movie collections, home videos, music streaming

### 📁 **Syncthing - Your Secure Dropbox**
- **Why it's cool:** End-to-end encryption, no cloud storage limits
- **What you get:** Real-time file sync between all your devices
- **Access:** `http://<your-ip>:8384`
- **Perfect for:** Document sync, photo backup, cross-device files

### 📂 **FileBrowser - Your Private Google Drive**
- **Why it's cool:** Access files from any browser, no Google tracking
- **What you get:** Web file manager, upload/download, user permissions
- **Access:** `http://<your-ip>:8080`
- **Perfect for:** File sharing, remote access, document management

### 📊 **Netdata - Your System Dashboard**
- **Why it's cool:** See everything happening on your server in real-time
- **What you get:** CPU, RAM, disk, network, Docker container monitoring
- **Access:** `http://<your-ip>:19999`
- **Perfect for:** System monitoring, performance tuning, uptime tracking

---

## 💡 **WHY THIS IS REVOLUTIONARY**

### 🆓 **COST SAVINGS:**
- GitHub Pro: **$4/month** → **FREE**
- Netflix Premium: **$20/month** → **FREE**
- Dropbox Plus: **$10/month** → **FREE**
- Google Drive: **$10/month** → **FREE**
- **Total savings: $540/year** FOREVER!

### 🔒 **PRIVACY WINS:**
- **No big tech tracking** your data
- **No government surveillance** through cloud services
- **Your files stay on YOUR hardware**
- **End-to-end encryption** you control

### 🏠 **NETWORK INDEPENDENCE:**
- Move homes? **Just plug it in.**
- New WiFi? **Works automatically.**
- No internet? **Still works locally.**
- Traveling? **Access via VPN.**

### 🤖 **AUTOMATION MAGIC:**
- **One command** installs EVERYTHING
- **Auto-starts** when you plug in a monitor
- **Auto-updates** with one script
- **Auto-backups** your entire setup

---

## 🛠️ **TECHNICAL REQUIREMENTS (Minimal)**

### **Hardware:**
- Any mini PC or old computer
- Ryzen 5 5500U, 32GB RAM, 500GB SSD (recommended)
- HDMI monitor (optional, for dashboard)

### **Software:**
- Ubuntu Desktop 24.04 LTS
- Ethernet cable (recommended for stability)

### **That's it.** No special skills needed.

---

## 🚀 **QUICK START GUIDE (5 Minutes)**

```bash
# 1️⃣ CLONE THE REPOSITORY
git clone https://github.com/yourusername/homelab-configs.git
cd homelab-configs

# 2️⃣ CONFIGURE YOUR IP (once)
cp .env.example .env
nano .env  # Change IP_ADDRESS=your.local.ip

# 3️⃣ MAKE SCRIPTS EXECUTABLE
./scripts/make-executable.sh

# 4️⃣ 🎯 THE MAGIC COMMAND (installs EVERYTHING)
./scripts/setup.sh

# 5️⃣ REBOOT AND START SERVICES
sudo reboot
cd ~/docker && docker compose up -d
```

**🎉 YOU'RE DONE!** All services are running.

---

## 📱 **ACCESS YOUR SERVICES**

After setup, open your browser and go to:

| Service | URL | What it is |
|---------|-----|------------|
| 🔧 **Gitea** | `http://<your-ip>:3000` | Your private GitHub |
| 🎬 **Jellyfin** | `http://<your-ip>:8096` | Your personal Netflix |
| 📁 **Syncthing** | `http://<your-ip>:8384` | Your secure Dropbox |
| 📂 **FileBrowser** | `http://<your-ip>:8080` | Your private Google Drive |
| 📊 **Netdata** | `http://<your-ip>:19999` | Your system dashboard |

---

## 🔄 **MAINTENANCE (Also Easy)**

```bash
# Update everything (system + Docker)
cd ~/homelab-configs && ./scripts/update.sh

# Quick backup (Docker data)
cd ~/homelab-configs && ./scripts/backup.sh

# Complete backup (configs + system)
cd ~/homelab-configs && ./configs/backup/backup.sh
```

---

## 🌟 **FEATURES THAT MAKE THIS AWESOME**

- **🔒 100% Private** - No big tech, no tracking, no surveillance
- **🆓 Completely Free** - No subscriptions, no API limits, no hidden costs
- **🤖 One-Command Setup** - Install everything with a single script
- **📊 Always-On Dashboard** - Plug in monitor → instant system overview
- **🏠 Network Independent** - Works anywhere, move homes easily
- **💾 Automated Backups** - Built-in backup and restore solutions
- **🔄 Easy Updates** - One command updates everything
- **📱 Device Sync** - Sync files between phones, tablets, computers
- **🎬 Media Streaming** - 4K transcoding with hardware acceleration
- **🔧 Development Ready** - Private Git hosting with all GitHub features

---

## 🤝 **CONTRIBUTE & FORK**

This is open-source! Feel free to:
- **🍴 Fork** for your own homelab
- **⭐ Star** if you think this is awesome
- **🐛 Report** issues or suggest improvements
- **📝 Adapt** configurations for your needs

---

## 📄 **LICENSE**

MIT License - Use, modify, and distribute for your own homelab projects.

---

# 🎯 **READY TO BUILD YOUR PRIVATE CLOUD?**

**Transform any mini PC into a powerful, self-hosted homelab with:**
- ✅ Automated one-command setup
- ✅ 5 core services replacing big tech
- ✅ Always-on monitoring dashboard
- ✅ Complete privacy and control
- ✅ Zero ongoing costs

**🏠 Your homelab. Your rules. Your data.** ✨

---

> **"Why pay $540/year for services you can run yourself?"** - Start your homelab today!
