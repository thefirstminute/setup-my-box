#!/bin/bash
echo "                Setting Up NeoVim Environment"
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"

read -p "Mess with NPM [y/N]? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo "     PROBABLY A BUNCH OF NPM ERRORS THAT DON'T MATTER"
  sudo apt install npm
  echo "          END OF NPM ERRORS THAT PROBABLY DON'T MATTER"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo ""

  sudo npm cache clean -f
  sudo npm install -g n
  sudo n stable

  ## HARDEN NPM AND YARN A BIT:
  # not quite sure how this works, commented for now.
  # yarn install --frozen-lockfile.
  # npm install package-lock.json
  # npm ci
fi

#just to be safe..
APP_DIR=~/Applications
echo "APP_DIR: ${APP_DIR}"
if [ ! -d "$APP_DIR" ]; then
  mkdir -p -- "$APP_DIR" || error "ERROR: Failed To Create Applications Directory"
fi

NVIM_APP="${APP_DIR}/nvim.appimage"
if [ -f "$NVIM_APP" ]; then
  echo "already had NeoVim App...Assuming we're good to go"
else
  echo "Download NeoVim..."

  cd ${APP_DIR}
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage || errof "ERROR: Could Not chmod nvim.appimage"

  set -u
  # sudo update-alternatives --install /usr/bin/ex ex "${NVIM_APP}" 110
  sudo update-alternatives --install /usr/bin/vi vi "${NVIM_APP}" 110
  sudo update-alternatives --install /usr/bin/view view "${NVIM_APP}" 110
  # sudo update-alternatives --install /usr/bin/vim vim "${NVIM_APP}" 110
  sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${NVIM_APP}" 110

  ## go back to whatever directory we were in
  cd -

  echo "Clone Vim Configs..."
  echo
  if [ -d ${HOME}/.config/nvim ]; then
      echo "~/.config/nvim exists...skipped git clone"
  else
    mkdir -p -- ${HOME}/.config/nvim || error "ERROR: Failed To Create NVIM DIRECTORY"

    git clone https://github.com/thefirstminute/vim.git ${HOME}/.config/nvim \
      || error "Failed to clone nvim git"

    echo "Cloned nvim git into ${HOME}/.config/nvim"
  fi
fi

echo ""
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
