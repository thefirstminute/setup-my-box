#!/bin/bash
echo "                       Setting XAMPP"
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
echo ""
# check if we already have xampp
XAMPP_DIR=/opt/lampp
if [ -d "$XAMPP_DIR" ]; then
  echo "$XAMPP_DIR exists."
  echo "Assumed XAMPP is installed"

  if [ -w "/opt/lampp/htdocs" ]; then
    echo "htdocs IS WRITABLE -> should be good to go";
  else
    echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
    echo "                   htdocs NOT WRITABLE";
    echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"

    sudo chmod -R 755 /opt/lampp/htdocs/  || error "ERROR: Could Not Change htdocs permissions"
    ## change ownership:
    myname=`whoami` && mygroup=`id -gn`
    sudo chown –R $myname:$mygroup /opt/lampp/htdocs  || error "ERROR: could not change htdocs ownership"
  fi

else
  echo "pwd: $(pwd)"
  XAMPP_RUN="zips/xampp-linux-x64-7.4.26-0-install.run"

  if [ -f "$XAMPP_RUN" ]; then
    echo "Install From File: ${XAMPP_RUN}"
    sudo chmod 755 ${XAMPP_RUN}
    sudo ./${XAMPP_RUN} || error "ERROR: Failed to install XAMPP from ${XAMPP_RUN}"

    ## XAMPP is now installed in the /opt/lampp
    ## ... but you can't do shit, yet.
    ## change permissions of "server":
    sudo chmod -R 755 /opt/lampp/htdocs/  || error "ERROR: Could Not Change htdocs permissions"
    ## change ownership:
    myname=`whoami` && mygroup=`id -gn`

    echo "myname: ${myname} mygroup: ${mygroup}"
    sudo chown –R ${myname}:${mygroup} /opt/lampp/htdocs  || error "ERROR: could not change htdocs ownership"

    mkdir /opt/lampp/htdocs/www || error "ERROR: Failed To Create www Directory"
    echo "mkdir /opt/lampp/htdocs/www"

    ## you can also edit this file to point to www instead of dashboard
    ## TODO: make a smart way to show dialogue and either open vim or not:
    # vim /opt/lampp/htdocs/index.php
    # change	header('Location: '.$uri.'/dashboard/');
    # to     header('Location: '.$uri.'/www/');

    sudo chmod 544 ${XAMPP_RUN}

  else
    error "ERROR: Missing XAMPP Install File"
  fi

fi

echo ""
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
