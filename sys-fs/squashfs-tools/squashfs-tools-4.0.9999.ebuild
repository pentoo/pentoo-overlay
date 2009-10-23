# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/squashfs-tools/squashfs-tools-4.0.ebuild,v 1.7 2009/07/18 20:18:30 josejx Exp $

inherit toolchain-funcs cvs

LZMA_PV=lzma465

DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/sevenzip/${LZMA_PV}.tar.bz2"
LICENSE="GPL-2"

ECVS_SERVER="squashfs.cvs.sourceforge.net:/cvsroot/squashfs"
ECVS_MODULE="squashfs/squashfs-tools"
ECVS_LOCALNAME="squashfs-tools"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""
RDEPEND="sys-libs/zlib"

S="${WORKDIR}"

src_unpack() {
	mkdir "${S}"
	cd "${S}"
	cvs_src_unpack
	cd "${S}"
	mkdir ${LZMA_PV}
	cd ${LZMA_PV}
	unpack ${LZMA_PV}.tar.bz2 || die
}

src_compile() {
	cd "${S}/squashfs-tools"
	sed -e 's:^LZMA_DIR =.*:LZMA_DIR = ../'${LZMA_PV}':' -i Makefile
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	cd "${S}/squashfs-tools"
	dobin mksquashfs unsquashfs || die
}

pkg_postinst() {
	ewarn "This version of mksquashfs requires a 2.6.29 kernel or better."
}
