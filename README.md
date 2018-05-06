# XFCE Builder shells script version 1.6 for XFCE 4.12 in FEDORA Environment

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# DESCRIPTION:
This script will automaticall unpack all tarball files downloaded from XFCE repository and will arrange it into two directories
It will Builds and Installs the packages into target deistination directories which can be changed by modifying the variables.

Copyright: (c) 2018 by Aditya Mall. Mentor:Mr.Pravjot Singh
Email: <aditya.mall1990@gmail.com>

## Note: This will only build directories in Fedora enviornment and Make sure if you have active internet connection. ##

Feel free to copy and distribute and don't forget to drop me a mail,          
would love to hear from you regarding your views or if you have any questions. 

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# USAGE:

Below variables in the script can be changed by the user:-
#DIR_packs="Tar.Packages"
#DIR_unpacks="Build.Directories"
#TARGET_INSTALL="$(pwd)/XFCE_GUI/usr

1) Download src files from XFCE repo http://archive.xfce.org/xfce/4.12/fat_tarballs/
2) Untar the downloaded tarball and copy the script (xfce_buider.sh) into src directory.
3) Execute script ./xfce_builder.sh
4) All files will be installed in XFCE_GUI/usr directory in your present working directory.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# TESTING
1) Copy files from XFCE_GUI/usr to /usr/local/
2) Logout from the current system and you should be able to select the xfce option from the gear icon in the login menu

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



