#!/bin/bash
echo "                   Installing Apt Packages"
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
sudo apt update
## add ppa's!?:
## opera
packs=''
while IFS= read -r line ; do
  ## TODO: smarter way to see if repos exist too...
  echo "install $line"
  packs+=" $line"
done < <(grep -v '#' pkgs_apt)
# FIXME: UNCOMMENT V
#apt install -y $packs
echo ""

echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
