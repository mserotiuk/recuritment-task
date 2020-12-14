#!/bin/bash

# Install nginx
sudo apt-get update
sudo apt-get nginx

# Setup index.html
sudo rm /var/www/html/index.html
touch /var/www/html/index.html
echo "AZ_A" > index.html