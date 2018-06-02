#!/bin/bash -e

clear
	RED='\033[1;31m'
	WHITE='\033[1;37m'
	ORANGE='\033[01;38;5;166m'
	GREEN='\033[01;38;5;118m'
  echo "Task Completed Thanks For Using"
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

echo "Database Name: "
read -e dbname
echo "Database User: "
read -e dbuser
echo "Database Password: "
read -s dbpass
echo "run install? (y/n)"
read -e run
if [ "$run" == n ] ; then
exit
else
echo "============================================"
echo "A robot is now installing WordPress for you."
echo "============================================"
#download wordpress
curl -O https://wordpress.org/latest.tar.gz
#unzip wordpress
tar -zxvf latest.tar.gz
#change dir to wordpress
cd wordpress
#copy file to parent dir
cp -rf . ..
#move back to parent dir
cd ..
#remove files from wordpress folder
rm -R wordpress
#create wp config
cp wp-config-sample.php wp-config.php
#set database details with perl find and replace
perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
perl -pi -e "s/username_here/$dbuser/g" wp-config.php
perl -pi -e "s/password_here/$dbpass/g" wp-config.php

#set WP salts
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php

#create uploads folder and set permissions
mkdir wp-content/uploads
chmod 775 wp-content/uploads
echo "Cleaning..."
#remove zip file
rm latest.tar.gz
#remove bash script
rm Wordoinsta.sh
echo "========================="
echo "Installation is complete."
echo "========================="
