#!/bin/bash -e

clear
	RED='\033[1;31m'
	WHITE='\033[1;37m'
	ORANGE='\033[01;38;5;166m'
	GREEN='\033[01;38;5;118m'
printf "${ORANGE}"
echo -e "██╗    ██╗  ██████╗  ██████╗  ██████╗   ██████╗ ██╗ ███╗   ██╗ ███████╗ ████████╗  █████╗"
echo -e "██║    ██║ ██╔═══██╗ ██╔══██╗ ██╔══██╗ ██╔═══██╗ ██║ ████╗  ██║ ██╔════╝ ╚══██╔══╝ ██╔══██╗"
echo -e "${WHITE}██║ █╗ ██║ ██║   ██║ ██████╔╝ ██║  ██║ ██║   ██║ ██║ ██╔██╗ ██║ ███████╗    ██║    ███████║"
echo -e "██║███╗██║ ██║   ██║ ██╔══██╗ ██║  ██║ ██║   ██║ ██║ ██║╚██╗██║ ╚════██║    ██║    ██╔══██║"
echo -e "${GREEN}╚███╔███╔╝ ╚██████╔╝ ██║  ██║ ██████╔╝ ╚██████╔╝ ██║ ██║ ╚████║ ███████║    ██║    ██║  ██║"
echo -e " ╚══╝╚══╝   ╚═════╝  ╚═╝  ╚═╝ ╚═════╝   ╚═════╝  ╚═╝ ╚═╝  ╚═══╝ ╚══════╝    ╚═╝    ╚═╝  ╚═╝"
echo -e "                             ${RED}   (Version - 1.O)                                "
printf "${WHITE}"
echo -e "----------------Contributer :- Anurag Batra -------------------------------------------"
echo -e "---------------------------${ORANGE} Hindustani ${WHITE} Tech ${GREEN} Solutions ${WHITE}-------------------------------"
echo -e "                          Kindly Read Note First by typing note                          "
echo -e "============================================================================================================================="
echo -e "                             Installing Wordpress on VPS"
 echo -e "============================================================================================================================="
echo "Choose one of the Following"
echo "1. WebServer and Mysql are allready installed"
echo "2. WebServer Is Not Installed"
read -e Setupinfo
if [ "$setupinfo" == 1 ] ; then
	echo "============================================"
	echo "A robot is now Setting up Server for you."
	echo "============================================"
	sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove
	sudo apt-get install nginx
	sudo apt-get install mysql-server mysql-client
	sudo apt-get install php php-mysql php-fpm php-curl php-gd php-pear php-imagick php-imap php-mcrypt php-recode php-tidy php-xmlrpc
	sudo nginx -t
	sudo systemctl restart nginx
else
	echo "Database Name: "
	read -e dbname
	echo "Database User: "
	read -e dbuser
	echo "Database Password: "
	read -s dbpass
	echo "Sure run install? (y/n)"
	read -e run
	if [ "$run" == n ] ; then
		exit
	else
		echo "============================================"
		echo "A robot is now installing WordPress for you."
		echo "============================================"
		curl -O https://wordpress.org/latest.tar.gz
		tar -zxvf latest.tar.gz
		cd wordpress
		cp -rf . ..
		cd ..
		rm -R wordpress
		cp wp-config-sample.php wp-config.php
		perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
		perl -pi -e "s/username_here/$dbuser/g" wp-config.php
		perl -pi -e "s/password_here/$dbpass/g" wp-config.php
		perl -i -pe'
		  BEGIN {
		    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    		push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
  			  sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  			}
 		 s/put your unique phrase here/salt()/ge
		' wp-config.php
		mkdir wp-content/uploads
		chmod 775 wp-content/uploads
		echo "Cleaning... JUNK FIES"
		rm latest.tar.gz
		rm Wordoinsta.sh
		echo "========================="
		echo "Installation is complete."
		echo "========================="
	fi
fi
