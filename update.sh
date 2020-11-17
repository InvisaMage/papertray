#!/bin/sh
# Update script for PaperMC
# Run from WSL, requires jq
# Created by Travis Kipp

#Colors
RESET='\033[0m'
GREEN='\033[0;32m'
RED='\033[0;31m'
BCYAN='\033[1;36m'
TAG="${BCYAN}[PaperMC Updater]${RESET} "

#If current build file exists, continue, if not create file
if [ -f current_build.txt ] ; then
    current_build=$(cat current_build.txt)
else
    echo "${TAG}${RED}current_build.txt not found, ${RESET}creating file"
	echo "0" > current_build.txt
	current_build=$(cat current_build.txt)
fi

#Get lastest build from PaperMC API
latest_build=$(curl -s https://papermc.io/api/v1/paper/1.16.4/latest | jq -r '.build')


#If current build is older than lastest build, download latest build and save to file
if [ $current_build -lt $latest_build ]; then
    echo "${BCYAN}[PaperMC Updater]${RESET} Downloading latest build..."
	curl -o paper.jar https://papermc.io/api/v1/paper/1.16.4/latest/download
	echo $latest_build > current_build.txt
	echo "${TAG}${GREEN}Update completed"
else
    echo "${TAG}${GREEN}You're already up to date"
fi