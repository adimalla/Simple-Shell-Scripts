#! /bin/bash

## File Name: xfce_builder.sh
## Project: [xfce 4.12] unpacker for Fedora
## Version: 1.6
## Creation Date: 2018-05-05
## Copyright: (c) 2018 by Aditya Mall, Mentor: Mr.Pravjot Singh
## Email: <aditya.mall1990@gmail.com>

## Feel free to copy and distribute and don't forget to drop me a mail,          
## would love to hear from you regarding your views or if you have any questions. 

## General Description:-
# This script unpacks the source tarball files and manages the files,
# into respective directories and packages.
# Builds and Installs the packages into target deistination directories
# Note: This will only build directories in Fedora enviornment.
# Make sure if you have active internet connection.
##

## Usage:-
# execute './unpacker' or './xfce.unpacker' in your directory containing all src tar files.
# for just 'Build' operation, comment the 'unpack' and 'arrange' function calls.
##

##============================= USER VARIABLES =====================================##
FILE="xfce_builder.sh"
DIR_packs="Tar.Packages"
DIR_unpacks="Build.Directories"
TARGET_INSTALL="$(pwd)/XFCE_GUI/usr"			 #User defined PATH, NOTE: Don't terminate with '/'
TARGET_DIR=${TARGET_INSTALL%/*}

##============================== BUILD DIR VARIABLES ================================##

# For XFCE Verions 4.12 only

libxfce4util="libxfce4util-4.12.1"
xfconf="xfconf-4.12.0"
libxfce4ui="libxfce4ui-4.12.0"
garcon="garcon-0.4.0"
exo="exo-0.10.3"
xfce4_panel="xfce4-panel-4.12.0"
Thunar="Thunar-1.6.6"
thunar_volman="thunar-volman-0.8.1"
xfce4_settings="xfce4-settings-4.12.0"
xfce4_session="xfce4-session-4.12.0"
xfwm4="xfwm4-4.12.0"
xfdesktop="xfdesktop-4.12.0"
xfce4_appfinder="xfce4-appfinder-4.12.0"
gtk_xfce_engine_2="gtk-xfce-engine-2.10.0"
tumbler="tumbler-0.1.31"

##================================ DEPENDENCY VARIABLES ==============================##

# FEDORA Environment dependencies only

glib_2="glib2-devel"
dbus="dbus-devel"
dbus_glib="dbus-glib-devel"
xorg="xorg-x11-proto-devel"
gtk2="gtk2-devel"
x_windows="X Software Development"
gio="gio-sharp"
libwnck="libwnck-devel"
gudev_1="libgudev-devel"

##============================= Function Definitions ================================##

untar() 
{
	for tar_file in $(ls *.tar.*)
	do
		if (tar -xvf $tar_file)
		then
			echo
			echo "TAR SUCCESS"
		else
			exit 1
		fi
	done
}

arrange()
{
	if ( mkdir $DIR_packs $DIR_unpacks )
	then
		echo "Directories Created"
		echo $TARGET_DIR
	else
		exit 1
	fi

	mv *.tar.bz2 $DIR_packs/
	mv `ls -A | grep -v $DIR_packs` $DIR_unpacks/ 2>/dev/null
	mv $DIR_unpacks/$FILE .
}

depend_install()
{
	if (dnf install -y $glib_2 $dbus $dbus_glib)
	then
		echo
	else
		exit 1
	fi

	if (dnf install -y $xorg $gtk2)
	then
		echo
	else
		exit 1
	fi

	if (dnf groupinstall -y "$x_windows") 
	then
		echo
	else
		exit 1
	fi

	if (dnf install -y $gio $libwnck $gudev_1) 
	then
		echo
	else
		exit 1
	fi	
}

build()
{
	export PKG_CONFIG_PATH="${TARGET_INSTALL}/lib/pkgconfig:$PKG_CONFIG_PATH"	 #Intializing path enviornment variable for packageconfig

	##echo $PKG_CONFIG_PATH

	## Directory build and file install commands
	##
	(cd $DIR_unpacks/$libxfce4util/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$xfconf/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$libxfce4ui/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$garcon/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$exo/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$xfce4_panel/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$Thunar/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$thunar_volman/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$xfce4_settings/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$xfce4_session/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$xfwm4/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$xfdesktop/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$xfce4_appfinder/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$gtk_xfce_engine_2/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
	(cd $DIR_unpacks/$tumbler/; ./configure --prefix=${TARGET_INSTALL} && make && make install)
}

##================================= FUNCTION CALLS ====================================##

if (ls *.tar.* )
then
	echo "Starting Operations"
	## unpacking and arranging function calls,
	# comment this section if you just want,
	# to perform build operations.
	##
	if (untar)
	then
		if (arrange)
		then
			echo
		else
			exit 1
		fi
	else
		echo "TAR ERROR"
		exit 1
	fi

	## Creating Target install directory

#	mkdir $TARGET_DIR

	if (mkdir $TARGET_DIR)
	then
		mkdir -p $TARGET_INSTALL
		## Installing dependencies and building, 
		# and Installing respective directories, 
		# into target location.
		##
		if (depend_install)
		then
			build

		else
			echo
			echo "Dependencies not properly installed, please install them again"
			echo
			exit 1
		fi

	else
		echo "TARGET DESTINATION EXISTS, BUILD FAILED"
		exit 1
	fi
else
	echo "XFCE BUILD FAILED"
	exit 1 
fi
