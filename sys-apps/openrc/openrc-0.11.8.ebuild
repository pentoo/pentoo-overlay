# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/openrc/openrc-0.11.8.ebuild,v 1.13 2013/08/11 06:56:36 ssuominen Exp $

EAPI=4

inherit eutils flag-o-matic multilib pam toolchain-funcs

DESCRIPTION="OpenRC manages the services, startup and shutdown of a host"
HOMEPAGE="http://www.gentoo.org/proj/en/base/openrc/"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/${PN}.git"
	inherit git-2
else
	SRC_URI="http://dev.gentoo.org/~williamh/dist/${P}.tar.bz2"
	KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="debug elibc_glibc ncurses pam pentoo newnet prefix selinux static-libs unicode
	kernel_linux kernel_FreeBSD"

COMMON_DEPEND=">=sys-apps/baselayout-2.1-r1
	kernel_FreeBSD? ( || ( >=sys-freebsd/freebsd-ubin-9.0_rc sys-process/fuser-bsd ) )
	elibc_glibc? ( >=sys-libs/glibc-2.5 )
	pam? ( sys-auth/pambase )
	kernel_linux? (
		sys-process/psmisc
	)
	selinux? ( sec-policy/selinux-openrc )
	!<sys-fs/udev-init-scripts-17
	!<sys-fs/udev-133"
DEPEND="${COMMON_DEPEND}
	ncurses? ( sys-libs/ncurses[-tinfo] )
	virtual/os-headers"
RDEPEND="${COMMON_DEPEND}
	!prefix? (
		kernel_linux? ( || ( >=sys-apps/sysvinit-2.86-r6 sys-process/runit ) )
		kernel_FreeBSD? ( sys-freebsd/freebsd-sbin )
	)
	ncurses? ( sys-libs/ncurses )"

src_prepare() {
	sed -i 's:0444:0644:' mk/sys.mk || die
	sed -i "/^DIR/s:/openrc:/${PF}:" doc/Makefile || die #241342

	if [[ ${PV} == "9999" ]] ; then
		local ver="git-${EGIT_VERSION:0:6}"
		sed -i "/^GITVER[[:space:]]*=/s:=.*:=${ver}:" mk/git.mk || die
	fi

	# Allow user patches to be applied without modifying the ebuild
	epatch_user
}

src_compile() {
	unset LIBDIR #266688

	MAKE_ARGS="${MAKE_ARGS}
		LIBNAME=$(get_libdir)
		LIBEXECDIR=${EPREFIX}/$(get_libdir)/rc"

	local brand="Unknown"
	if use kernel_linux ; then
		MAKE_ARGS="${MAKE_ARGS} OS=Linux"
		brand="Linux"
	elif use kernel_FreeBSD ; then
		MAKE_ARGS="${MAKE_ARGS} OS=FreeBSD"
		brand="FreeBSD"
	fi
	if use selinux; then
			MAKE_ARGS="${MAKE_ARGS} MKSELINUX=yes"
	fi
	if use pentoo ; then
		export BRANDING="Pentoo ${brand}"
	else
		export BRANDING="Gentoo ${brand}"
	fi
	if ! use static-libs; then
			MAKE_ARGS="${MAKE_ARGS} MKSTATICLIBS=no"
	fi
	use newnet || MAKE_ARGS="${MAKE_ARGS} MKNET=oldnet"
	use prefix && MAKE_ARGS="${MAKE_ARGS} MKPREFIX=yes PREFIX=${EPREFIX}"
	export DEBUG=$(usev debug)
	export MKPAM=$(usev pam)
	export MKTERMCAP=$(usev ncurses)

	tc-export CC AR RANLIB
	emake ${MAKE_ARGS}
}

# set_config <file> <option name> <yes value> <no value> test
# a value of "#" will just comment out the option
set_config() {
	local file="${ED}/$1" var=$2 val com
	eval "${@:5}" && val=$3 || val=$4
	[[ ${val} == "#" ]] && com="#" && val='\2'
	sed -i -r -e "/^#?${var}=/{s:=([\"'])?([^ ]*)\1?:=\1${val}\1:;s:^#?:${com}:}" "${file}"
}

set_config_yes_no() {
	set_config "$1" "$2" YES NO "${@:3}"
}

src_install() {
	emake ${MAKE_ARGS} DESTDIR="${D}" install

	# move the shared libs back to /usr so ldscript can install
	# more of a minimal set of files
	# disabled for now due to #270646
	#mv "${ED}"/$(get_libdir)/lib{einfo,rc}* "${ED}"/usr/$(get_libdir)/ || die
	#gen_usr_ldscript -a einfo rc
	gen_usr_ldscript libeinfo.so
	gen_usr_ldscript librc.so

	if ! use kernel_linux; then
		keepdir /$(get_libdir)/rc/init.d
	fi
	keepdir /$(get_libdir)/rc/tmp

	# Backup our default runlevels
	dodir /usr/share/"${PN}"
	cp -PR "${ED}"/etc/runlevels "${ED}"/usr/share/${PN} || die
	rm -rf "${ED}"/etc/runlevels

	# Install the default net configuration
	doconfd conf.d/net

	# Setup unicode defaults for silly unicode users
	set_config_yes_no /etc/rc.conf unicode use unicode

	# Cater to the norm
	set_config_yes_no /etc/conf.d/keymaps windowkeys '(' use x86 '||' use amd64 ')'

	# On HPPA, do not run consolefont by default (bug #222889)
	if use hppa; then
		rm -f "${ED}"/usr/share/openrc/runlevels/boot/consolefont
	fi

	# Support for logfile rotation
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/openrc.logrotate openrc

	# install the gentoo pam.d file
	newpamd "${FILESDIR}"/start-stop-daemon.pam start-stop-daemon
}

add_boot_init() {
	local initd=$1
	local runlevel=${2:-boot}
	# if the initscript is not going to be installed and is not
	# currently installed, return
	[[ -e "${ED}"/etc/init.d/${initd} || -e "${EROOT}"etc/init.d/${initd} ]] \
		|| return
	[[ -e "${EROOT}"etc/runlevels/${runlevel}/${initd} ]] && return

	# if runlevels dont exist just yet, then create it but still flag
	# to pkg_postinst that it needs real setup #277323
	if [[ ! -d "${EROOT}"etc/runlevels/${runlevel} ]] ; then
		mkdir -p "${EROOT}"etc/runlevels/${runlevel}
		touch "${EROOT}"etc/runlevels/.add_boot_init.created
	fi

	elog "Auto-adding '${initd}' service to your ${runlevel} runlevel"
	ln -snf /etc/init.d/${initd} "${EROOT}"etc/runlevels/${runlevel}/${initd}
}
add_boot_init_mit_config() {
	local config=$1 initd=$2
	if [[ -e ${EROOT}${config} ]] ; then
		if [[ -n $(sed -e 's:#.*::' -e '/^[[:space:]]*$/d' "${EROOT}"${config}) ]] ; then
			add_boot_init ${initd}
		fi
	fi
}

pkg_preinst() {
	local f LIBDIR=$(get_libdir)

	# default net script is just comments, so no point in biting people
	# in the ass by accident.  we save in preinst so that the package
	# manager doesnt go throwing etc-update crap at us -- postinst is
	# too late to prevent that.  this behavior also lets us keep the
	# file in the CONTENTS for binary packages.
	[[ -e "${EROOT}"etc/conf.d/net ]] && \
		cp "${EROOT}"etc/conf.d/net "${ED}"/etc/conf.d/

	# avoid default thrashing in conf.d files when possible #295406
	if [[ -e "${EROOT}"etc/conf.d/hostname ]] ; then
		(
		unset hostname HOSTNAME
		source "${EROOT}"etc/conf.d/hostname
		: ${hostname:=${HOSTNAME}}
		[[ -n ${hostname} ]] && set_config /etc/conf.d/hostname hostname "${hostname}"
		)
	fi

	# upgrade timezone file ... do it before moving clock
	if [[ -e ${EROOT}etc/conf.d/clock && ! -e ${EROOT}/etc/timezone ]] ; then
		(
		unset TIMEZONE
		source "${EROOT}"etc/conf.d/clock
		[[ -n ${TIMEZONE} ]] && echo "${TIMEZONE}" > "${EROOT}"etc/timezone
		)
	fi

	# /etc/conf.d/clock moved to /etc/conf.d/hwclock
	local clock
	use kernel_FreeBSD && clock="adjkerntz" || clock="hwclock"
	if [[ -e "${EROOT}"etc/conf.d/clock ]] ; then
		mv "${EROOT}"etc/conf.d/clock "${EROOT}"etc/conf.d/${clock}
	fi
	if [[ -e "${EROOT}"etc/init.d/clock ]] ; then
		rm -f "${EROOT}"etc/init.d/clock
	fi
	if [[ -L "${EROOT}"etc/runlevels/boot/clock ]] ; then
		rm -f "${EROOT}"etc/runlevels/boot/clock
		ln -snf /etc/init.d/${clock} "${EROOT}"etc/runlevels/boot/${clock}
	fi
	if [[ -L "${EROOT}"${LIBDIR}/rc/init.d/started/clock ]] ; then
		rm -f "${EROOT}"${LIBDIR}/rc/init.d/started/clock
		ln -snf /etc/init.d/${clok} "${EROOT}"${LIBDIR}/rc/init.d/started/${clock}
	fi

	# /etc/conf.d/rc is no longer used for configuration
	if [[ -e "${EROOT}"etc/conf.d/rc ]] ; then
		elog "/etc/conf.d/rc is no longer used for configuration."
		elog "Please migrate your settings to /etc/rc.conf as applicable"
		elog "and delete /etc/conf.d/rc"
	fi

	# force net init.d scripts into symlinks
	for f in "${EROOT}"etc/init.d/net.* ; do
		[[ -e ${f} ]] || continue # catch net.* not matching anything
		[[ ${f} == */net.lo ]] && continue # real file now
		[[ ${f} == *.openrc.bak ]] && continue
		if [[ ! -L ${f} ]] ; then
			elog "Moved net service '${f##*/}' to '${f##*/}.openrc.bak' to force a symlink."
			elog "You should delete '${f##*/}.openrc.bak' if you don't need it."
			mv "${f}" "${f}.openrc.bak"
			ln -snf net.lo "${f}"
		fi
	done

	# termencoding was added in 0.2.1 and needed in boot
	has_version ">=sys-apps/openrc-0.2.1" || add_boot_init termencoding

	# swapfiles was added in 0.9.9 and needed in boot (february 2012)
	has_version ">=sys-apps/openrc-0.9.9" || add_boot_init swapfiles

	if ! has_version ">=sys-apps/openrc-0.11"; then
		add_boot_init sysfs sysinit
	fi

	# set default interactive shell to sulogin if it exists
	set_config /etc/rc.conf rc_shell /sbin/sulogin "#" test -e /sbin/sulogin

	has_version sys-apps/openrc || migrate_from_baselayout_1
	has_version ">=sys-apps/openrc-0.4.0" || migrate_udev_init_script
	if ! has_version ">=sys-apps/openrc-0.11.3" ; then
		migrate_udev_mount_script
		add_boot_init tmpfiles.setup boot
	fi
}

# >=openrc-0.4.0 no longer loads the udev addon
migrate_udev_init_script() {
	# make sure udev is in sysinit if it was enabled before
	local enable_udev=false
	local rc_devices=$(
		[[ -f /etc/rc.conf ]] && source /etc/rc.conf
		[[ -f /etc/conf.d/rc ]] && source /etc/conf.d/rc
		echo "${rc_devices:-${RC_DEVICES:-auto}}"
	)
	case ${rc_devices} in
		udev|auto)
			enable_udev=true
			;;
	esac

	if $enable_udev; then
		add_boot_init udev sysinit
		add_boot_init udev-postmount default
	fi
}

# >=OpenRC-0.11.3 requires udev-mount to be in the sysinit runlevel with udev.
migrate_udev_mount_script() {
	if [ -e "${EROOT}"etc/runlevels/sysinit/udev -a \
		! -e "${EROOT}"etc/runlevels/sysinit/udev-mount ]; then
		add_boot_init udev-mount sysinit
	fi
	return 0
}

migrate_from_baselayout_1() {
	# baselayout boot init scripts have been split out
	for f in $(cd "${ED}"/usr/share/${PN}/runlevels/boot || exit; echo *) ; do
		# baselayout-1 is always "old" net, so ignore "new" net
		[[ ${f} == "network" ]] && continue

		add_boot_init ${f}
	done

	# Try to auto-add some addons when possible
	add_boot_init_mit_config /etc/conf.d/cryptfs dmcrypt
	add_boot_init_mit_config /etc/conf.d/dmcrypt dmcrypt
	add_boot_init_mit_config /etc/mdadm.conf mdraid
	add_boot_init_mit_config /etc/evms.conf evms
	[[ -e "${EROOT}"sbin/dmsetup ]] && add_boot_init device-mapper
	[[ -e "${EROOT}"sbin/vgscan ]] && add_boot_init lvm
	elog "Add on services (such as RAID/dmcrypt/LVM/etc...) are now stand alone"
	elog "init.d scripts.  If you use such a thing, make sure you have the"
	elog "required init.d scripts added to your boot runlevel."

	# Upgrade our state for baselayout-1 users
	if [[ ! -e "${EROOT}"${LIBDIR}/rc/init.d/started ]] ; then
		(
		[[ -e "${EROOT}"etc/conf.d/rc ]] && source "${EROOT}"/etc/conf.d/rc
		svcdir=${svcdir:-/var/lib/init.d}
		if [[ ! -d "${EROOT}"${svcdir}/started ]] ; then
			ewarn "No state found, and no state exists"
			elog "You should reboot this host"
		else
			mkdir -p "${EROOT}"${LIBDIR}/rc/init.d
			einfo "Moving state from ${EROOT}${svcdir} to ${EROOT}${LIBDIR}/rc/init.d"
			mv "${EROOT}${svcdir}"/* "${EROOT}${LIBDIR}"/rc/init.d
			rm -rf "${EROOT}${LIBDIR}"/rc/init.d/daemons \
				"${EROOT}${LIBDIR}"/rc/init.d/console
			umount "${EROOT}${svcdir}" 2>/dev/null
			rm -rf "${EROOT}${svcdir}"
		fi
		)
	fi

	# Handle the /etc/modules.autoload.d -> /etc/conf.d/modules transition
	if [[ -d "${EROOT}"etc/modules.autoload.d ]] ; then
		elog "Converting your /etc/modules.autoload.d/ files to /etc/conf.d/modules"
		rm -f "${EROOT}"etc/modules.autoload.d/.keep*
		rmdir "${EROOT}"etc/modules.autoload.d 2>/dev/null
		if [[ -d "${EROOT}"etc/modules.autoload.d ]] ; then
			local f v
			for f in "${EROOT}"etc/modules.autoload.d/* ; do
				v=${f##*/}
				v=${v#kernel-}
				v=${v//[^[:alnum:]]/_}
				gawk -v v="${v}" -v f="${f##*/}" '
				BEGIN { print "\n### START: Auto-converted from " f "\n" }
				{
					if ($0 ~ /^[^#]/) {
						print "modules_" v "=\"${modules_" v "} " $1 "\""
						gsub(/[^[:alnum:]]/, "_", $1)
						printf "module_" $1 "_args_" v "=\""
						for (i = 2; i <= NF; ++i) {
							if (i > 2)
								printf " "
							printf $i
						}
						print "\"\n"
					} else
						print
				}
				END { print "\n### END: Auto-converted from " f "\n" }
				' "${f}" >> "${ED}"/etc/conf.d/modules
			done
				rm -f "${f}"
			rmdir "${EROOT}"etc/modules.autoload.d 2>/dev/null
		fi
	fi
}

pkg_postinst() {
	local LIBDIR=$(get_libdir)

	# Remove old baselayout links
	rm -f "${EROOT}"etc/runlevels/boot/{check{fs,root},rmnologin}
	rm -f "${EROOT}"etc/init.d/{depscan,runscript}.sh

	# Make our runlevels if they don't exist
	if [[ ! -e "${EROOT}"etc/runlevels ]] || [[ -e "${EROOT}"etc/runlevels/.add_boot_init.created ]] ; then
		einfo "Copying across default runlevels"
		cp -RPp "${EROOT}"usr/share/${PN}/runlevels "${EROOT}"etc
		rm -f "${EROOT}"etc/runlevels/.add_boot_init.created
	else
		if [[ ! -e "${EROOT}"etc/runlevels/sysinit/devfs ]] ; then
			mkdir -p "${EROOT}"etc/runlevels/sysinit
			cp -RPp "${EROOT}"usr/share/${PN}/runlevels/sysinit/* \
				"${EROOT}"etc/runlevels/sysinit
		fi
		if [[ ! -e "${EROOT}"etc/runlevels/shutdown/mount-ro ]] ; then
			mkdir -p "${EROOT}"etc/runlevels/shutdown
			cp -RPp "${EROOT}"usr/share/${PN}/runlevels/shutdown/* \
				"${EROOT}"etc/runlevels/shutdown
		fi
	fi

	# /etc/conf.d/net.example is no longer valid
	local NET_EXAMPLE="${EROOT}etc/conf.d/net.example"
	local NET_MD5='8ebebfa07441d39eb54feae0ee4c8210'
	if [[ -e "${NET_EXAMPLE}" ]] ; then
		if [[ $(md5sum "${NET_EXAMPLE}") == ${NET_MD5}* ]]; then
			rm -f "${NET_EXAMPLE}"
			elog "${NET_EXAMPLE} has been removed."
		else
			sed -i '1i# This file is obsolete.\n' "${NET_EXAMPLE}"
			elog "${NET_EXAMPLE} should be removed."
		fi
		elog "The new file is ${EROOT}usr/share/doc/${PF}/net.example"
	fi

	# /etc/conf.d/wireless.example is no longer valid
	local WIRELESS_EXAMPLE="${EROOT}etc/conf.d/wireless.example"
	local WIRELESS_MD5='d1fad7da940bf263c76af4d2082124a3'
	if [[ -e "${WIRELESS_EXAMPLE}" ]] ; then
		if [[ $(md5sum "${WIRELESS_EXAMPLE}") == ${WIRELESS_MD5}* ]]; then
			rm -f "${WIRELESS_EXAMPLE}"
			elog "${WIRELESS_EXAMPLE} is deprecated and has been removed."
		else
			sed -i '1i# This file is obsolete.\n' "${WIRELESS_EXAMPLE}"
			elog "${WIRELESS_EXAMPLE} is deprecated and should be removed."
		fi
		elog "If you are using the old style network scripts,"
		elog "Configure wireless settings in ${EROOT}etc/conf.d/net"
		elog "after reviewing ${EROOT}usr/share/doc/${PF}/net.example"
	fi

	if [[ -d "${EROOT}"etc/modules.autoload.d ]] ; then
		ewarn "/etc/modules.autoload.d is no longer used.  Please convert"
		ewarn "your files to /etc/conf.d/modules and delete the directory."
	fi

	if use hppa; then
		elog "Setting the console font does not work on all HPPA consoles."
		elog "You can still enable it by running:"
		elog "# rc-update add consolefont boot"
	fi

	# Handle the conf.d/local.{start,stop} -> local.d transition
	if path_exists -o "${EROOT}"etc/conf.d/local.{start,stop} ; then
		elog "Moving your ${EROOT}etc/conf.d/local.{start,stop}"
		elog "files to ${EROOT}etc/local.d"
		mv "${EROOT}"etc/conf.d/local.start "${EROOT}"etc/local.d/baselayout1.start
		mv "${EROOT}"etc/conf.d/local.stop "${EROOT}"etc/local.d/baselayout1.stop
		chmod +x "${EROOT}"etc/local.d/*{start,stop}
	fi

	if use kernel_linux && [[ "${EROOT}" = "/" ]]; then
		/$(get_libdir)/rc/sh/migrate-to-run.sh
	fi

	# update the dependency tree after touching all files #224171
	[[ "${EROOT}" = "/" ]] && "${EROOT}/${LIBDIR}"/rc/bin/rc-depend -u

	if use newnet; then
		local netscript=network
	else
		local netscript=net.lo
	fi

	if [ ! -e "${EROOT}"etc/runlevels/boot/${netscript} ]; then
		ewarn "Please add the $netscript script to your boot runlevel"
		ewarn "as soon as possible. Not doing so could leave you with a system"
		ewarn "without networking."
	fi

	ewarn "In this version of OpenRC, the loopback interface no longer"
	ewarn "satisfies the net virtual."
	ewarn "If you have services now which do not start because of this,"
	ewarn "They can be fixed by adding rc_need=\"!net\""
	ewarn "to the ${EROOT}etc/conf.d/<servicename> file."
	ewarn "You should also file a bug against the service asking that"
	ewarn "need net be dropped from the dependencies."
	ewarn "The bug you file should block the following tracker:"
	ewarn "https://bugs.gentoo.org/show_bug.cgi?id=439092"

	ewarn "This version of OpenRC doesn't enable nfs mounts automatically any"
	ewarn "longer. In order to mount nfs file systems, you must use the"
	ewarn "nfsmount service from the nfs-utils package."
	ewarn "See bug https://bugs.gentoo.org/show_bug.cgi?id=427996 for"
	ewarn "more information on this."

	elog "You should now update all files in /etc, using etc-update"
	elog "or equivalent before restarting any services or this host."
	elog
	elog "Please read the migration guide available at:"
	elog "http://www.gentoo.org/doc/en/openrc-migration.xml"
}
