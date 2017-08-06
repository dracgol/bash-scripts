#!/bin/bash
#update a Wordpress site without ftp access

#Download the latest Wordpress
cd ~
wget http://wordpress.org/latest.tar.gz
if [ -d wordpress ]
  then echo "The directory wordpress allready exists. Please rename it, move it or delete it"
      read -p "Would you like to automaticaly RENAME it to wordpressOld$(date +%y%m%d)? Y/
      > " auto_ren # puts the answer on a new line
        case $auto_ren in
          y|Y|[yY][eE][sS])
              echo "Renaming directory"
              new_dir=$PWD/wordpressOld$(date +%y%m%d)
              mv wordpress $new_dir
                if [ -d $new_dir ]
                  then echo "Renaming Complete"
                  else echo "Renaming Failed! Exiting now!"; exit
                fi
            ;;
          *)
              echo "Renaming aborted"
              read -p "Would you like to automaticaly DELETE the existing wordpress directory? Y/
                  > " auto_del # puts the answer on a new line
                      case $auto_del in
                        y|Y|[yY][eE][sS])
                            echo "Deleting wordpress directory"
                            rm -r wordpress
                              if [ -d wordpress ]
                                then echo "Deleting Failed! Exiting now!"; exit
                                else echo "Deleting Complete"
                              fi
                          ;;
                        *)
                            echo "Renaming aborted"
                          ;;
                      esac
            ;;
          esac
  else tar xzvf latest.tar.gz
