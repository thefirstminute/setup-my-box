#!/bin/bash

## Initial vars, reqs, logics and funcs {{{

## could probably make this echo out errors at the end...
warn() { \
  echo
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪ A BAD THING HERE ₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo
  echo
  printf "%s" "$1" >&2;
  echo
  echo
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo
}

error() { \
  echo
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo
  echo "Awe, You're not in the 3.6%"
  printf "%s" "$1" >&2;
  echo
  echo
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo
  exit 1;
}

if [ "$(id -u)" = 0 ]; then
    error "don't do this as root"
fi

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
# using 'proper' LAMP now...
# source install_xampp.sh
source install_lamp.sh # this has not actually been run/tested yet
source install_neovim.sh
source setup_dirs_end.sh
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
