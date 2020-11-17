#!/bin/bash
# Trims old backups
# Only tested on WSL: https://docs.microsoft.com/en-us/windows/wsl/install-win10
# Requires jq: https://stedolan.github.io/jq/
# Created by Travis Kipp

# TODO: 
server_name="mc-server"

#Colors
RESET='\e[0m'
GREEN='\e[92m'
RED='\e[91m'
BCYAN='\e[36m\e[1m'
BWHITE='\e[97m'
YELLOW='\e[93m'
TAG="${BCYAN}[Trim]${RESET} "

days=‭‬14
backupDir="/tmp/${server_name}-backups/"

#Delete files on
echo -e  "${TAG}${YELLOW}Trimming backups older than 14 days..."
find "$backupDir" -mindepth 1 -maxdepth 1 -type d -mtime +14 -exec rm -rf {} +
echo -e  "${TAG}${GREEN}Done"

#touch -d "2 weeks ago" filename
#stat -c %Y

#find "/mnt/e/VR Backups/Testing/" -type d -mtime +18 -exec rm -rf {} +