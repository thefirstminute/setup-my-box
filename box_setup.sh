#!/bin/bash

## Initial vars, reqs, logics and funcs {{{
if [ "$(id -u)" = 0 ]; then
    echo "don't do this as root"
    exit 1
fi

error() { \
  echo
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo
  echo "Awe, You're not in the 3.6%"
  printf "%s" "$1" >&2;
  echo
  echo
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo
  exit 1;
}

dodis() { \
  dialog \
  --title "Are You Sure You Want To Do This?"\
  --yes-label "Roll The Dice"\
  --no-label "Play It Safe"\
  --yesno "We've got about a 3.6% chance of this thing working right..." 8 40  || error "Chicken Shit"
}
dodis || error "exited"
clear
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"

## this is where you can keep custom scripts etc.
MY_BIN=~/.config/mybin
## where you put your appimages
APP_DIR=~/Applications

## }}}

source setup_dirs.sh
source add_appimages.sh
source add_brave.sh
source install_aptpacks.sh
source install_flatpaks.sh
source install_pythons.sh
source install_entr.sh
source install_xampp.sh
source install_neovim.sh
source cinnamon_desktop_dconf.sh

echo "                            DONE"
## Done: {{{
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
echo ""
figlet "here we goooo" | lolcat
echo "(if that was colourful and fun, this might have actually worked)"

## TODO: could delete zips directory?
echo ""
## }}}
