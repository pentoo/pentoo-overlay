#!/bin/sh
source /etc/profile
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
emerge --update --oneshot --changed-use --newrepo $(portageq envvar PYTHON_TARGETS | cut -d" " -f 1 | sed -e 's#_#.#' -e 's#python#python:#g') || safe_exit
eselect python set --python2 $(portageq envvar PYTHON_TARGETS | cut -d" " -f 1 |sed 's#_#.#') || safe_exit
emerge --update --oneshot --changed-use --newrepo $(portageq envvar PYTHON_TARGETS | cut -d" " -f 2 | sed -e 's#_#.#' -e 's#python#python:#g') || safe_exit
eselect python set --python3 $(portageq envvar PYTHON_TARGETS | cut -d" " -f 2 |sed 's#_#.#') || safe_exit
$(portageq envvar PYTHON_TARGETS | cut -d" " -f 1 | sed 's#_#.#') -c "from _multiprocessing import SemLock" || emerge -1 --buildpkg=y $(portageq envvar PYTHON_TARGETS | cut -d" " -f 1 | sed -e 's#_#.#' -e 's#python#python:#g')
$(portageq envvar PYTHON_TARGETS | cut -d" " -f 2 | sed 's#_#.#') -c "from _multiprocessing import SemLock" || emerge -1 --buildpkg=y $(portageq envvar PYTHON_TARGETS | cut -d" " -f 2 | sed -e 's#_#.#' -e 's#python#python:#g')

emerge --update --newuse --oneshot --changed-use --newrepo portage || safe_exit

if [ -n "${clst_target}" ]; then
	emerge @changed-deps || safe_exit
fi

emerge --deep --update --newuse -kb --changed-use --newrepo @world || safe_exit

perl-cleaner --ph-clean --modules -- --buildpkg=y || safe_exit

emerge --deep --update --newuse -kb --changed-use --newrepo @world || safe_exit

python-updater -- --buildpkg=y || safe_exit

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
if [ $? -ne 0 ]; then
	emerge @preserved-rebuild --buildpkg=y || safe_exit
fi
smart-live-rebuild 2>&1 || safe_exit
revdep-rebuild.py -i --no-pretend -- --rebuild-exclude dev-java/swt --exclude dev-java/swt --buildpkg=y || safe_exit
emerge --deep --update --newuse -kb --changed-use --newrepo @world || safe_exit
#we need to do the clean BEFORE we drop the extra flags otherwise all the packages we just built are removed
emerge --depclean || safe_exit
portageq list_preserved_libs /
if [ $? -ne 0 ]; then
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
