#!/bin/bash

# Disable terminal bell and cursor blinking in 
#	Terminal -> Edit -> Preferences -> Unnamed -> Text
#
# Fix scrolling in 
#	Settings -> Devices -> Mouse and Touchpad -> Touchpad -> Natural Scrolling
#
# Fix capslock mapping by installing gnome-tweak-tool and running gnome-tweaks.
# 	Keyboard and Mouse -> Additional Layout Options
#
# Due to Google API weirdness, it's easier just to download the files in this 
# google drive manually (including this script).  Make sure they're all in the
# same directory.
#
# hw.tar.bz2
# https://drive.google.com/open?id=1_NHXPPrpf1INKPXVxpithvWH8tmy7nWE
#
# libvariorum-prerelease.tar.bz2
# https://drive.google.com/open?id=1nAM3-3Wpr_Osc5rYYSCv6ajP8tiInVZt
#
# msr-safe.tar.bz2
# https://drive.google.com/open?id=1uHJKqvlp_W940eIymvoZlRD13QinG0rj


# Pull in a few extra packages
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update
sudo apt-get install apt-get install gnome-tweak-tool vim-nox msr-tools cmake libhwloc-dev sublime-text


# Set up msr-safe
tar -jxvf msr-safe.tar.bz2
cd msr-safe
make
sudo insmod ./msr-safe.ko
sudo chown ubuntu.ubuntu /dev/cpu/msr_*
sudo chown ubuntu.ubuntu /dev/cpu/*/msr_safe
cd ..

# Set up the stock msr kernel module
sudo modprobe msr
sudo chown ubuntu.ubuntu /dev/cpu/*/msr

# Move a couple of directories over from /root
sudo cp -r /root/Intel_docs .
sudo chown -R ubuntu.ubuntu ./Intel_docs
sudo cp -r /root/FIRESTARTER .
sudo chown -R ubuntu.ubuntu ./FIRESTARTER

# Set up FIRESTARTER
cd FIRESTARTER
./code-generator.py
make
cd ..

# Set up Hello, world!
tar -jxvf hw.tar.bz2
cd hw
make clean
make hw
make interpose
cd ..

# Set up libvariorum
tar -jxvf libv*.tar.bz2
cd lib*m
mkdir build && mkdir install
cd build
cmake -DCMAKE_INSTALL_PREFIX=../install ../src
make 
make install

