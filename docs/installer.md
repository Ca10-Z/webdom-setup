---
marp: true
theme: default
class: lead
paginate: true
backgroundColor: #0d1117
color: #e6edf3
title: WEBdom Installation Guide
description: Step-by-step guide for installing and running WEBdom on any system.
---

# 🌐 WEBdom Setup & Installation Guide
### A practical guide to installing and running WEBdom  
#### Compatible with Windows, Linux, and macOS

---

## 🧰 Requirements
Before starting, make sure you have:

- 🐳 **Docker** — To run the containers  
- 🧑‍💻 **Git** — To clone the repository  
- 🌍 **Internet connection** — To pull the required images  
- ⚙️ **Access to a terminal or PowerShell**

---

## 🪟 Windows Installation — Step 1
### Install Docker Desktop
1. Visit [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)  
2. Download and install **Docker Desktop for Windows**  
3. After installation, open **Docker Desktop**

🧠 **Note:**  
If prompted, enable **WSL 2** and restart your computer.

✅ Once started, make sure the whale 🐳 icon in the taskbar says **“Docker Desktop is running”**.

---

## 🪟 Windows Installation — Step 2
### Install Git
1. Go to [https://git-scm.com/downloads](https://git-scm.com/downloads)  
2. Download and install **Git for Windows**  
3. When finished, open **PowerShell** or **Git Bash** and test:

```bash
git --version
docker --version
```

If both commands return version numbers, you’re ready.

---

## 🐧 Linux Installation
### Install Docker and Git (Debian/Ubuntu-based)
Run the following in your terminal:

```bash
sudo apt update
sudo apt install -y docker.io docker-compose git
sudo systemctl enable docker
sudo systemctl start docker
```

Then check that everything works:

```bash
git --version
docker --version
```

---

## 🍎 macOS Installation
### Install Docker and Git
1. Install **Docker Desktop for Mac** from  
   [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)  
2. Install **Git** using [Homebrew](https://brew.sh/):

```bash
brew install git
```

Check both installations:

```bash
git --version
docker --version
```

---

## 📦 Step 1 — Clone the WEBdom Repository
Open your terminal and run:

```bash
git clone https://github.com/YOUR_USERNAME/webdom.git
cd webdom
```

🧭 This will create and enter the local project folder.

---

## ⚙️ Step 2 — Start the WEBdom Service
Start Docker if it’s not already running.

Then run the following commands:

```bash
docker compose build
docker compose up -d
```

This will:
- Pull required images from Docker Hub  
- Build and launch the WEBdom containers  
- Run the service in the background  

---

## 🧪 Step 3 — Access WEBdom
After setup, open your browser and visit:

```
http://localhost:8000
```

If another port was set in the `.env` file, use that instead.

---

## 📁 Project Structure
```bash
webdom/
├── docker-compose.yml
├── .env
├── README.md
├── src/
│   ├── main/
│   └── config/
└── data/
```

🧱 This structure helps you locate environment configs, code, and volumes easily.

---

## 🚀 Updating WEBdom
To update your local WEBdom setup:

```bash
git pull origin main
docker compose pull
docker compose up -d --build
```

This fetches the latest code and rebuilds containers seamlessly.

---

## 🧹 Uninstalling WEBdom
If you want to remove WEBdom completely:

```bash
docker compose down
docker system prune -a --volumes
```

🧽 This stops all containers and cleans up unused images and volumes.

---

## 🧾 License
This project is licensed under the **MIT License**.  
You are free to use, modify, and distribute it with proper credit.

---

## 💡 Tips & Troubleshooting
- ✅ Ensure Docker Desktop is **running** before starting  
- ⚙️ Run terminal or PowerShell as **Administrator** (Windows)  
- 🧰 On Linux, use `sudo` if permission errors occur  
- 🧠 Use `docker ps` to check if the containers are active

---

## 🧠 Summary
You’ve learned how to:
- Install Docker and Git  
- Clone and run the WEBdom project  
- Manage containers and updates  
- Access WEBdom locally via your browser  

🎉 **You’re now ready to use WEBdom!**

---

## 🌎 Connect with the Project
💻 GitHub: [https://github.com/Ca10-Z/webdom-setup](https://github.com/Ca10-Z/webdom-setup)    
📜 Docs: [https://docs.webodm.org](https://docs.webodm.org)
