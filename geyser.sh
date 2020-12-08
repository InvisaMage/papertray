#!/bin/bash
# Install and update GeyserMC: https://geysermc.org/
# Tested on Debian/Ubuntu systems and WSL: https://docs.microsoft.com/en-us/windows/wsl/install-win10
# Dependencies - jq (https://stedolan.github.io/jq/), curl, and Java
# Created by Travis Kipp

#Colors
RESET='\e[0m'
GREEN='\e[92m'
RED='\e[91m'
BCYAN='\e[36m\e[1m'
BWHITE='\e[97m'
YELLOW='\e[93m'
TAG="${BCYAN}[Paper Tray]${RESET} "

#Overwrite default settings from papertray.conf
source papertray.conf

onlineCheck() {
    wget -q --spider https://ci.nukkitx.com

    if [ $? -eq 0 ]; then
        echo -e  "${TAG}${GREEN}GeyserMC Build Server online"
    else
        echo -e  "${TAG}${RED}Unable to connect to GeyserMC Build Server"
		printf "${TAG}${YELLOW}Start server [Y/n]? ${RESET}"
		read -r answer
		if [ "$answer" = "" ] || [ "$answer" = "Y" ] || [ "$answer" = "y" ] ; then
		   startLoop
		else
		   exitScript
	    fi
    fi
}

folderCheck() {
    if [ -d "plugins" ]; then
	    echo -e  "${TAG}Plugins folder found"
        geyserDownload
	else
	    echo -e  "${TAG}${RED}Plugins folder not found"
	    mkdir -p "plugins"
		echo -e  "${TAG}Created plugins folder"
    fi
}

#Get lastest build from Geyser API
geyserDownload() {
    curl -o plugins/geyser.jar "https://ci.nukkitx.com/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar"
	#echo -e  $latest_build > .pt_gy_current_build.txt
	echo -e  "${TAG}Downloaded lastest build of Geyser"
}

#exit 1
exitScript() {
	echo -e  "${TAG}${RED}Exiting...${RESET}"
	exit 1
}

onlineCheck
folderCheck
