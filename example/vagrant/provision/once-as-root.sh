#!/usr/bin/env bash

source /app/vagrant/provision/common.sh

#== Import script args ==

timezone=$(echo "$1")

#== Provision script ==

info "Provision-script user: `whoami`"

export DEBIAN_FRONTEND=noninteractive

info "Configure timezone"
timedatectl set-timezone ${timezone} --no-ask-password



info "Update OS software"
apt install software-properties-common
apt-get update
apt-get upgrade -y

info "Install additional software"
#apt-get install -y php7.4-curl php7.4-cli php7.4-intl php7.4-mysqlnd php7.4-gd php7.4-fpm php7.4-mbstring php7.4-xml unzip nginx mysql-server-5.7 php.xdebug php7.4-zip
#apt-get install -y php php-cli php-fpm php-json php-pdo php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath php.xdebug
#apt-get install -y php7.4-{curl,cli,intl,mysqlnd,gd,fpm,mbstring,xml,mysql,zip}
#apt-get install -y unzip nginx mysql-server-5.7

info "Git Clone"
git clone https://github.com/novnc/noVNC.git temp
mv temp/.git noVNC/.git
rm -rf temp
