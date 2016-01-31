#!/bin/bash

# Just a little script that I use to download and update the /etc/hosts file
# It started as a 5 line script but it evolved. Anyway it was fun !

# Run this script with administrative privilege

# Get the hosts.txt file
cd /etc
echo "Changing directory to /etc"

# Making sure the PWD is /etc
if [ $PWD != /etc ]
  then echo "Make sure you have administrative rights"
    exit
  else
    echo "Checking if file hosts.txt already exists"
    if [ -e $PWD/hosts.txt ]
    	then echo "File hosts.txt already exists. Please rename it, move it or delete it."
      		read -p "Would you like to automaticaly rename it under hosts.txt-bkp-$(date +%y%m%d) name? Y/N 
      		> " auto_ren # puts the answer on a new line
        		case $auto_ren in
          			n|N|[nN][oO])
            				echo "Exiting"
            				exit
            			;;
          			y|Y|[yY][eE][sS])
            				echo "Renaming file"
            				new_hosts=$PWD/hosts.txt-bkp-$(date +%y%m%d)
            				mv $PWD/hosts.txt $new_hosts
              				if [ -e $new_hosts ]
              					then echo "Backup Complete"
              					else echo "Backup Failed! Exiting"; exit
              					sleep 3
              				fi
            			;;  
          			*)
            				echo "Exiting"; exit
            			;;
        		esac
    fi
    echo "Starting download..."
    sleep 3
    echo "Downloading the hosts.txt from http://winhelp2002.mvps.org/hosts.txt"
    wget http://winhelp2002.mvps.org/hosts.txt
      if  [ -e $PWD/hosts.txt ]
      	then 
        	echo "File downloaded succesfully"
        	#Backup the old hosts file
        	echo "Making a backup of the old $PWD/hosts"
        	sleep 3
		old_hosts=hosts.OLD_$(date +%y%m%d)
		cp /etc/hosts /etc/$old_hosts 
          	if [ -e $PWD/$old_hosts ]
          		then echo "Backup complete"; sleep 1
          		else echo "Backup Failed! Removing downloaded file."
          			rm $PWD/hosts.txt
          			echo "Exiting now."; exit
          	fi
        	#Add the contents of the downloaded hosts.txt file to /etc/hosts
        	echo "Appending the content of the newly downloaded hosts.txt to the $PWD/hosts file"
        	sleep 1
        	cat /etc/hosts.txt >> /etc/hosts; echo "Done!"; sleep 2
        	echo "All done! Exiting now."; exit
      	else
        echo "Make sure you have administrative rights"; exit
      fi
fi
