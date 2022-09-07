#!/bin/env bash
######################################################################
# Created By : Eng. Mohamed Kamal                                    #
# Phone : +201062008120                                              #
# Email : Mr.peacock2@gmail.com                                      #
#                                                                    #
# This script used for adding additional domains to Nginx & setup SSL#
#                                                                    #
######################################################################


## This is main domain configuration file
## please replace /etc/nginx/sites-available/domain.com.conf with real path
## also you need to add the main domain name here
ORG_DOMIN="domain.com"
ORG_DOMIN_DIR="/etc/nginx/conf.d/domain.com.conf"


echo "            "
echo "            "
echo "            "
echo "            "
echo "            Welcome to Add Domain Script"


# Menu For Choise
echo "	 Please choise your option"
echo " "
echo " "
echo "	 [1]-Add Domain"
echo " 	 [2]-Install SSL"
echo -n "Enter your Choise : [ 1 - 2 ] : "
read choise2

if [ $choise2 = "1" ]; then


if [[ $EUID -ne 0 ]]; then
   echo "Error:This script must be run as root!" 1>&2
   exit 1
fi

echo "            "
echo "You are now going to add new Domain to Nginx, please make suer you point"
echo "the domain to main server ip to be able activating SSL"
read -p "Please Enter FQDN Domain: " domain

if grep $domain ${ORG_DOMIN_DIR}; then
    echo "Domain already exist"
    else
    sed -i 's/server_name ${ORG_DOMIN}/server_name ${ORG_DOMIN} $domain/' ${ORG_DOMIN_DIR}
	certbot run -n --nginx --agree-tos -d $domain  -m  Mr.peacock2@gmail.com  --redirect
fi

else
echo "            "
echo "You are now going to install New SSL, please make suer you point"
echo "the domain to main server ip to be able activating SSL"
read -p "Please Enter FQDN Domain: " domainssl

if grep $domainssl ${ORG_DOMIN_DIR}; then
    certbot run -n --nginx --agree-tos -d $domainssl  -m  Mr.peacock2@gmail.com  --redirect
    else
    echo "Domain Not Found in Nginx Configuration"
fi

fi
