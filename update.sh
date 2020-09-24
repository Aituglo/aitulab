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

echo -e "$COLOR_RED"
echo "   dP     dP  888888ba  888888ba   .d888888  d888888P  88888888b " 
echo "   88     88  88    '8  88    '8b d8'    88     88     88        " 
echo "   88     88  88aaaa8P' 88     88 88aaaaa88     88     88aaaa    " 
echo "   88     88  88        88     88 88     88     88     88        " 
echo "   Y8.   .8P  88        88    .8P 88     88     88     88        " 
echo "   'Y88888P'  dP        8888888P  88     88     dP     88888888P " 
echo -e "$COLOR_NC"                                                                                            

# Lab update script
echo -e "$COLOR_BLUE"
echo "Upgrading labyx"
echo -e "$COLOR_NC"
## Upgrade the hacktulab image

docker build -t hacktulab --build-arg GROUP_ID=$(id -g) --build-arg USER_ID=$(id -u) ./hacktulab

## Upgrade all docker image

docker images |grep -v REPOSITORY|awk '{print $1}'|xargs -L1 docker pull 

## Changing lab

cp ./lab /usr/bin/lab
echo -e "$COLOR_BLUE $UNDERLINED $BOLD"
echo "Upgrade Done ! Happy Hacking !"