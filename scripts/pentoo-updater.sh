#!/bin/bash

#this is bash specific
exec   > >(tee -i /tmp/pentoo-updater.log)
exec  2> >(tee -i /tmp/pentoo-updater.log >& 2)
#end bash specific

WE_FAILED=0
if [ -n "$(command -v id 2> /dev/null)" ]; then
	USERID="$(id -u 2> /dev/null)"
fi

if [ -z "${USERID}" ] && [ -n "$(id -ru)" ]; then
	USERID="$(id -ru)"
fi

if [ -n "${USERID}" ] && [ "${USERID}" != "0" ]; then
	printf "Run it as root\n" ; exit 1;
elif [ -z "${USERID}" ]; then
	printf "Unable to determine user id, permission errors may occur.\n"
fi

. /etc/profile
env-update

#colorize the updates even if colors end up in the logs
export EMERGE_DEFAULT_OPTS="$(portageq envvar EMERGE_DEFAULT_OPTS) --color=y"

check_profile () {
  if [ -L "/etc/portage/make.profile" ] && [ ! -e "/etc/portage/make.profile" ]; then
    failure="0"
    #profile is broken, read the symlink then try to reset it back to what it should be
    printf "Your profile is broken, attempting repair...\n"
    desired="pentoo:$(readlink /etc/portage/make.profile | cut -d'/' -f 8-)"
    if ! eselect profile set "${desired}"; then
      #profile failed to set, try hard to set the right one
      #first set arch
      arch=$(uname -m)
      if [ "${arch}" = "i686" ]; then
        ARCH="x86"
      elif [ "${arch}" = "x86_64" ]; then
        ARCH="amd64"
      else
        failure=1
      fi
      #then check if we are hard
      if gcc -v 2>&1 | grep -q Hardened; then
        hardening="hardened"
      else
        hardening="default"
      fi
      #last check binary
      if echo "${desired}" | grep -q binary; then
        binary="/binary"
      else
        binary=""
      fi
      if [ "${failure}" = "0" ]; then
        if ! eselect profile set pentoo:pentoo/${hardening}/linux/${ARCH}${binary}; then
          failure="1"
        fi
      fi
    fi
    if [ "${failure}" = "1" ]; then
      printf "Your profile is invalid, and we failed to automatically fix it.\n"
      printf "Please select a profile that works with \"eselect profile list\" and \"eselect profile set ##\"\n"
      exit 1
    else
      printf "Profile repaired.\n"
    fi
  fi
}

update_kernel() {
  arch=$(uname -m)
  if [ "${arch}" = "i686" ]; then
    ARCH="x86"
    ARCHY="x86"
  elif [ "${arch}" = "x86_64" ]; then
    ARCH="amd64"
    ARCHY="x86_64"
  else
    printf "Arch ${arch} isn't supported for automatic kernel updating, skipping...\n."
    return 1
  fi

  bestkern="$(qlist $(portageq best_version / pentoo-sources 2> /dev/null) | grep 'distro/Kconfig' | awk -F'/' '{print $4}' | cut -d'-' -f 2-)"
  if [ -z "${bestkern}" ]; then
    printf "Failed to find pentoo-sources installed, is this a Pentoo system?\n"
    return 1
  fi

  #first we check for a config
  upstream_config="https://raw.githubusercontent.com/pentoo/pentoo-livecd/master/livecd/${ARCH}/kernel/config-${bestkern%-pentoo}"
  local_config="/usr/src/linux-${bestkern}/.config"
  if [ -r "${local_config}" ]; then
    printf "Checking for updated kernel config...\n"
    curl --fail "${upstream_config}" -z "${local_config}" -o "${local_config}"
  else
    printf "Checking for kernel config...\n"
    curl --fail "${upstream_config}" -o "${local_config}"
  fi
  if [ ! -r "${local_config}" ]; then
    printf "Unable to find a viable config for ${bestkern}, skipping update.\n"
    return 1
  else
    #okay, we have a config, now we mangle it for x86 as appropriate
    if [ "${ARCH}" = "x86" ] && grep -q pae /proc/cpuinfo; then
      printf "PAE support found.\n"
      sed -i '/^CONFIG_HIGHMEM4G/s/CONFIG_HIGHMEM4G/# CONFIG_HIGHMEM4G/' "${local_config}"
      sed -i '/^# *CONFIG_HIGHMEM64G/s/^# *//' "${local_config}"
      sed -i '/^CONFIG_HIGHMEM64G/s/ .*/=y/' "${local_config}"
      oldpwd=$(pwd)
      cd "/usr/src/linux-${bestkern}"
      make olddefconfig
      cd "${oldpwd}"
      unset oldpwd
      printf "PAE enabled.\n"
    fi
  fi
  #next we fix the symlink
  if [ "$(readlink /usr/src/linux)" != "linux-${bestkern}" ]; then
    unlink /usr/src/linux
    ln -s "linux-${bestkern}" /usr/src/linux
  fi

  #last, before we compare the configs, run oldconfig
  yes '' 2>/dev/null | make oldconfig -C /usr/src/linux

  currkern="$(uname -r)"
  if [ "${currkern}" != "${bestkern}" ]; then
    printf "Currently running kernel ${currkern} is out of date.\n"
    if [ -x "/usr/src/linux-${bestkern}/vmlinux" ] && [ -r "/lib/modules/${bestkern}/modules.dep" ]; then
      if [ -r /etc/kernels/kernel-config-${ARCHY}-${bestkern} ] && diff -Naur /usr/src/linux/.config /etc/kernels/kernel-config-${ARCHY}-${bestkern} > /dev/null 2>&1; then
        printf "Kernel ${bestkern} appears ready to go, please reboot when convenient.\n"
        return 1
      else
        printf "Updated kernel ${bestkern} config available, building...\n"
      fi
    else
      printf "Updated kernel ${bestkern} available, building...\n"
    fi
  elif [ -r /etc/kernels/kernel-config-${ARCHY}-${bestkern} ] && diff -Naur /usr/src/linux/.config /etc/kernels/kernel-config-${ARCHY}-${bestkern} > /dev/null 2>&1; then
    printf "No updated kernel or config found. No kernel changes needed.\n"
    return 0
  else
    printf "Found an updated config for ${bestkern}, rebuilding...\n"
  fi

  #then we set genkernel options as needed
  genkernelopts="--no-mrproper --disklabel --microcode --compress-initramfs-type=xz --bootloader=grub2"
  if grep -q btrfs /etc/fstab || grep -q btrfs /proc/cmdline; then
    genkernelopts="${genkernelopts} --btrfs"
  fi
  if grep -q zfs /etc/fstab || grep -q zfs /proc/cmdline; then
    genkernelopts="${genkernelopts} --zfs"
  fi
  if grep -q 'ext[234]' /etc/fstab; then
    genkernelopts="${genkernelopts} --e2fsprogs"
  fi
  if grep -q gpg /proc/cmdline; then
    genkernelopts="${genkernelopts} --luks --gpg"
  elif grep -q luks /etc/fstab || grep -E '^swap|^source' /etc/conf.d/dmcrypt; then
    genkernelopts="${genkernelopts} --luks"
  fi
  #then we go nuts
  if genkernel ${genkernelopts} --callback="emerge @module-rebuild" all; then
    printf "Kernel ${bestkern} built successfully, please reboot when convenient.\n"
    return 0
  else
    printf "Kernel ${bestkern} failed to build, please see logs above.\n"
    return 1
  fi
}

safe_exit() {
  #I want a shell when I'm in catalyst but just an exit on failure for users
  if [ -n "${clst_target}" ] && [ -n "${debugshell}" ]; then
    /bin/bash
  #elif [ -n "${clst_target}" ] && [ -n "${reckless}" ]; then
    #reckless doesn't really exist anymore
    #we are always reckless
  #  true
  else
    printf "FAILURE FAILURE FAILURE\n" 1>&2
    printf "Continuing despite failure...grumble grumble\n" 1>&2
    printf "FAILURE FAILURE FAILURE\n" 1>&2
    export WE_FAILED=1
  fi
}

do_sync() {

  read -r portage_timestamp <  /usr/portage/metadata/timestamp.chk
  portage_date=`date --date="$portage_timestamp" '+%Y%m%d%H%M' -u`
  minutesDiff=$(( `date '+%Y%m%d%H%M' -u` - $portage_date ))
  if [ $minutesDiff -lt 60 ]
  then
    echo "The last sync was $minutesDiff minutes ago (<1 hour), skipping"
    return
  fi

  if ! emerge --sync; then
    if [ -e /etc/portage/repos.conf/pentoo.conf ] && grep -q pentoo.asc /etc/portage/repos.conf/pentoo.conf; then
      printf "Pentoo repo key incorrectly defined, fixing..."
      sed -i 's#pentoo.asc#pentoo-keyring.asc#' /etc/portage/repos.conf/pentoo.conf
      if grep -q pentoo.asc /etc/portage/repos.conf/pentoo.conf; then
        printf "FAILED\n"
        exit 1
      else
        printf "OK\n"
        printf "Please re-run pentoo-updater.\n"
      fi
    else
      printf "emerge --sync failed, aborting update for safety\n"
      exit 1
    fi
  fi
}

#check profile, manage repo, ensure valid python selected
check_profile
if [ -n "${clst_target}" ]; then #we are in catalyst
  mkdir -p /var/log/portage/emerge-info/
  emerge --info > /var/log/portage/emerge-info/emerge-info-$(date "+%Y%m%d").txt
else #we are on a user system
  eselect python update
  eselect python cleanup
  [ "${NO_SYNC}" = "true" ] || do_sync
  check_profile
	if [ -d /var/db/repos/pentoo ] && [ -d /var/lib/layman/pentoo ]; then
    printf "Pentoo now manages it's overlay through portage instead of layman.\n"
    if [ -x /usr/bin/layman ]; then
		  if /usr/bin/layman -l | grep -q pentoo; then
        printf "Removing Pentoo overlay from layman...\n"
        layman --delete pentoo
        check_profile
      fi
    else
      printf "Cleaning up the mess left behind by layman...\n"
      rm -rf /var/lib/layman/pentoo
      #if layman isn't on the system, it's repos.conf entry should be gone as well
      [ -f /etc/portage/repos.conf/layman.conf ] && mv -f /etc/portage/repos.conf/layman.conf /etc/portage/repos.conf/layman.uninstalled
      grep -q '/var/lib/layman/make.conf' /etc/portage/make.conf && sed -i '/\/var\/lib\/layman\/make.conf/d' /etc/portage/make.conf
      check_profile
    fi
  fi
fi

#deep checks for python, including fix
RESET_PYTHON=0
#first we set the python interpreters to match PYTHON_TARGETS (and ensure the versions we set are actually built)
PYTHON2=$(emerge --info | grep -oE 'PYTHON_TARGETS\="(python[23]_[0-9]\s*)+"' | head -n1 | cut -d\" -f2 | cut -d" " -f 1 |sed 's#_#.#')
PYTHON3=$(emerge --info | grep -oE 'PYTHON_TARGETS\="(python[23]_[0-9]\s*)+"' | head -n1 | cut -d\" -f2 | cut -d" " -f 2 |sed 's#_#.#')
if [ -z "${PYTHON2}" ] || [ -z "${PYTHON3}" ]; then
  printf "Failed to autodetect PYTHON_TARGETS\n"
  printf "Detected Python 2: ${PYTHON2:-none}\n"
  printf "Detected Python 3: ${PYTHON3:-none}\n"
  printf "From PYTHON_TARGETS: $(emerge --info | grep '^PYTHON TARGETS')\n"
  exit 1
fi
if eselect python list --python2 | grep -q "${PYTHON2}"; then
  eselect python set --python2 "${PYTHON2}" || safe_exit
else
  printf "System wants ${PYTHON2} as default python2 version but it isn't installed yet.\n"
  RESET_PYTHON=1
fi
if eselect python list --python3 | grep -q "${PYTHON3}"; then
  eselect python set --python3 "${PYTHON3}" || safe_exit
else
  printf "System wants ${PYTHON3} as default python3 version but it isn't installed yet.\n"
  RESET_PYTHON=1
fi
"${PYTHON2}" -c "from _multiprocessing import SemLock" || emerge -1 python:"${PYTHON2#python}"
"${PYTHON3}" -c "from _multiprocessing import SemLock" || emerge -1 python:"${PYTHON3#python}"

#always update portage as early as we can (after making sure python works)
emerge --update --newuse --oneshot --changed-use --newrepo portage || safe_exit

#upgrade glibc first if we are using binpkgs
portage_features="$(portageq envvar FEATURES)"
if [ "${portage_features}" != "${portage_features/getbinpkg//}" ]; then
  #learned something new, if a package updates before glibc and uses the newer glibc, the chance of breakage is
  #*much* higher than if glibc is updated first.  so let's just update glibc first.
  emerge --update --newuse --oneshot --changed-use --newrepo glibc || safe_exit
fi

#modified from news item "Python ABIFLAGS rebuild needed"
if [ -n "$(find /usr/lib*/python3* -name '*cpython-3[3-5].so')" ]; then
  emerge -1v --usepkg=n --buildpkg=y $(find /usr/lib*/python3* -name '*cpython-3[3-5].so')
fi
if [ -n "$(find /usr/include/python3.[3-5] -type f 2> /dev/null)" ]; then
  emerge -1v --usepkg=n --buildpkg=y /usr/include/python3.[3-5]
fi

#modified from news item gcc-5-new-c++11-abi
#gcc_target="x86_64-pc-linux-gnu-5.4.0"
#if [ "$(gcc-config -c)" != "${gcc_target}" ]; then
#  if gcc-config -l | grep -q "${gcc_target}"; then
#    gcc-config "${gcc_target}"
#    . /etc/profile
#    revdep-rebuild --library 'libstdc++.so.6' -- --buildpkg=y --usepkg=n --exclude gcc
#  fi
#fi

#before we begin main installs, let's remove what may need removing
#handle hard blocks here, and like this
removeme=$(portageq match / '<dev-python/setuptools_scm-3')
if [ -n "${removeme}" ]; then
  emerge -C "=${removeme}"
fi

#main upgrades start here
if [ -n "${clst_target}" ]; then
  emerge @changed-deps || safe_exit
fi

emerge --deep --update --newuse -kb --changed-use --newrepo @world || safe_exit

perl-cleaner --ph-clean --modules -- --buildpkg=y || safe_exit

emerge --deep --update --newuse -kb --changed-use --newrepo @world || safe_exit

if [ ${RESET_PYTHON} = 1 ]; then
  eselect python set --python2 "${PYTHON2}" || safe_exit
  eselect python set --python3 "${PYTHON3}" || safe_exit
  "${PYTHON2}" -c "from _multiprocessing import SemLock" || emerge -1 python:"${PYTHON2#python}"
  "${PYTHON3}" -c "from _multiprocessing import SemLock" || emerge -1 python:"${PYTHON3#python}"
fi

#if we are in catalyst, update the extra binpkgs
if [ -n "${clst_target}" ]; then
  #add kde and mate use flags
  echo "pentoo/pentoo kde mate" >> /etc/portage/package.use
  emerge @changed-deps || safe_exit
  emerge --buildpkg --usepkg --onlydeps --oneshot --deep --update --newuse --changed-use --newrepo pentoo/pentoo || safe_exit
  etc-update --automode -5 || safe_exit
fi

if portageq list_preserved_libs /; then
  emerge @preserved-rebuild --buildpkg=y || safe_exit
fi
FEATURES="-getbinpkg" smart-live-rebuild 2>&1 || safe_exit
revdep-rebuild -i -v -- --usepkg=n --buildpkg=y || safe_exit
emerge --deep --update --newuse -kb --changed-use --newrepo @world || safe_exit

#we need to do the clean BEFORE we drop the extra flags otherwise all the packages we just built are removed
currkern="$(uname -r)"
if [ "${currkern/pentoo/}" != "${currkern}" ]; then
  EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS/--verbose /}" emerge --depclean --exclude "sys-kernel/pentoo-sources:${currkern/-pentoo/}" || safe_exit
elif [ "${currkern/gentoo/}" != "${currkern}" ]; then
  EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS/--verbose /}" emerge --depclean --exclude "sys-kernel/gentoo-sources:${currkern/-gentoo/}" || safe_exit
else
  EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS/--verbose /}" emerge --depclean || safe_exit
fi

if portageq list_preserved_libs /; then
  emerge @preserved-rebuild --buildpkg=y || safe_exit
fi

if [ -n "${clst_target}" ]; then
  if [ -n "${debugshell}" ]; then
    /bin/bash
  fi
  emerge @changed-deps || safe_exit
  etc-update --automode -5 || safe_exit
  fixpackages || safe_exit
  eclean-pkg -d -t 3m || safe_exit
  #this is already run as part of eclean-pkg
  #emaint --fix binhost || safe_exit
  #remove kde/mate use flags
  rm /etc/portage/package.use
else
  #clean the user's systems a bit
  eclean-pkg -d -t 3m
  eclean-dist -d -t 3m
fi

if [ -f /usr/local/portage/scripts/bug-461824.sh ]; then
  /usr/local/portage/scripts/bug-461824.sh
elif [ -f /var/lib/layman/pentoo/scripts/bug-461824.sh ]; then
  /var/lib/layman/pentoo/scripts/bug-461824.sh
elif [ -f /var/db/repos/pentoo/scripts/bug-461824.sh ]; then
  /var/db/repos/pentoo/scripts/bug-461824.sh
elif [ -f /var/gentoo/repos/local/scripts/bug-461824.sh ]; then
  /var/gentoo/repos/local/scripts/bug-461824.sh
fi

if [ -z "${clst_target}" ]; then
  update_kernel
fi
if [ "${WE_FAILED}" = "1" ]; then
  printf "\nSomething failed during update. Run pentoo-updater again, if you see\n"
  printf "this message again, look through the log at /tmp/pentoo-updater.log for:\n"
  printf "FAILURE FAILURE FAILURE\n\n"
  printf "For support via irc or discord you can pastebin your log like this (and share the link in chat):\n"
  printf "wgetpaste -s bpaste /tmp/pentoo-updater.log\n\n"
  exit 1
fi
