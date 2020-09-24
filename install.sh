#!/bin/bash

COLOR_NC='\e[0m' # No Color
COLOR_WHITE='\e[1;37m'
COLOR_BLACK='\e[0;30m'
COLOR_BLUE='\e[0;34m'
COLOR_LIGHT_BLUE='\e[1;34m'
COLOR_GREEN='\e[0;32m'
COLOR_LIGHT_GREEN='\e[1;32m'
COLOR_CYAN='\e[0;36m'
COLOR_LIGHT_CYAN='\e[1;36m'
COLOR_RED='\e[0;31m'
COLOR_LIGHT_RED='\e[1;31m'
COLOR_PURPLE='\e[0;35m'
COLOR_LIGHT_PURPLE='\e[1;35m'
COLOR_BROWN='\e[0;33m'
COLOR_YELLOW='\e[1;33m'
COLOR_GRAY='\e[0;30m'
COLOR_LIGHT_GRAY='\e[0;37m'
BOLD='\e[1m'
UNDERLINED='\e[4m'

echo
echo -e "$COLOR_RED"                                                                                                                                                    
echo "      .d888888  dP d888888P dP     dP dP         .d888888   888888ba  " 
echo "     d8'    88  88    88    88     88 88        d8'    88   88    '8b " 
echo "     88aaaaa88  88    88    88     88 88        88aaaaa88   88aaaa8P' " 
echo "     88     88  88    88    88     88 88        88     88   88   '8b. " 
echo "     88     88  88    88    Y8.   .8P 88        88     88   88    .88 " 
echo "     88     88  dP    dP    'Y88888P' 88888888P 88     88   88888888P " 
echo -e "$COLOR_BLUE"
echo
echo "                   https://github.com/aituglo/labyx"
echo

echo -e "$COLOR_BLUE"
echo "Checking for Docker installation"
echo -e "$COLOR_NC"

docker -v
if [ $? -ne 0 ]; then
    echo "Docker is currently not installed. Installing it ..."
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' | sudo tee /etc/apt/sources.list.d/docker.list
    sudo apt-get -y update
    sudo apt-get install -y docker-ce
    sudo service docker start
    echo "Docker is now installed !"
else
    echo "Docker is installed !"
fi

echo -e "$COLOR_BLUE"
echo "Cloning repository"
echo -e "$COLOR_NC"

git clone https://github.com/aituglo/labyx /opt/labyx
sudo chown -R $USER:$USER /opt/labyx
cd /opt/labyx

echo -e "$COLOR_BLUE"
echo "Building hacktulab docker"
echo -e "$COLOR_NC"

docker build -t hacktulab --build-arg GROUP_ID=$(id -g) --build-arg USER_ID=$(id -u) ./hacktulab

echo -e "$COLOR_BLUE"
echo "Moving labyx script to /usr/bin"
echo -e "$COLOR_NC"

sudo chmod +x lab
sudo mv lab /usr/bin/
sudo chown $USER:$USER /usr/bin/lab

echo -e "$COLOR_BLUE"
echo "Install finish, to run it please type lab"
echo -e "$COLOR_NC"



