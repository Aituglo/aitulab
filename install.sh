#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Checking for Docker installation"

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

echo "Cloning repository"

git clone https://github.com/aituglo/aitulab aitulab
cd aitulab

echo "Building hacktulab docker"

sudo docker build -t hacktulab --build-arg GROUP_ID=$(id -g) --build-arg USER_ID=$(id -u) ./hacktulab

echo "Moving aitulab script to /usr/bin"

sudo chmod +x aitulab
sudo mv aitulab /usr/bin/

echo "Install finish, to run it please type aitulab"


