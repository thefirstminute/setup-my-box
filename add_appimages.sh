#!/bin/bash
echo "                   Setting Up Applications"
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
if [ -d "$APP_DIR" ]; then
  echo "$APP_DIR exists."
  echo "Assumed AppImageLauncher is installed"
else
  echo "Set up AppImageLauncher..."
  mkdir -p -- "$APP_DIR" || error "Failed to create ${APP_DIR} directory"
  echo "Created ~/Applications Directory"
  sudo add-apt-repository ppa:appimagelauncher-team/stable \
    || error "ERROR: Failed to add appimagelauncher-team/stable repo"
  echo "appimagelauncher-team/stable repo added"
fi
echo
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
