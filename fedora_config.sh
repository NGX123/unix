#! /bin/bash

sudo dnf -y update

# RPM fusion
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf -y update

# Apps
sudo dnf install -y  terminator
sudo dnf install -y git
sudo dnf install -y gcc
sudo dnf install -y wireshark

sudo dnf install -y vlc
sudo dnf install -y libreoffice
sudo dnf install -y qbittorrent
sudo dnf install -y notepadqq

# VS code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf -y update
sudo dnf install -y code

#Google chrome
wget -P ~/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm 
sudo dnf install -y ~/Downloads/google-chrome*
rm ~/Downloads/google-chrome*

sudo dnf install -y logisim
sudo dnf install -y htop
sudo dnf install -y timeshift
sudo dnf install -y stacer
sudo dnf install -y steam
sudo dnf install -y clamav
sudo dnf install -y clamtk

#Stop Recreation of default folders
sudo nano /etc/xdg/user-dirs.conf

#Make the Directories
rm -rf ~/Music ~/Pictures ~/Public ~/Templates ~/Videos
mkdir ~/Files

#Make Folders
mkdir ~/Documents/
mkdir ~/Files/backups/
mkdir ~/Files/temp
mkdir ~/Files/code 
mkdir ~/Files/github
mkdir ~/.scripts

#Customize bash prompt
mv color.sh ~/.scripts 
cat ./source.sh >> ~/.bashrc

#Others
clear
echo "other changes in changes.txt"
echo "Shortcuts = switch desktops - meta + f(num); carry to desktop - ctrl + f(num); terminator - ctrl + alt + T" >> changes.txt
echo "System settings - Global theme" >> changes.txt
echo "Panel - Add widget - Icons only task manager" >> changes.txt

cat changes.txt
