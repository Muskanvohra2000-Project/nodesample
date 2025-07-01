#!/bin/bash

# Install nginx
sudo apt-get update
sudo apt-get install -y nginx

# Replace default config to reverse proxy to Node.js (port 3000)
cat <<EOF | sudo tee /etc/nginx/sites-available/default
server {
    listen 80;
    server_name _;
        
    # Specify the access log file and the JSON format for THIS server block
    access_log /var/log/nginx/default_access.json json_access;
    error_log /var/log/nginx/default_error.log warn; # It's good practice to have an error log

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }

    location /health {
        proxy_pass http://localhost:3000/health;
    }
}
EOF

# Restart nginx
sudo systemctl restart nginx
