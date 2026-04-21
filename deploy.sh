#!/bin/bash

# Enter the working directory
cd /opt/Aeronautics_network_server || exit

# Push the latest configuration from remote.
echo "Updating configuration files..."
git pull origin main

# CDN resources
CDN_BASE="http://www.ustcmc.com/static"
MODS_FILE="mods.tar.gz"

# echo "Syncing mod files..."
# curl -L $CDN_BASE/$MODS_FILE -o $MODS_FILE
# tar -zxvf mods.tar.gz -C ./survival/
# tar -zxvf mods.tar.gz -C ./creative/

# MD5 校验, 避免重复下载
echo ">>> 检查模组版本..."
REMOTE_MD5=$(curl -s $CDN_BASE/mods.md5 | awk '{print $1}')
LOCAL_MD5=$(md5sum $MODS_FILE 2>/dev/null | awk '{print $1}')

if [ "$REMOTE_MD5" != "$LOCAL_MD5" ]; then
    echo ">>> 发现新版本模组，开始下载..."
    curl -L $CDN_BASE/$MODS_FILE -o $MODS_FILE
    
    echo ">>> 正在解压模组到子服..."
    rm -rf ./survival/mods/*
    tar -zxvf $MODS_FILE -C ./survival/mods

    rm -rf ./creative/mods/*
    cp -r ./survival/mods/* ./creative/mods/
else
    echo ">>> 模组已是最新，跳过下载。"
fi

docker-compose up -d --remove-orphans

echo "Deployment complete!"