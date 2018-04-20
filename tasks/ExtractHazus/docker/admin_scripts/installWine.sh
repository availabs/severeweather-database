#!/bin/bash

# http://www.linuxandubuntu.com/home/how-to-install-wine-and-run-windows-apps-in-linux

set -e

apt-get update
apt-get install -y software-properties-common python-software-properties curl

dpkg --add-architecture i386

apt-key add <(curl 'https://dl.winehq.org/wine-builds/Release.key')
apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/

apt-get update
# apt-get install -y --install-recommends winehq-stable
apt-get install -y winehq-stable
