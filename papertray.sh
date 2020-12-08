#!/bin/bash
# Paper Tray - Organize your PaperMC server: Backup, Trim, Update, Start
# Tested on Debian/Ubuntu systems and WSL: https://docs.microsoft.com/en-us/windows/wsl/install-win10
# Dependencies - jq (https://stedolan.github.io/jq/), curl, and Java
# Created by Travis Kipp

# README: If you don't know what this is, you probably should't be here. Edit the papertray.conf file only
# TODO: Add more checks and info for trimming | Add autorestart - wrap everything under loop | Add ability to disable features (Backup, Trim, Update)

#PaperMC Version
#Avialable versions: https://papermc.io/api/v1/paper
#!!!Ensure the version actually exists!!!
#When changing major versions, delete .pt_current_build.txt
version="1.16.4"
server_name="My Server"
advJavaArgs=false
debug=false

#Colors
RESET='\e[0m'
GREEN='\e[92m'
RED='\e[91m'
BCYAN='\e[36m\e[1m'
BWHITE='\e[97m'
YELLOW='\e[93m'
TAG="${BCYAN}[Paper Tray]${RESET} "

#Backup settings
#Location backups are saved to
backupDir="/tmp/${server_name}-backups/"
backupDate=$(date +%Y-%m-%d)
currentDate=$(date +%s)
trimDays=28
day=86400
trimBackups=true

#Overwrite default settings from papertray.conf
source papertray.conf

#Functions

#exit 1
exitScript() {
	echo -e  "${TAG}${RED}Exiting...${RESET}"
	exit 1
}

#Backup
backup() {
    #Create folder
	echo -e  "${TAG}Backing up server..."
    echo -e  "${TAG}Creating ${backupDir}${server_name} ${backupDate}"
	
	#Exit if cannot create backup dir (If previous command failed - exit)
	if mkdir -p "${backupDir}${server_name} ${backupDate}" ; then
		echo -e "${TAG}${GREEN}Created ${backupDir}${server_name} ${backupDate}"
	else
		echo -e "${TAG}${RED}Failed to create ${backupDir}${server_name} ${backupDate}"
		exitScript
	fi


    #Copy all files recursively in current dirrectory while retaining file atrributes
    echo -e  "${TAG}Copying files into ${backupDir}${server_name} ${backupDate}"
	
	if cp -ar * "${backupDir}${server_name} ${backupDate}" ; then
		echo -e  "${TAG}${GREEN}Backup completed"
		echo -e  $currentDate > .pt_last_backup.txt
	else
		echo -e "${TAG}${RED}Failed to create ${backupDir}${server_name} ${backupDate}"
		exitScript
	fi
}

#Trim
trim() {
    echo -e  "${TAG}${YELLOW}Trimming backups older than ${trimDays} days..."
    find "$backupDir" -mindepth 1 -maxdepth 1 -type d -mtime +${trimDays} -exec rm -rf {} +
    echo -e  "${TAG}${GREEN}Done"
}

#Online check
onlineCheck() {
    wget -q --spider https://papermc.io

    if [ $? -eq 0 ]; then
        echo -e  "${TAG}${GREEN}PaperMC online"
    else
        echo -e  "${TAG}${RED}Unable to connect to PaperMC"
		printf "${TAG}${YELLOW}Start server [Y/n]? ${RESET}"
		read -r answer
		if [ "$answer" = "" ] || [ "$answer" = "Y" ] || [ "$answer" = "y" ] ; then
		   startLoop
		else
		   exitScript
	    fi
    fi
}

#Start server jar and restart if crashes
#https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft/
startLoop() {
    if [ "$debug" = true ] ; then
	    echo -e  "${TAG}${YELLOW}Debugging mode enabled..."
		exitScript
	else
	    echo -e  "${TAG}Starting server..."
        while true; do
		    if [ "$advJavaArgs" = true ] ; then
		    	java -Xms4G -Xmx4G -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -Dusing.aikars.flags=mcflags.emc.gs -jar paper.jar nogui
		    else
			    java -jar paper.jar nogui
		    fi
            echo -e  "${TAG}Restart in ${GREEN}5 seconds. ${BWHITE}Ctrl + C to stop."
            sleep 5
	    done
    fi
}

#Get lastest build from PaperMC API
buildDownload() {
    curl -o paper.jar "https://papermc.io/api/v1/paper/${version}/latest/download"
	echo -e  $latest_build > .pt_current_build.txt
	echo -e  "${TAG}Downloaded lastest build"
}

#Get lastest build from Geyser API
geyserDownload() {
    curl -o plugins/geyser.jar "https://ci.nukkitx.com/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar"
	#echo -e  $latest_build > .pt_gy_current_build.txt
	echo -e  "${TAG}Downloaded lastest build of Geyser"
}

geyserFolder() {
    if [ -d "plugins" ]; then
	    echo -e  "${TAG}Plugins folder found"
        geyserDownload
	else
	    echo -e  "${TAG}${RED}Plugins folder not found"
	    mkdir -p "plugins"
		echo -e  "${TAG}Created plugins folder"
    fi
}

#Start
#Check if jq is installed
if type jq &>/dev/null ; then
    echo -e "${TAG}${RESET}jq is installed"
else
    echo -e "${TAG}${RED}jq is not installed"
	exitScript
fi

#Check if Java is installed
if which java &>/dev/null ; then
    echo -e "${TAG}${RESET}Java is installed"
else
    echo -e "${TAG}${RED}Java is not installed"
	exitScript
fi

#Check if Curl is installed
if which curl &>/dev/null ; then
    echo -e "${TAG}${RESET}Curl is installed"
else
    echo -e "${TAG}${RED}Curl is not installed"
	exitScript
fi

echo -e ""

#If last backup date file exists, continue, if not create file
if [ -f .pt_last_backup.txt ] ; then
	last_backup_date=$(cat .pt_last_backup.txt)
else
	echo -e  "${TAG}${RED}pt_backup_date.txt not found, ${RESET}creating file"
	echo -e  "0" > .pt_last_backup.txt
	last_backup_date=$(cat .pt_last_backup.txt)
	backup
fi

#If last backup date is older than 1 day, backup server
if [ $currentDate -gt $(($last_backup_date+$day)) ]; then
    echo -e  "${TAG}${YELLOW}Backup is older than ${day} seconds"
	backup
else
	echo -e  "${TAG}${YELLOW}Backup is current"
fi

#trim
if [ "$trimBackups" = true ] ; then
    trim
fi
onlineCheck

#If current build file exists, continue, if not create file
if [ -f .pt_current_build.txt ] ; then
    current_build=$(cat .pt_current_build.txt)
else
    echo -e  "${TAG}${RED}pt_current_build.txt not found, ${RESET}creating file"
	echo -e  "0" > .pt_current_build.txt
	current_build=$(cat .pt_current_build.txt)
fi

#Get lastest build information from PaperMC API
latest_build=$(curl -s https://papermc.io/api/v1/paper/${version}/latest | jq -r '.build')
echo -e  "${TAG}Got lastest build info"

#Manage Geyser
if [ "$manageGeyser" = true ] ; then
    geyserFolder
fi

#If current build is older than lastest build, download latest build and save to file
if [[ $current_build < $latest_build ]]; then
    echo -e  "${TAG}Downloading latest build..."
	buildDownload
	echo -e  "${TAG}${GREEN}Update completed"
	startLoop
else
    echo -e  "${TAG}${GREEN}You're already up to date"
	startLoop
fi