#!/bin/bash

# Lab update script

echo "Upgrading aitulab"

## Upgrade the hacktulab image

docker build -t hacktulab --build-arg GROUP_ID=$(id -g) --build-arg USER_ID=$(id -u) ./hacktulab

## Upgrade all docker image

docker images |grep -v REPOSITORY|awk '{print $1}'|xargs -L1 docker pull 

## Changing lab

cp ./lab /usr/bin/lab

echo "Upgrade Done ! Happy Hacking !"