#!/bin/sh
source /etc/profile
env-update

if [ -n "${clst_target}" ]; then
	emerge --info > /var/log/portage/emerge-info-$(date "+%Y%m%d").txt
fi

safe_exit() {
	#I want a shell when I'm in catalyst but just an exit on failure for users
	if [ -n "${clst_target}" ]; then
		/bin/bash
	else
		exit
	fi
}

emerge --update --newuse --oneshot portage || safe_exit

#first we set the python interpreters to match PYTHON_TARGETS (and ensure the versions we set are actually built)
emerge --update --oneshot $(emerge --info | grep ^PYTHON_TARGETS | cut -d\" -f2 | cut -d" " -f 1 | sed 's#_#.#'| sed 's#python#python:#g')
eselect python set --python2 $(emerge --info | grep ^PYTHON_TARGETS | cut -d\" -f2 | cut -d" " -f 1 |sed 's#_#.#') || safe_exit
emerge --update --oneshot $(emerge --info | grep ^PYTHON_TARGETS | cut -d\" -f2 | cut -d" " -f 2 | sed 's#_#.#'| sed 's#python#python:#g')
eselect python set --python3 $(emerge --info | grep ^PYTHON_TARGETS | cut -d\" -f2 | cut -d" " -f 2 |sed 's#_#.#') || safe_exit
python2.7 -c "from _multiprocessing import SemLock" || emerge -1 --buildpkg=y python:2.7
python3.3 -c "from _multiprocessing import SemLock" || emerge -1 --buildpkg=y python:3.3

perl-cleaner --ph-clean --modules -- --buildpkg=y || safe_exit

python-updater -- --buildpkg=y --rebuild-exclude sys-devel/gdb --exclude sys-devel/gdb || safe_exit

emerge --deep --update --newuse -kb @world || safe_exit

#if we are in catalyst, update the extra binpkgs
if [ -n "${clst_target}" ]; then
	#add kde and mate use flags
	echo "pentoo/pentoo kde mate" >> /etc/portage/package.use
	emerge --onlydeps --oneshot --deep --update --newuse pentoo/pentoo || safe_exit
	etc-update --automode -5 || safe_exit
fi

emerge @preserved-rebuild --buildpkg=y || safe_exit
smart-live-rebuild 2>&1 || safe_exit
revdep-rebuild.py -i --no-pretend -- --rebuild-exclude dev-java/swt --exclude dev-java/swt --buildpkg=y || safe_exit
emerge --deep --update --newuse -kb @world || safe_exit
etc-update --automode -5 || safe_exit
#we need to do the clean BEFORE we drop the extra flags otherwise all the packages we just built are removed
emerge --depclean || safe_exit

if [ -n "${clst_target}" ]; then
	eclean-pkg || safe_exit
	emaint binhost || safe_exit
	#remove kde/mate use flags
	rm /etc/portage/package.use
fi

if [ -f /usr/local/portage/scripts/bug-461824.sh ]; then
	/usr/local/portage/scripts/bug-461824.sh
elif [ -f /var/lib/layman/pentoo/scripts/bug-461824.sh ]; then
	/var/lib/layman/pentoo/scripts/bug-461824.sh
fi
