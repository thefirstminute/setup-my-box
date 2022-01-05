#!/bin/bash
echo "                      My Dirs & Such"
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"

## make sure mybin exists for my junk...
if [ ! -d "${MY_BIN}" ]; then
  mkdir -p -- ${MY_BIN} || error "ERROR: Failed To Create ${MY_BIN}"
  echo "${MY_BIN} created."
fi

## TODO:
## vim snippets and templates:
## Grab my bash_aliases from github

if [ ! -f ${MY_BIN}/koad_command.sh ];
then
  touch ${MY_BIN}/koad_command.sh  || error "ERROR: Failed to create koad_command.sh"
  sudo chmod 775 ${MY_BIN}/koad_command.sh  || error "ERROR: Failed to chmod 775 koad_command.sh"
  echo "Created koad_command.sh"
fi

## Add my cows and fortunes:
## TODO: fortunes
if [ ! -f /usr/share/cowsay/cows/kow.cow ];
then
  sudo cp zips/kows/*.cow /usr/share/cowsay/cows/  || error "ERROR: Failed to copy cows"
  echo "Copy Kows"
fi

echo ""
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"

