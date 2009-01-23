#!/bin/bash
#
# Copyright 2007	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
#
# You can use these to enable/disable modules without blacklisting them

# Make sure our imporant paths are included
PATH=$PATH:/usr/sbin:/sbin

# Appended to module file at the end when we want to ignore one
IGNORE_SUFFIX=".ignore"
VER=`uname -r`

# If 'module' is found, its renamed to 'module.ignore'
function module_disable {
	# Basic check to see if this is a module available for loading
	MODULE_CHECK=`modprobe -l $1`
	if [ -z $MODULE_CHECK ]; then
		echo "Module $1 not detected -- this is fine"
		return
	fi
	MODULE=$1
	MODULE_KO=${MODULE}.ko
	# In case there are more than one of these modules. This can 
	# happen, for example if your distribution provides one and you have
	# compiled one in yourself later.
	MODULE_COUNT=`find /lib/modules/$VER/ -name $MODULE_KO | wc -l`
	ALL_MODULES=`find /lib/modules/$VER/ -name $MODULE_KO`
	COUNT=1
	CHECK=`modprobe -l $MODULE`
	while  [ ! -z $CHECK ]; do
		if [[ $MODULE_COUNT -gt 1 ]]; then
			if [[ $COUNT -eq 1 ]]; then
				echo -en "$MODULE_COUNT $MODULE modules found "
				echo -e "we'll disable all of them"
			fi
			echo -en "Disabling $MODULE ($COUNT) ..."
		else
			echo -en "Disabling $MODULE ..."
		fi
		mv -f $CHECK ${CHECK}${IGNORE_SUFFIX}
		depmod -ae
		CHECK_AGAIN=`modprobe -l $MODULE`
		if [ "$CHECK" != "$CHECK_AGAIN" ]; then
			echo -e "\t[OK]\tModule disabled:"
			echo "$CHECK"
		else
			echo -e "[ERROR]\tModule is still being detected:"
			echo "$CHECK"
		fi
		let COUNT=$COUNT+1
		CHECK=$CHECK_AGAIN
	done
}

# If 'module.ignore' is found, rename it back to 'module'
function module_enable {
	MODULE=$1
	MODULE_KO=${MODULE}.ko
	IGNORED_MODULE=${MODULE_KO}${IGNORE_SUFFIX}
	# In case there are more than one of these modules. This can 
	# happen, for example if your distribution provides one and you have
	# compiled one in yourself later.
	ALL_MODULES=`find /lib/modules/$VER/ -name $IGNORED_MODULE`
	for i in $ALL_MODULES; do
		echo -en "Enabling $MODULE ..."
		DIR=`dirname $i`
		mv $i $DIR/$MODULE_KO
		depmod -ae
		CHECK=`modprobe -l $MODULE`
		if [ "$DIR/$MODULE_KO" != $CHECK ]; then
			if [ -z $CHECK ]; then
				echo -e "\t[ERROR]\tModule could not be enabled"
			else
				echo -en "\t[OK]\tModule renamed but another "
				echo "module file is being preferred"
				echo -e "Renamed module:\t\t$DIR/$MODULE_KO"
				echo -e "Preferred module:\t$CHECK"
			fi
		else
			echo -e "\t[OK]\tModule enabled: "
			echo "$DIR/$MODULE_KO"
		fi
		# Lets only do this for the first module found
		break
	done
}

