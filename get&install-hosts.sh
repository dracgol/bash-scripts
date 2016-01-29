#!/bin/bash
#Just a little script that I use to download and update the /etc/hosts file
#run this script with administrative privilege
#Get the hosts.txt file
cd /etc
echo "Downloading the hosts.txt from http://winhelp2002.mvps.org/hosts.txt"
wget http://winhelp2002.mvps.org/hosts.txt
#Backup the old hosts file
echo "Making a backup of the old /etc/hosts
cp /etc/hosts /etc/hosts.old; echo "Backup complete"
#Add the contents of the downloaded hosts.txt file to /etc/hosts
echo "Appending the content of the newly downloaded hosts.txt to the old /etc/hosts file"
cat /etc/hosts.txt >> /etc/hosts; echo "Done!"
echo "Exit"
exit 0
