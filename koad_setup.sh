#!/bin/bash

## Initial vars, reqs, logics and funcs {{{
if [ "$(id -u)" = 0 ]; then
    echo "You probably don't want to do this as root"
    exit 1
fi

error() { \
    clear; printf "ERROR:\%s\\n" "$1" >&2; exit 1;
}

dodis() { \
    dialog \
    --title "Are You Sure You Want To Do This?"\
    --yes-label "Roll The Dice"\
    --no-label "Play It Safe"\
    --yesno "We've got about a 3.6% chance of this thing working right..." 8 40  || { clear; exit 1; }
}
dodis || error "exited"
clear

## make sure mybin exists for my junk...
MY_BIN=~/.config/mybin
if [ ! -d "$MY_BIN" ]; then
  mkdir -p -- ${MY_BIN} || error "ERROR: Failed To Create $MY_BIN"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo "           $MY_BIN created."
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
fi

## Add my cows and fortunes:


echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
## }}}


echo "                  Setting Up Entr(1)"
## {{{
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
## https://github.com/eradman/entr
## http://eradman.com/entrproject/
## check for Entr(1)
if ! command -v entr &> /dev/null
then
  echo "entr(1) not installed..."
  ## check if we have the zip:

  if [ -f "entr-master.zip" &&  ! -d "entr-master" ]; then
    unzip entr-master.zip || error "ERROR: could not unzip entr-master.zip"
    echo "entr-master - unzipped"

    cd entr-master || error "ERROR: failed to cd into entr-master"
    make test error || "ERROR: failed entr-master make test"
    sudo make install || error "ERROR: failed entr-master make install"

    cd ..

    cp refreshr ${MY_BIN}
  fi

  ## if we've got the directory go install it
  if [ -d "entr-master" ]; then
    cd entr-master || error "ERROR: failed to cd into entr-master"
    ./configure || error "ERROR: ./configure failed"
    make test error || "ERROR: failed entr-master make test"
    sudo make install || error "ERROR: failed entr-master make install"
    cd ..
    cp refreshr ${MY_BIN}
  fi

else 
  echo "~~ Entr(1) is already installed"
fi
echo ""
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
## }}}


echo "                   Setting Up Applications"
## {{{
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
APP_DIR=~/Applications
if [ -d "$APP_DIR" ]; then
  echo "$APP_DIR exists."
  echo "Assumed AppImageLauncher is installed"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo "                    Updating Apt Packages"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  # FIXME:
  # sudo apt update || error "ERROR: Could not update packages"
else
  echo "Set up AppImageLauncher..."
  echo "Create ~/Applications Directory"
  mkdir -p -- "~/Applications"
  sudo add-apt-repository ppa:appimagelauncher-team/stable
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  echo "                    Updating Apt Packages"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  sudo apt update || error "ERROR: Could not update packages"

  sudo apt install appimagelauncher || error "Error: Could Not Install AppImageLauncher"
fi
echo ""
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
## }}}


echo "                  Installing Apt Packages"
## {{{
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
## need to add ppa's:
## opera
## brave
## bpytop

packs=''
while IFS= read -r line ; do
  ## TODO: smarter way to see if repos exist too...
  echo "install $line"
  packs+=" $line"
done < <(grep -v '#' pkgs_apt)
echo ${packs}
# apt install -y $packs
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
exit
## }}}


echo "                      Installing Flatpaks"
## {{{
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"

packs=''
while IFS= read -r line ; do
  ## TODO: smarter way to see if repos exist too...
  echo "install $line"
  packs+=" $line"
done < <(grep -v '#' pkgs_flathub)
flatpak install flathub $packs


echo ""
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
## }}}


echo "                       Setting XAMPP"
## {{{
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
echo ""
# check if we already have xampp
XAMPP_DIR=/opt/lampp
if [ -d "$XAMPP_DIR" ]; then
  echo "$XAMPP_DIR exists."
  echo "Assumed XAMPP is installed"

else
  XAMPP_RUN="xampp-linux-x64-7.4.26-0-installer.run"
  if [ -f "$XAMPP_RUN" ]; then
    echo "Install From File: ${XAMPP_RUN}"
    sudo chmod 755 ${XAMPP_RUN}
    sudo ./${XAMPP_RUN} || error "ERROR: Failed to install XAMPP from ${XAMPP_RUN}"

    ## XAMPP is now installed in the /opt/lampp
    ## ... but you can't do shit, yet.
    ## change permissions of "server":
    sudo chmod -R 755 /opt/lampp/htdocs/
    ## change ownership:
    myname=`whoami` && mygroup=`id -gn`
    sudo chown –R $myname:$mygroup /opt/lampp/htdocs

    mkdir /opt/lampp/htdocs/www || error "ERROR: Failed To Create www Directory"
    echo "mkdir /opt/lampp/htdocs/www"

    ## you can also edit this file to point to www instead of dashboard
    ## TODO: make a smart way to show dialogue and either open vim or not:
    ₪ vim /opt/lampp/htdocs/index.php
    ₪change	header('Location: '.$uri.'/dashboard/');
    ₪to     header('Location: '.$uri.'/www/');

    sudo chmod 544 ${XAMPP_RUN}

  else
    ## TODO: could allow input for file...
    echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
    echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
    echo "                   Missing XAMPP Install File"
    echo " ~~ ${XAMPP_RUN}"
    echo "                    DID NOT INSTALLL XAMPP!!"
    echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
    echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  fi

fi

echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
## }}}


echo "                Setting Up NeoVim Environment"
## {{{
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"

## FIXME: uncomment this when you're live again
# echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
# echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
# echo "     PROBABLY A BUNCH OF NPM ERRORS THAT DON'T MATTER"
# echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
# echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
# sudo apt install npm
# echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
# echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
# echo "          END OF NPM ERRORS THAT PROBABLY DON'T MATTER"
# echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
# echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
# sudo npm cache clean -f
# sudo npm install -g n
# sudo n stable

## HARDEN NPM AND YARN A BIT:
# not quite sure how this works, commented for now.
# yarn install --frozen-lockfile.
# npm install package-lock.json
# npm ci

## just make sure Applications is installed again, incase we're skipping $₪!+
if [ ! -d "$APP_DIR" ]; then
  mkdir -p -- "~/Applications" || error "ERROR: Failed To Create Applications Directory"
fi

## DO THIS LAST...`
NVIM_APP="${APP_DIR}/nvim.appimage"
if [ -f "$NVIM_APP" ]; then
  echo "already had NeoVim App..."

else
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage ${APP_DIR}
  chmod u+x ${NVIM_APP} || errof "ERROR: Could Not chmod ${NVIM_APP}"

  set -u
  sudo update-alternatives --install /usr/bin/ex ex "${NVIM_APP}" 110
  sudo update-alternatives --install /usr/bin/vi vi "${NVIM_APP}" 110
  sudo update-alternatives --install /usr/bin/view view "${NVIM_APP}" 110
  # sudo update-alternatives --install /usr/bin/vim vim "${NVIM_APP}" 110
  sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${NVIM_APP}" 110

  NVIM_DIR=~.config/nvim
  if [ -d "$NVIM_DIR" ]; then
      echo "$NVIM_DIR exists...skipped git clone"
  else
    mkdir -p -- "${NVIM_DIR}" || error "ERROR: Failed To Create NVIM DIRECTORY"
    echo "Create $NVIM_DIR"
    git clone https://github.com/thefirstminute/vim.git ~/.config/nvim
  fi

fi


echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
## }}}


echo "                            DONE"
## Done: {{{
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
echo ""
figlet "here we goooo" | lolcat
echo "(if that was colourful and fun, this might have actually worked)"
echo ""
## }}}
