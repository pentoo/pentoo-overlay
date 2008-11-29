# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/unionfs/unionfs-1.3.ebuild,v 1.3 2006/10/22 18:05:00 swegener Exp $

inherit eutils linux-mod

DESCRIPTION="Stackable unification file system, which can appear to merge the contents of several directories"
HOMEPAGE="http://www.fsl.cs.sunysb.edu/project-unionfs.html"
SRC_URI="ftp://ftp.fsl.cs.sunysb.edu/pub/unionfs/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="acl debug nfs"

local_version_info() {
	ewarn
	ewarn "you need the proper kernel version!"
	ewarn
	einfo "kernel: 2.4.x (x>19)    Version: 1.0.14"
	einfo "kernel: 2.6.x (x<9)     Version: Not Supported"
	einfo "kernel: 2.6.9 - 2.6.15  Version: 1.1.5"
	einfo "kernel: 2.6.16          Version: 1.2"
	einfo "kernel: 2.6.17          Version: 1.3"
}

pkg_setup() {
	# kernel version check
	if ! kernel_is eq 2 6 18; then
		local_version_info
		die
	fi

	linux-mod_pkg_setup

	MODULE_NAMES="unionfs(kernel/fs/${PN}:)"
	BUILD_TARGETS="all"
	BUILD_PARAMS="LINUXSRC=${KV_DIR} KERNELVERSION=${KV_MAJOR}.${KV_MINOR}"
}

src_unpack() {
	local user_Makefile=fistdev.mk EXTRACFLAGS=""

	unpack ${A}
	cd ${S}

	if ! use debug; then
		echo "UNIONFS_DEBUG_CFLAG=" >> ${user_Makefile}
		EXTRACFLAGS="${EXTRACFLAGS} -DUNIONFS_NDEBUG"
	fi

	if use acl; then
		EXTRACFLAGS="${EXTRACFLAGS} -DUNIONFS_XATTR" # -DFIST_SETXATTR_CONSTVOID"
	elif use nfs; then
		EXTRACFLAGS="${EXTRACFLAGS} -DNFS_SECURITY_HOLE"
	fi

	echo "EXTRACFLAGS=${EXTRACFLAGS}" >> ${user_Makefile}
	einfo EXTRACFLAGS: ${EXTRACFLAGS}

	echo "UNIONFS_OPT_CFLAG=${CFLAGS}" >> ${user_Makefile}

}

src_install() {
	linux-mod_src_install

	dodoc INSTALL NEWS README ChangeLog patch-kernel.sh

	emake \
		PREFIX="${D}" \
		MANDIR="${D}/usr/share/man" \
		install-utils # Makefile is bugged
	#doman man/unionfs.4 man/unionctl.8 man/uniondbg.8 man/unionimap.8
	#into / # ${D}/sbin: usr could be unionfs mounted: bug #129960
	#dosbin utils/unionctl utils/uniondbg utils/unionimap
}

