#!/usr/bin/env bash

# Install python face_recognition library on RPi
# https://gist.github.com/ageitgey/1ac8dbe8572f3f533df6269dab35df65

# Auto enable PiCamera (can also be done with "raspi-config" command)
grep "start_x=1" /boot/config.txt
if grep "start_x=1" /boot/config.txt; then
  echo "PiCamera already enabled, no need to enable it again."
else
  sed -i "s/start_x=0/start_x=1/g" /boot/config.txt
  echo "Reboot will be necessary in order to use the PiCamera."
fi

# Update and upgrade already installed packages
sudo apt-get update
sudo apt-get upgrade

# Install required libraries
sudo apt-get --yes --force-yes install build-essential \
  cmake \
  gfortran \
  git \
  wget \
  curl \
  graphicsmagick \
  libgraphicsmagick1-dev \
  libatlas-dev \
  libavcodec-dev \
  libavformat-dev \
  libboost-all-dev \
  libgtk2.0-dev \
  libjpeg-dev \
  liblapack-dev \
  libswscale-dev \
  pkg-config \
  python3 \
  python3-dev \
  python3-numpy \
  python3-pip \
  zip
sudo apt-get clean

# Add handling of picamera too
sudo apt-get install python3-picamera
sudo pip3 install --upgrade picamera[array]

# Temporarily enable a larger swap file size (so the dlib compile won't fail due to limited memory)
sudo sed -i '/CONF_SWAPSIZE=100/c\CONF_SWAPSIZE=1024' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile restart

# Download and install dlib v19.7
mkdir -p dlib
git clone -b 'v19.7' --single-branch https://github.com/davisking/dlib.git dlib/
cd ./dlib
sudo python3 setup.py install
cd ..
rm -rf dlib

# Install face_recognition
sudo pip3 install face_recognition

# Revert the swap file size change now that dlib is installed
sudo sed -i '/CONF_SWAPSIZE=1024/c\CONF_SWAPSIZE=100' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile restart
