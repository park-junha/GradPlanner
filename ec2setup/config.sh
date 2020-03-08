#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0" )" && cd .. && pwd )"
REQ_DIR=$BASE_DIR"/requirements.txt"

sudo apt-get update
sudo apt-get install apache2
sudo apt-get install libapache2-mod-wsgi
sudo apt-get install python-pip
sudo -H pip install -r $REQ_DIR
sudo ln -sT $BASEDIR /var/www/html/app
sudo cp 000-default.conf /etc/apache2/sites-enabled/000-default.conf
sudo service apache2 restart
