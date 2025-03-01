#!/usr/bin/env bash

# Get the LAN IP address
lan_ip=$(hostname -I | awk '{print $1}')

# Backup the original config.php file (add sudo for permissions)
sudo cp /mnt/Storage1/nextcloud/html/config/config.php /mnt/Storage1/nextcloud/html/config/config.php.bak

# Add the LAN IP to the config.php file (using sed for simpler editing)
sudo sed -i "s/0 => 'localhost'/0 => 'localhost'\n          1 => '$lan_ip'/" /mnt/Storage1/nextcloud/html/config/config.php

# Get the path to the docker-compose.yml file
COMPOSE_FILE="/var/lib/casaos/apps/big-bear-nextcloud/docker-compose.yml"

# Apply changes using casaos-cli (ensure correct appid)
sudo casaos-cli app-management apply "big-bear-nextcloud" --file="$COMPOSE_FILE"