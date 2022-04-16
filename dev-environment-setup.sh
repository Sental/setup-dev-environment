#!/bin/sh

# common packages
sudo apt-get install apt-transport-https software-properties-common dirmngr 

# php
#7.4
#sudo apt install php7.4 php7.4-pdo php7.4-curl php7.4-mysqlnd php7.4-opcache php7.4-xml php7.4-gd php7.4-mysql php7.4-intl php7.4-mbstring php7.4-bcmath php7.4-json php7.4-iconv php7.4-soap php7.4-zip php-dev

# 8.1
sudo apt install php8.1 php8.1-pdo php8.1-curl php8.1-mysqlnd php8.1-opcache php8.1-xml php8.1-gd php8.1-mysql php8.1-intl php8.1-mbstring php8.1-bcmath php8.1-iconv php8.1-soap php8.1-zip php-dev php8.1-fpm

# git & unzip
sudo apt install unzip git

# composer
if [ ! -f "/tmp/composer-setup.sh" ]
then
    wget -O /tmp/composer-setup.sh https://raw.githubusercontent.com/Sental/setup-dev-environment/main/composer-setup.sh
fi
sh /tmp/composer-setup.sh

# vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update && sudo apt install code

# elasticsearch
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update && sudo apt-get install elasticsearch
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service

# redis
sudo apt install redis

# varnish
sudo apt install varnish

# rabbit mq
if [ ! -f "/tmp/rabbit-mq.sh" ]
then
    wget -O /tmp/rabbit-mq.sh https://raw.githubusercontent.com/Sental/setup-dev-environment/main/rabbit-mq.sh
fi
sh /tmp/rabbit-mq.sh

# mariadb
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository 'deb [arch=amd64,i386,arm64,ppc64el] https://mirrors.xtom.nl/mariadb/repo/10.6/debian bullseye main'
sudo apt-get update
sudo apt-get install mariadb-server

echo "starting interactive mariadb configuration from the mariadb package's script"
/bin/sleep 3s
sudo mariadb-install-db
