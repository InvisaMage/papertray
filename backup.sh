#!/bin/bash
# Backup server directory
# Only tested on WSL: https://docs.microsoft.com/en-us/windows/wsl/install-win10
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
TAG="${BCYAN}[PaperTray Backup]${RESET} "

#Location backups are saved to
backupDir='/tmp/${server_name}-backups/'
backupDate=$(date +%Y-%m-%d)

#Overwrite default settings from papertray.conf
source papertray.conf

#Create folder
echo -e "${TAG}Custom message (blank for none)"
printf '> '
read -r message
echo -e "${TAG}Creating folder..."
mkdir -p "${backupDir}${server_name} ${backupDate}-m ${message}"

#Copy all files recursively in current directory while retaining file atrributes
echo -e "${TAG}Copying files into folder..."
cp -ar * "${backupDir}${server_name} ${backupDate}-m ${message}"
echo -e "${TAG}${GREEN}Done"