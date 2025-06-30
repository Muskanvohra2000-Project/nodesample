#!/bin/bash

APP_DIR="/var/www/nodeapp"
REPO_URL="https://github.com/YOUR-USER/YOUR-REPO.git"
BRANCH="main"
PM2_APP_NAME="nodeapp"

echo "[+] Updating code..."

if [ ! -d "$APP_DIR" ]; then
  git clone -b $BRANCH $REPO_URL $APP_DIR
else
  cd $APP_DIR
  git reset --hard
  git pull origin $BRANCH
fi

cd $APP_DIR

echo "[+] Installing dependencies..."
npm install

echo "[+] Restarting app..."
pm2 start ecosystem.config.js || pm2 restart $PM2_APP_NAME

echo "[+] Deployment complete!"
