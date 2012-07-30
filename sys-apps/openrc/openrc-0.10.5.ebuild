# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/openrc/openrc-0.10.5.ebuild,v 1.1 2012/07/04 14:36:33 williamh Exp $

EAPI=4

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/${PN}.git"
[[ ${PV} == "9999" ]] && SCM_ECLASS="git-2"
inherit eutils flag-o-matic multilib pam toolchain-funcs ${SCM_ECLASS}
unset SCM_ECLASS

DESCRIPTION="OpenRC manages the services, startup and shutdown of a host"
HOMEPAGE="http://www.gentoo.org/proj/en/base/openrc/"
if [[ ${PV} != "9999" ]] ; then
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="debug elibc_glibc ncurses pam pentoo selinux static-libs unicode kernel_linux kernel_FreeBSD"

RDEPEND="virtual/init
	kernel_FreeBSD? ( || ( >=sys-freebsd/freebsd-ubin-9.0_rc sys-process/fuser-bsd ) )
	elibc_glibc? ( >=sys-libs/glibc-2.5 )
	ncurses? ( sys-libs/ncurses )
	pam? ( sys-auth/pambase )
	>=sys-apps/baselayout-2.1-r1
	kernel_linux? (
		sys-process/psmisc
	)
	!<sys-fs/udev-133"
DEPEND="${RDEPEND}
	virtual/os-headers"

make_args() {
	unset LIBDIR #266688

	MAKE_ARGS="${MAKE_ARGS} LIBNAME=$(get_libdir) LIBEXECDIR=/$(get_libdir)/rc"

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
}

pkg_setup() {
	export DEBUG=$(usev debug)
	export MKPAM=$(usev pam)
	export MKTERMCAP=$(usev ncurses)
}

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
	make_args

	tc-export CC AR RANLIB
	emake ${MAKE_ARGS}
}

# set_config <file> <option name> <yes value> <no value> test
# a value of "#" will just comment out the option
set_config() {
	local file="${D}/$1" var=$2 val com
	eval "${@:5}" && val=$3 || val=$4
	[[ ${val} == "#" ]] && com="#" && val='\2'
	sed -i -r -e "/^#?${var}=/{s:=([\"'])?([^ ]*)\1?:=\1${val}\1:;s:^#?:${com}:}" "${file}"
}

set_config_yes_no() {
	set_config "$1" "$2" YES NO "${@:3}"
}

src_install() {
	make_args
	emake ${MAKE_ARGS} DESTDIR="${D}" install

	# move the shared libs back to /usr so ldscript can install
	# more of a minimal set of files
	# disabled for now due to #270646
	#mv "${D}"/$(get_libdir)/lib{einfo,rc}* "${D}"/usr/$(get_libdir)/ || die
	#gen_usr_ldscript -a einfo rc
	gen_usr_ldscript libeinfo.so
	gen_usr_ldscript librc.so

	if ! use kernel_linux; then
		keepdir /$(get_libdir)/rc/init.d
	fi
	keepdir /$(get_libdir)/rc/tmp

	# Backup our default runlevels
	dodir /usr/share/"${PN}"
	cp -PR "${D}"/etc/runlevels "${D}"/usr/share/${PN} || die
	rm -rf "${D}"/etc/runlevels

	# Install the default net configuration
	doconfd conf.d/net

	# Setup unicode defaults for silly unicode users
	set_config_yes_no /etc/rc.conf unicode use unicode

	# Cater to the norm
	set_config_yes_no /etc/conf.d/keymaps windowkeys '(' use x86 '||' use amd64 ')'

	# On HPPA, do not run consolefont by default (bug #222889)
	if use hppa; then
		rm -f "${D}"/usr/share/openrc/runlevels/boot/consolefont
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
	[[ -e ${D}/etc/init.d/${initd} || -e ${ROOT}/etc/init.d/${initd} ]] \
		|| return
	[[ -e ${ROOT}/etc/runlevels/${runlevel}/${initd} ]] && return

	# if runlevels dont exist just yet, then create it but still flag
	# to pkg_postinst that it needs real setup #277323
	if [[ ! -d ${ROOT}/etc/runlevels/${runlevel} ]] ; then
		mkdir -p "${ROOT}"/etc/runlevels/${runlevel}
		touch "${ROOT}"/etc/runlevels/.add_boot_init.created
	fi

	elog "Auto-adding '${initd}' service to your ${runlevel} runlevel"
	ln -snf /etc/init.d/${initd} "${ROOT}"/etc/runlevels/${runlevel}/${initd}
}
add_boot_init_mit_config() {
	local config=$1 initd=$2
	if [[ -e ${ROOT}${config} ]] ; then
		if [[ -n $(sed -e 's:#.*::' -e '/^[[:space:]]*$/d' "${ROOT}"/${config}) ]] ; then
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
	[[ -e ${ROOT}/etc/conf.d/net ]] && cp "${ROOT}"/etc/conf.d/net "${D}"/etc/conf.d/

	# avoid default thrashing in conf.d files when possible #295406
	if [[ -e ${ROOT}/etc/conf.d/hostname ]] ; then
		(
		unset hostname HOSTNAME
		source "${ROOT}"/etc/conf.d/hostname
		: ${hostname:=${HOSTNAME}}
		[[ -n ${hostname} ]] && set_config /etc/conf.d/hostname hostname "${hostname}"
		)
	fi

	# upgrade timezone file ... do it before moving clock
	if [[ -e ${ROOT}/etc/conf.d/clock && ! -e ${ROOT}/etc/timezone ]] ; then
		(
		unset TIMEZONE
		source "${ROOT}"/etc/conf.d/clock
		[[ -n ${TIMEZONE} ]] && echo "${TIMEZONE}" > "${ROOT}"/etc/timezone
		)
	fi

	# /etc/conf.d/clock moved to /etc/conf.d/hwclock
	local clock
	use kernel_FreeBSD && clock="adjkerntz" || clock="hwclock"
	if [[ -e ${ROOT}/etc/conf.d/clock ]] ; then
		mv "${ROOT}"/etc/conf.d/clock "${ROOT}"/etc/conf.d/${clock}
	fi
	if [[ -e ${ROOT}/etc/init.d/clock ]] ; then
		rm -f "${ROOT}"/etc/init.d/clock
	fi
	if [[ -L ${ROOT}/etc/runlevels/boot/clock ]] ; then
		rm -f "${ROOT}"/etc/runlevels/boot/clock
		ln -snf /etc/init.d/${clock} "${ROOT}"/etc/runlevels/boot/${clock}
	fi
	if [[ -L ${ROOT}${LIBDIR}/rc/init.d/started/clock ]] ; then
		rm -f "${ROOT}${LIBDIR}"/rc/init.d/started/clock
		ln -snf /etc/init.d/${clock} "${ROOT}${LIBDIR}"/rc/init.d/started/${clock}
	fi

	# /etc/conf.d/rc is no longer used for configuration
	if [[ -e ${ROOT}/etc/conf.d/rc ]] ; then
		elog "/etc/conf.d/rc is no longer used for configuration."
		elog "Please migrate your settings to /etc/rc.conf as applicable"
		elog "and delete /etc/conf.d/rc"
	fi

	# force net init.d scripts into symlinks
	for f in "${ROOT}"/etc/init.d/net.* ; do
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

	# set default interactive shell to sulogin if it exists
	set_config /etc/rc.conf rc_shell /sbin/sulogin "#" test -e /sbin/sulogin

	has_version sys-apps/openrc || migrate_from_baselayout_1
	has_version ">=sys-apps/openrc-0.4.0" || migrate_udev_init_script
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

migrate_from_baselayout_1() {
	# baselayout boot init scripts have been split out
	for f in $(cd "${D}"/usr/share/${PN}/runlevels/boot || exit; echo *) ; do
		# baselayout-1 is always "old" net, so ignore "new" net
		[[ ${f} == "network" ]] && continue

		add_boot_init ${f}
	done

	# Try to auto-add some addons when possible
	add_boot_init_mit_config /etc/conf.d/cryptfs dmcrypt
	add_boot_init_mit_config /etc/conf.d/dmcrypt dmcrypt
	add_boot_init_mit_config /etc/mdadm.conf mdraid
	add_boot_init_mit_config /etc/evms.conf evms
	[[ -e ${ROOT}/sbin/dmsetup ]] && add_boot_init device-mapper
	[[ -e ${ROOT}/sbin/vgscan ]] && add_boot_init lvm
	elog "Add on services (such as RAID/dmcrypt/LVM/etc...) are now stand alone"
	elog "init.d scripts.  If you use such a thing, make sure you have the"
	elog "required init.d scripts added to your boot runlevel."

	# Upgrade our state for baselayout-1 users
	if [[ ! -e ${ROOT}${LIBDIR}/rc/init.d/started ]] ; then
		(
		[[ -e ${ROOT}/etc/conf.d/rc ]] && source "${ROOT}"/etc/conf.d/rc
		svcdir=${svcdir:-/var/lib/init.d}
		if [[ ! -d ${ROOT}${svcdir}/started ]] ; then
			ewarn "No state found, and no state exists"
			elog "You should reboot this host"
		else
			mkdir -p "${ROOT}${LIBDIR}/rc/init.d"
			einfo "Moving state from ${ROOT}${svcdir} to ${ROOT}${LIBDIR}/rc/init.d"
			mv "${ROOT}${svcdir}"/* "${ROOT}${LIBDIR}"/rc/init.d
			rm -rf "${ROOT}${LIBDIR}"/rc/init.d/daemons \
				"${ROOT}${LIBDIR}"/rc/init.d/console
			umount "${ROOT}${svcdir}" 2>/dev/null
			rm -rf "${ROOT}${svcdir}"
		fi
		)
	fi

	# Handle the /etc/modules.autoload.d -> /etc/conf.d/modules transition
	if [[ -d ${ROOT}/etc/modules.autoload.d ]] ; then
		elog "Converting your /etc/modules.autoload.d/ files to /etc/conf.d/modules"
		rm -f "${ROOT}"/etc/modules.autoload.d/.keep*
		rmdir "${ROOT}"/etc/modules.autoload.d 2>/dev/null
		if [[ -d ${ROOT}/etc/modules.autoload.d ]] ; then
			local f v
			for f in "${ROOT}"/etc/modules.autoload.d/* ; do
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
				' "${f}" >> "${D}"/etc/conf.d/modules
			done
				rm -f "${f}"
			rmdir "${ROOT}"/etc/modules.autoload.d 2>/dev/null
		fi
	fi
}

pkg_postinst() {
	local LIBDIR=$(get_libdir)

	# Remove old baselayout links
	rm -f "${ROOT}"/etc/runlevels/boot/{check{fs,root},rmnologin}
	rm -f "${ROOT}"/etc/init.d/{depscan,runscript}.sh

	# Make our runlevels if they don't exist
	if [[ ! -e ${ROOT}/etc/runlevels ]] || [[ -e ${ROOT}/etc/runlevels/.add_boot_init.created ]] ; then
		einfo "Copying across default runlevels"
		cp -RPp "${ROOT}"/usr/share/${PN}/runlevels "${ROOT}"/etc
		rm -f "${ROOT}"/etc/runlevels/.add_boot_init.created
	else
		if [[ ! -e ${ROOT}/etc/runlevels/sysinit/devfs ]] ; then
			mkdir -p "${ROOT}"/etc/runlevels/sysinit
			cp -RPp "${ROOT}"/usr/share/${PN}/runlevels/sysinit/* \
				"${ROOT}"/etc/runlevels/sysinit
		fi
		if [[ ! -e ${ROOT}/etc/runlevels/shutdown/mount-ro ]] ; then
			mkdir -p "${ROOT}"/etc/runlevels/shutdown
			cp -RPp "${ROOT}"/usr/share/${PN}/runlevels/shutdown/* \
				"${ROOT}"/etc/runlevels/shutdown
		fi
	fi

	# /etc/conf.d/net.example is no longer valid
	local NET_EXAMPLE="${ROOT}/etc/conf.d/net.example"
	local NET_MD5='8ebebfa07441d39eb54feae0ee4c8210'
	if [[ -e "${NET_EXAMPLE}" ]] ; then
		if [[ $(md5sum "${NET_EXAMPLE}") == ${NET_MD5}* ]]; then
			rm -f "${NET_EXAMPLE}"
			elog "${NET_EXAMPLE} has been removed."
		else
			sed -i '1i# This file is obsolete.\n' "${NET_EXAMPLE}"
			elog "${NET_EXAMPLE} should be removed."
		fi
		elog "The new file is ${ROOT}/usr/share/doc/${PF}/net.example"
	fi

	# /etc/conf.d/wireless.example is no longer valid
	local WIRELESS_EXAMPLE="${ROOT}/etc/conf.d/wireless.example"
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
		elog "Configure wireless settings in ${ROOT}/etc/conf.d/net"
		elog "after reviewing ${ROOT}/usr/share/doc/${PF}/net.example"
	fi

	if [[ -d ${ROOT}/etc/modules.autoload.d ]] ; then
		ewarn "/etc/modules.autoload.d is no longer used.  Please convert"
		ewarn "your files to /etc/conf.d/modules and delete the directory."
	fi

	if use hppa; then
		elog "Setting the console font does not work on all HPPA consoles."
		elog "You can still enable it by running:"
		elog "# rc-update add consolefont boot"
	fi

	# Handle the conf.d/local.{start,stop} -> local.d transition
	if path_exists -o "${ROOT}"etc/conf.d/local.{start,stop} ; then
		elog "Moving your ${ROOT}etc/conf.d/local.{start,stop}"
		elog "files to ${ROOT}etc/local.d"
		mv "${ROOT}"etc/conf.d/local.start "${ROOT}"etc/local.d/baselayout1.start
		mv "${ROOT}"etc/conf.d/local.stop "${ROOT}"etc/local.d/baselayout1.stop
		chmod +x "${ROOT}"etc/local.d/*{start,stop}
	fi

	if use kernel_linux && [[ "${ROOT}" = "/" ]]; then
		use pentoo && cp "${FILESDIR}"/*.start "${ROOT}"etc/local.d/
		use pentoo && chmod +x "${ROOT}"etc/local.d/*.{start,stop}
		if ! /$(get_libdir)/rc/sh/migrate-to-run.sh; then
			ewarn "The dependency data could not be migrated to /run/openrc."
			ewarn "This means you need to reboot your system."
		fi
	fi

	# update the dependency tree after touching all files #224171
	[[ "${ROOT}" = "/" ]] && "${ROOT}/${LIBDIR}"/rc/bin/rc-depend -u

	elog "You should now update all files in /etc, using etc-update"
	elog "or equivalent before restarting any services or this host."
	elog
	elog "Please read the migration guide available at:"
	elog "http://www.gentoo.org/doc/en/openrc-migration.xml"
}
