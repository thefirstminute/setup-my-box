#!/bin/bash 
echo "                    Setting Up LAMP"
echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"

  # sudo apt install ${line} -y || warn "Failed to install ${line}"
read -p "Do You Want LAMP [y/N]? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "                       Setup apache2"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  sudo apt install apache2 -y || warn "Failed To install apache2"
  sysctl start apache2 || warn "Failed To start apache2"
  sysctl status apache2


  echo "                    End of apache2 setup"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"


  echo "                       Setup mariadb"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  sudo apt install mariadb-server -y || warn "Failed To install mariadb-server"
  sysctl start mariadb || warn "Failed To start mariadb"
  sysctl status mariadb

  echo " ### mysql_secure_installation; just say yes, and set a 'strong' password ;)"
  mysql_secure_installation

  echo "                    End of mariadb setup"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"


  echo "                       Setup PHP"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"
  sudo apt install php libapache2-mod-php php-mysql -y || warn "Failed To install PHP"
  sysctl restart apache2 || warn "Failed To restart apache2"

  sudo apt install phpmyadmin

  echo "                    End of PHP"
  echo "₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪"

fi


