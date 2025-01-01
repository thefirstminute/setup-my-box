#!/bin/bash

# This script automates the setup of a local web development environment on Debian-based systems

# Run this script as sudo ie: $sudo ./setup_apache_server.sh

# Function to install a package if it's not already installed
install_package() {
    if ! dpkg -l | grep -q "$1"; then
        echo "Installing $1..."
        sudo apt-get install -y "$1"
    else
        echo "$1 is already installed."
    fi
}

# Ask if the current user should be used as the DEV_USER
echo "Would you like to use $SUDO_USER as the web dev? (y/N)"
echo "(this will be used for MySQL and filesystem permissions)"

read -r USE_CURRENT_USER

if [[ "$USE_CURRENT_USER" == "y" || "$USE_CURRENT_USER" == "Y" ]]; then
    DEV_USER=$SUDO_USER
else
    echo "Enter the desired username:"
    read DEV_USER
fi

# Prompt for MySQL root user credentials
echo "Please enter the MySQL root password:"
read -s MYSQL_ROOT_PASSWORD
echo "Please re-enter the MySQL root password:"
read -s MYSQL_ROOT_PASSWORD_CONFIRM

# Ensure passwords match
if [ "$MYSQL_ROOT_PASSWORD" != "$MYSQL_ROOT_PASSWORD_CONFIRM" ]; then
    echo "Passwords do not match. Exiting."
    exit 1
fi

# Install MariaDB (MySQL) server
echo "Installing MariaDB (MySQL) server..."
install_package "mariadb-server"
install_package "mariadb-client"

# Start and enable MariaDB service
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Secure MySQL installation
echo "Securing MariaDB installation..."
sudo mysql_secure_installation <<EOF

$MYSQL_ROOT_PASSWORD
y
y
y
y
EOF

# Create MySQL user and grant privileges
echo "Creating MySQL user '$DEV_USER'..."
sudo mysql -e "CREATE USER '$DEV_USER'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$DEV_USER'@'localhost' WITH GRANT OPTION;"

# Install Apache Web Server
echo "Installing Apache Web Server..."
install_package "apache2"

# Install PHP and necessary extensions
echo "Installing PHP (latest stable version) and required extensions..."
install_package "php"
install_package "libapache2-mod-php"
install_package "php-mysql"
install_package "php-cli"
install_package "php-curl"
install_package "php-json"
install_package "php-xml"
install_package "php-mbstring"
install_package "php-zip"

# Install phpMyAdmin
echo "Installing phpMyAdmin..."
install_package "phpmyadmin"

# Configure Apache to work with phpMyAdmin
echo "Configuring Apache for phpMyAdmin..."
echo "Include /etc/phpmyadmin/apache.conf" | sudo tee -a /etc/apache2/apache2.conf

# Restart Apache to apply changes
echo "Restarting Apache..."
sudo systemctl restart apache2

# Create the web directory and set proper permissions
WEB_DIR="/var/www/html"
echo "Setting up web directory: $WEB_DIR"

# Ensure web directory exists and set the permissions
if [ ! -d "$WEB_DIR" ]; then
    sudo mkdir -p "$WEB_DIR"
fi

# Set the permissions for the development user
echo "Setting ownership of $WEB_DIR to $DEV_USER..."
sudo chown -R $DEV_USER:$DEV_USER $WEB_DIR

# Set proper directory permissions
echo "Setting directory permissions for $WEB_DIR..."
sudo chmod -R 755 $WEB_DIR

# Add the user to the 'www-data' group to allow web server access
sudo usermod -aG www-data $DEV_USER
sudo usermod -aG $DEV_USER $USER  # Allow the current user to edit files

# Allow Apache to read/write to the web directory
echo "Setting the Apache user (www-data) to have write permissions on $WEB_DIR..."
sudo chmod -R 775 $WEB_DIR
sudo chown -R $DEV_USER:www-data $WEB_DIR

# Change phpMyAdmin to dark theme
echo "Changing phpMyAdmin theme to dark..."
PHPMYADMIN_CONFIG="/usr/share/phpmyadmin/themes/"

if [ -d "$PHPMYADMIN_CONFIG" ]; then
    # Set the default theme to dark
    sudo sed -i 's/^\$cfg\["ThemeDefault"\] = .*/\$cfg\["ThemeDefault"\] = "pmahomme";/' /etc/phpmyadmin/config.inc.php
    echo "phpMyAdmin theme set to dark (pmahomme)."
else
    echo "phpMyAdmin theme directory not found, skipping theme modification."
fi

# Final Message
echo "Setup complete! You can now start developing your website."
echo "You can manage databases using phpMyAdmin at http://localhost/phpmyadmin"
echo "Your web directory is: $WEB_DIR"
echo "Your MySQL username is: $DEV_USER"
echo "Your MySQL password is: $MYSQL_ROOT_PASSWORD"
echo "Please make sure to use phpMyAdmin or the MySQL command line to manage databases."

# Optionally, show the MariaDB status
echo "Checking the status of MariaDB..."
sudo systemctl status mariadb | grep -i "active"

# Optionally, show the Apache status
echo "Checking the status of Apache..."
sudo systemctl status apache2 | grep -i "active"

# Clean up sensitive password variables
unset MYSQL_ROOT_PASSWORD
unset MYSQL_ROOT_PASSWORD_CONFIRM

# End of script
