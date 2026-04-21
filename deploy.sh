#!/bin/bash
git pull origin main

echo "Syncing mod files..."
curl -L  -o mods.tar.gz
tar -zxvf mods.tar.gz -C ./survival/
tar -zxvf mods.tar.gz -C ./creative/

docker-compose up -d --remove-orphans

echo "Deployment complete!"