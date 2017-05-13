#!/bin/sh
. /etc/profile
env-update

if [ -n "${clst_target}" ]; then #we are in catalyst
	mkdir -p /var/log/portage/emerge-info/
	emerge --info > /var/log/portage/emerge-info/emerge-info-$(date "+%Y%m%d").txt
else #we are on a user system
	emerge --sync
fi

safe_exit() {
	#I want a shell when I'm in catalyst but just an exit on failure for users
	if [ -n "${clst_target}" ] && [ -n "${debugshell}" ]; then
		/bin/bash
	elif [ -n "${clst_target}" ] && [ -n "${reckless}" ]; then
		echo "Continuing despite failure...grumble grumble" 1>&2
	#else #let's let it keep going by default instead of just failing out
	#	exit
	fi
}

#first we set the python interpreters to match PYTHON_TARGETS (and ensure the versions we set are actually built)
PYTHON2=$(emerge --info | grep ^PYTHON_TARGETS | cut -d\" -f2 | cut -d" " -f 1 |sed 's#_#.#')
PYTHON3=$(emerge --info | grep ^PYTHON_TARGETS | cut -d\" -f2 | cut -d" " -f 2 |sed 's#_#.#')
if [ -z "${PYTHON2}" ] || [ -z "${PYTHON3}" ]; then
  printf "Failed to autodetect PYTHON_TARGETS\n"
  printf "Detected Python 2: ${PYTHON2:-none}\n"
  printf "Detected Python 3: ${PYTHON3:-none}\n"
  printf "From PYTHON_TARGETS: $(emerge --info | grep '^PYTHON TARGETS')\n"
  exit 1
fi
eselect python set --python2 ${PYTHON2} || /bin/bash
eselect python set --python3 ${PYTHON3} || /bin/bash
${PYTHON2} -c "from _multiprocessing import SemLock" || emerge -1 python:${PYTHON2#python}
${PYTHON3} -c "from _multiprocessing import SemLock" || emerge -1 python:${PYTHON3#python}
emerge --update --newuse --oneshot --changed-use --newrepo portage || safe_exit

#modified from news item "Python ABIFLAGS rebuild needed"
if [ -n "$(find /usr/lib*/python3* -name '*cpython-3[3-5].so')" ]; then
  emerge -1v --usepkg=n --buildpkg=y $(find /usr/lib*/python3* -name '*cpython-3[3-5].so')
fi
if [ -n "$(find /usr/include/python3.{3,4,5} -type f 2> /dev/null)" ]; then
  emerge -1v --usepkg=n --buildpkg=y /usr/include/python3.{3,4,5}
fi

#taken from news item gcc-5-new-c++11-abi
if [ "$(gcc-config -c)" = "x86_64-pc-linux-gnu-5.4.0" ]; then
  revdep-rebuild --library 'libstdc++.so.6' -- --buildpkg=y --usepkg=n --exclude gcc
fi

if [ -n "${clst_target}" ]; then
	emerge @changed-deps || safe_exit
fi

emerge --deep --update --newuse -kb --changed-use --newrepo @world || safe_exit

perl-cleaner --ph-clean --modules -- --buildpkg=y || safe_exit

emerge --deep --update --newuse -kb --changed-use --newrepo @world || safe_exit

#if we are in catalyst, update the extra binpkgs
if [ -n "${clst_target}" ]; then
	#add kde and mate use flags
	echo "pentoo/pentoo kde mate" >> /etc/portage/package.use
	emerge @changed-deps || safe_exit
	emerge --buildpkg --usepkg --onlydeps --oneshot --deep --update --newuse --changed-use --newrepo pentoo/pentoo || safe_exit
	etc-update --automode -5 || safe_exit
fi

portageq list_preserved_libs /
if [ $? = 0 ]; then
	emerge @preserved-rebuild --buildpkg=y || safe_exit
fi
smart-live-rebuild 2>&1 || safe_exit
revdep-rebuild -i -- --rebuild-exclude dev-java/swt --exclude dev-java/swt --buildpkg=y || safe_exit
emerge --deep --update --newuse -kb --changed-use --newrepo @world || safe_exit
#we need to do the clean BEFORE we drop the extra flags otherwise all the packages we just built are removed
emerge --depclean || safe_exit
portageq list_preserved_libs /
if [ $? = 0 ]; then
	emerge @preserved-rebuild --buildpkg=y || safe_exit
fi

if [ -n "${clst_target}" ]; then
	if [ -n "${debugshell}" ]; then
		/bin/bash
	fi
	emerge @changed-deps || safe_exit
	etc-update --automode -5 || safe_exit
	eclean-pkg || safe_exit
	emaint binhost || safe_exit
	fixpackages || safe_exit
	#remove kde/mate use flags
	rm /etc/portage/package.use
fi

if [ -f /usr/local/portage/scripts/bug-461824.sh ]; then
	/usr/local/portage/scripts/bug-461824.sh
elif [ -f /var/lib/layman/pentoo/scripts/bug-461824.sh ]; then
	/var/lib/layman/pentoo/scripts/bug-461824.sh
fi
