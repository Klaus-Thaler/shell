#!/bin/bash

# Usage:
# sudo bash dpkg-get-set-selection.sh
# required root

if [ "$(whoami)" != "root" ]; then
	echo  "You are not root!!!"
	echo "Usage:"
	echo "sudo bash dpkg-get-set-selection.sh"
	exit
fi

locationOfScript=$(dirname "$(readlink -e "$0")")

echo "Type 'g' for get the list of installed packages in my_package_list.txt"
echo "Type 's' for select list vom my_package_list.txt and install"
read run
echo "$1"

if [ "$run" = "g" ]; then
	sudo apt-get update
	sudo apt-get upgrade
	sudo dpkg --get-selections | awk '{ print $1 }' > $locationOfScript/dpkg_list.txt
fi
if [ "$run" = "s" ]; then
	sudo apt-get update
	sudo apt-get upgrade	
	sudo apt-get update && apt-get install $(cat $locationOfScript/dpkg_list.txt)
fi
