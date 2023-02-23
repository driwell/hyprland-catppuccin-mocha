#!/bin/bash

echo "IMPORTANT!!! MANDATORY READ BEFORE CONTINUING!"
echo "    DISCLAIMER: The creator is not responsible for anything this script might do."
echo
echo
echo "    This script was put together in a few hours and only tested a few times on a single machine, so weird stuff might happen."
echo "    In it's current form it works for the creator."
echo "    However in theory it should work for other users given they have the software to be configured installed."
echo "    In the case the software is not installed this should not stop the proccess from function beyound throwing a few errors along the way since it looks for certain things to backup."
echo "    If they are not available it just fails to back them up which should not be an issue as it continues backing up what it's available."
echo
echo
echo "    Something to note is that you will require 'rsync' and 'stow' (popular standard tools) in order for this to work."
echo "    If you don't the process will ask you to install them before running again."
echo "    I also advise you to take a look at the scrips and probably remove what you don't want, special attention to the fact this replaces your ZSH files if you use that."
echo "    Meaning environments variables, etc, but the ones I use in these files are standard."
echo "    Also, to avoid weird stuff just close your WM and run this on the TTY instead. You will have to close and open Hyprland anyway for certain stuff to kick in."
echo
echo "    In case you can't read this script you should probably not run it."
echo "    Besides, installing and tweaking manually is interesting the first few times."
echo
echo
echo "    By running this you confirm you have read the above."
echo
echo -n  "Accept and run it anyway? (N/y): "
read RUN
echo

if [[ $RUN == "y" ]]
then
  echo "Starting..."
  echo
else
  echo "Stopping..."
  echo
  exit 1
fi

# Check for dependencies
if ! command -v rsync --version &> /dev/null
then
    echo "Error:"
    echo "    'rsync' could not be found."
    echo "    'rsync' is required in order to backup your current configs."
    echo "    Install 'rsync' with your package manager before running the script."
    exit 1
fi

if ! command -v stow --version &> /dev/null
then
    echo "Error:"
    echo "    'stow' could not be found."
    echo "    'stow' is required in order to create symlinks for installation."
    echo "    Install 'stow' with your package manager before running the script."
    exit 1
fi

# Check for existance of previous backup
if [ -d "bak" ] 
then
    echo
    echo "Error:"
    echo "    Directory 'bak' already exists."
    echo "    Installation canceled as a safety measure."
    echo "    Review the contents of 'bak' and make sure you don't need it."
    echo "    Then delete it and run the process again."
    exit 2
fi

# Make a backup of current system
echo -n "Backing up files into the 'bak' directory... "
rsync -aRL --delete ~/.config/hypr bak/
rsync -aRL --delete ~/.config/waybar bak/
rsync -aRL --delete ~/.config/kitty bak/
rsync -aRL --delete ~/.config/bottom bak/
rsync -aRL --delete ~/.config/dunst bak/
rsync -aRL --delete ~/.config/cava bak/
rsync -aRL --delete ~/.config/wofi bak/
rsync -aRL --delete ~/.config/neofetch bak/
rsync -aRL --delete ~/.swaylock bak/
rsync -aRL --delete ~/.p10k.zsh bak/
rsync -aRL --delete ~/.zshrc bak/
rsync -aRL --delete ~/.zshenv bak/
echo "Done"

echo
echo "In case something goes wrong your original configs were copied to a folder called 'bak' in the current directory."
echo
echo -n "Continue? (N/y): "
read CONTINUE
echo

if [[ $CONTINUE == "y" ]]
then
  echo "Installing..."
  echo
else
  echo "Stopping..."
  echo
  exit 1
fi

# Install configs
echo -n "Installing hyprland configs... "
rm -rf ~/.config/hypr
stow hyprland
echo "Done"

echo -n "Installing waybar configs... "
rm -rf ~/.config/waybar
stow waybar
echo "Done"

echo -n "Installing kitty configs... "
rm -rf ~/.config/kitty
stow kitty
echo "Done"

echo -n "Installing bottom configs... "
rm -rf ~/.config/bottom
stow bottom
echo "Done"

echo -n "Installing dunst configs... "
rm -rf ~/.config/dunst
stow dunst
echo "Done"

echo -n "Installing cava configs... "
rm -rf ~/.config/cava
stow cava
echo "Done"

echo -n "Installing wofi configs... "
rm -rf ~/.config/wofi
stow wofi
echo "Done"

echo -n "Installing neofetch configs... "
rm -rf ~/.config/neofetch
stow neofetch
echo "Done"

echo -n "Installing swaylock configs... "
rm -rf ~/.swaylock
stow swaylock
echo "Done"

echo -n "Installing zsh configs... "
rm -rf ~/.p10k.zsh
rm -rf ~/.zshrc
rm -rf ~/.zshenv
stow zsh
echo "Done"

echo
echo "The installation was successful. Have fun!"

exit 0