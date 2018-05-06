## File Name: refresh.sh
## Project: [xfce 4.12] unpacker for Fedora 
## Creation Date: 2018-05-05
## Copyright: (c) 2018 by Aditya Mall.
## Email: <aditya.mall1990@gmail.com>

## Feel free to copy and distribute and don't forget to drop me a mail,          
## would love to hear from you regarding your views or if you have any questions. 

## General Description:-
# Use this script in the present working diretory of xfce build to start over
##

## Usage:-
# execute ./refresh.sh
##

DIR_packs="Tar.Packages"
DIR_unpacks="Build.Directories"
TARGET_INSTALL="$(pwd)/XFCE_GUI/usr"                                 #User defined PATH, NOTE: Don't terminate with '/'
TARGET_DIR=${TARGET_INSTALL%/*}


if (ls $DIR_packs $DIR_unpacks 2>/dev/null)
then	
	rm -rf Build.Directories/  && cp Tar.Packages/* . && rm -rf Tar.Packages
	rm -rf $TARGET_DIR
	echo
	echo "Refreshed"
	echo
else
	echo
	echo "Nothing to Refresh"
	echo
	exit 1
fi







