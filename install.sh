#!/bin/bash


##################################################
## Author - DN-debug
## Description - Peux Xmonad setup via fetcher app
##################################################

# Install packages

if zenity --question --text="Install Xmonad?"
then 

    PASSWD="$(zenity --password --title=Authentication)\n"

    pkg="$(pacman -Qq | grep xmonad)"

    if [ "${pkg}" = "xmonad" ]; then
        notify-send "Xmonad is already installed. Skipping!"   
    else 
        echo -e $PASSWD | sudo -S pacman -Syu xmonad xmonad-contrib
        notify-send "installed Xmonad"
    fi
    if zenity --question --text="Install Tint2 Panel?"
    then 
        pkg1="$(pacman -Qq | grep tint2)"
        if [ "${pkg1}" = "tint2" ]; then
            notify-send "Tint2 is already installed. Skipping!"
        else
            echo -e $PASSWD | sudo -S pacman -Syu tint2
            notify-send "installed Tint2"
        fi
    fi
    if zenity --question --text="Install Rofi?"
    then 
        pkg1="$(pacman -Qq | grep rofi | tail -n1)"
        if [ "${pkg1}" = "rofi" ]; then
            notify-send "Rofi is already installed. Skipping!"
        else
            echo -e $PASSWD | sudo -S pacman -Syu rofi
            notify-send "installed Rofi"
        fi
    fi

else
    notify-send "skipping Xmonad installation!"
fi

# copy configurations

if zenity --question --text="Want to copy the configurations?"
then 
    echo "changing directory"
    cd ../
    sudo -S cp -r Peux-Xmonad/tint2/ $HOME/.config/
    sudo -S cp -r Peux-Xmonad/rofi/ $HOME/.config/
    sudo -S cp -r Peux-Xmonad/.xmonad/ $HOME/
    notify-send "Copied the configurations"
else
    notify-send "skipping the setup!"
fi

# cleanup

rm -rf /tmp/fetcher/Peux-Xmonad
notify-send "Done!"