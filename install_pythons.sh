#!/bin/bash
echo "                     Installing Pythons"
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
packs=''
while IFS= read -r line ; do
  ## TODO: smarter way to see if repos exist too...
  echo "install $line"
  packs+=" $line"
done < <(grep -v '#' pkgs_python)
# need this custom command in linux mint:
pip3 install --ignore-installed psutil
pip3 install $packs
echo ""
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
