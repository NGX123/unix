#! /bin/bash

## USER INPUT
read -p "Package Manager: " pm
read -p "Destktop Environment: " de
read -p "Configuration(y/n): " cnf

## Configuration ##
if [ $cnf == y ]; then
    #Variables
    read -p "Install cmd: " inst
    read -p "Remove cmd: " rmc
    read -p "Update cmd: " up
    
    read -p "Remove bloat(Not recommended for gnome)(y/n): " bloat
    read -p "Remove Folders(y/n): " fldrs
fi

### Config for APT ###
if [ $pm == apt ]; then
    inst = install
    rmc = purge
    up = upgrade
fi

## Config for DNF ##
if [ $pm == dnf ]; then
    #Variables
    inst = install
    rmc = remove
    up = update
    
    #RPM Fusion
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf -y update
    
    # VS code
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf -y update
    sudo dnf install -y code
fi

sudo $pm -y $up

## INSTALLING PROGRAMMS ##
#Programm Lists
osdev=( binutils gcc build-essential diffutils )
apps=( terminator mpv qbittorrent git chromium )

for item in "${apps[@]}"
do
    sudo $pm $inst -y $item
done


## CONFIGURATION ##
#Make Folders
mkdir ~/Files ~/src ~/.scripts ~/Files/backups/ ~/Files/code ~/Files/github

## Terminal Configurations ##
cp -r ./scripts/* ~/.scripts
echo '[ -f $HOME/.scripts/bash_scripts/color.sh ] && . $HOME/.scripts/bash_scripts/color.sh' >> ~/.bashrc
echo '[ -f $HOME/.scripts/bash_aliases.sh ] && . $HOME/.scripts/bash_aliases.sh' >> ~/.bashrc




### OPTIONAL ###
## Remove Bloat ##
kde_bloat=( calligra-sheets calligra-stage calligra-words dragon juk k3b kamoso kmail kaddressbook kamera kget ktorrent kmahjongg kmines kolourpaint kpat kwalletmanager kde-connect kdeconnect konqueror krdc )
gnome_bloat=( gnome-maps gnome-screenshot gnome-calendar cheese gnome-contacts rhythmbox totem gnome-weather gnome-photos simple-scan gedit )

if [ $bloat == y ]; then 
    if [ $de == kde ]; then
        for app in "${kde_bloat[@]}"
        do
            sudo $pm $rmc -y $app
        done
    fi

    if [ $de == gnome ]; then
        for app in "${gnome_bloat[@]}"
        do
            sudo $pm $rmc -y $app
        done
    fi
fi

## Default Folders
if [ $fldrs == y ]; then
    less ./scripts/bash_scripts/dirs > ~/.config/user-dirs.dirs
    rm -rf ~/Music ~/Pictures ~/Public ~/Templates ~/Videos
fi

#KDE GUI
if [ $de == kde ]; then
    clear
    echo "other changes in changes.txt
    Shortcuts = switch desktops - meta + f(num); carry to desktop - ctrl + f(num); terminator - ctrl + alt + T
    System settings - Global theme
    Configure Desktop -Change Wallapaper
    System settings - Energy Saving - Change
    System settings - Applications - Change default applications
    Screen Locking - change wallpaper, lock time
    Panel - Add widget - Icons only task manager
    Panel - Configure panel - remove show desktop
    Panel - Lock widgets" >> changes.txt
    cat changes.txt
fi

# Gnome GUI
if [ $de == gnome ]; then
    clear
    echo "
    Tweaks
    General - Suspend when laptop lid is closed, turn off animations
    Appearance - Applications(Adwaita-dark)
    Extensions - Turn off. Install: TopIcons(system tray)
    Keyboard & mouse - Mouse click emulation set to area(OPTIONAL)
    Windows Titlebars - Titlebar Buttons - Turn on minimize and maximize
    
    
    Settings
    Notifications - manage notifications
    Search - Turn off search(application search stays)
    Privacy - Turn off everything except Screen Lock 
    Power - Automatic suspend, blank screen, dim when inactive
    Devices - Keyboard Shortcuts - Set
    Details - Default Apps - Set" >> changes.txt
    cat changes.txt
fi


