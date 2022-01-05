#!/bin/bash
echo "                  Cinnamon Desktop..."
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
echo
read -p "Load Cinnamon Desktop? NPM [y/N]? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  dconf load /org/cinnamon/ < cinnamon_desktop_dconf || error "ERROR: Failed to load cinnamon_desktop_dconf"
  echo "Cinnamon Desktop Settings Loaded"
fi
echo
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
