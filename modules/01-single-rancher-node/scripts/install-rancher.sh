#!/bin/bash

sudo apt update && sudo apt upgrade
curl -sL https://releases.rancher.com/install-docker/${docker_version}.sh | sh
sudo usermod -aG docker ubuntu

docker run --privileged -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher