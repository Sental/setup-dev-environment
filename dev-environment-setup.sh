different_user="mark"
home_user=$(bash -c "cd ~$(printf %q $different_user) && pwd")

sudo apt-get install apt-transport-https software-properties-common dirmngr 

# php
sudo apt install php7.4 php7.4-pdo php7.4-curl php7.4-mysqlnd php7.4-opcache php7.4-xml php7.4-gd php7.4-mysql php7.4-intl php7.4-mbstring php7.4-bcmath php7.4-json php7.4-iconv php7.4-soap php-dev

# composer
sh $home_user/Documents/setup-scripts/composer-setup.sh

# vscode
# sudo dpkg -i $home_user/Documents/setup-scripts/code_1.63.2-1639562499_amd64.deb
# sudo apt-get install -f # Install dependencies
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

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

# rabbitmq
sh $home_user/Documents/setup-scripts/rabbit-mq.sh

# mariadb
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository 'deb [arch=amd64,i386,arm64,ppc64el] https://mirrors.xtom.nl/mariadb/repo/10.6/debian bullseye main'
sudo apt-get update
sudo apt-get install mariadb-server

sudo apt install unzip git
