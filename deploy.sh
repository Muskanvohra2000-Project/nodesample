#!/bin/bash

set -e  # Exit immediately if any command fails

APP_DIR="/var/www/nodeapp"
REPO_URL="https://github.com/Muskanvohra2000-Project/nodesample"
BRANCH="main"
PM2_APP_NAME="nodeapp"
LOG_FILE="/var/log/nodeapp/deploy.log"

# Create log directory
echo "[+] Creating log directory..."
sudo mkdir -p /var/log/nodeapp
sudo chown -R $USER:$USER /var/log/nodeapp

# Log all output to file and console
exec > >(tee -a "$LOG_FILE") 2>&1

echo "🕐 Starting deployment on $(hostname) at $(date)"

echo "[+] Installing Git, Node.js, and PM2 if not already installed..."
if ! command -v git &> /dev/null; then
  sudo apt-get update && sudo apt-get install -y git
fi

if ! command -v node &> /dev/null; then
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi

if ! command -v pm2 &> /dev/null; then
  sudo npm install -g pm2
fi

echo "[+] Cloning or updating the repository..."
if [ ! -d "$APP_DIR" ]; then
  git clone -b "$BRANCH" "$REPO_URL" "$APP_DIR"
else
  cd "$APP_DIR"
  git reset --hard
  git pull origin "$BRANCH"
fi

cd "$APP_DIR"

echo "[+] Installing dependencies..."
npm install

echo "[+] Starting or reloading application using PM2..."
# Ensure no existing process is bound to the port
if pm2 list | grep -q "$PM2_APP_NAME"; then
  echo "[~] App already running. Restarting..."
  pm2 delete "$PM2_APP_NAME"
fi

pm2 start ecosystem.config.js --name "$PM2_APP_NAME"
pm2 save

echo "✅ Deployment complete on $(hostname) at $(date)"
