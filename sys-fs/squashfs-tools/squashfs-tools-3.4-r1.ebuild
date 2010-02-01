# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils toolchain-funcs

# versions as of 2009/01/06
SQUASH_PV="squashfs${PV}"
LZMA_PV="lzma457"
SQLZMA_PV="sqlzma${PV}-${LZMA_PV/#lzma}"

DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net http://www.squashfs-lzma.org"
SRC_URI="mirror://sourceforge/squashfs/${SQUASH_PV}.tar.gz
	lzma? (	mirror://sourceforge/sevenzip/${LZMA_PV}.tar.bz2
		ftp://ftp.slax.org/source/slax/sqlzma/${SQLZMA_PV}.tar.bz2 )"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE="+lzma"
RDEPEND="sys-libs/zlib"

src_unpack() {
	cd "${WORKDIR}"
	unpack ${SQUASH_PV}.tar.gz || die

	if use lzma ; then
		unpack ${SQLZMA_PV}.tar.bz2 || die
		mkdir ${LZMA_PV}
		cd ${LZMA_PV}
		unpack ${LZMA_PV}.tar.bz2 || die
		cd ..
		epatch sqlzma1-457.patch || die
		epatch sqlzma2u-${PV}.patch || die

		# adjust cflags
		sed -i "s:-O2:${CFLAGS}:" ${LZMA_PV}/C/Compress/Lzma/sqlzma.mk || die
		sed -i "s:-O2:${CFLAGS}:" ${LZMA_PV}/CPP/7zip/Compress/LZMA_Alone/makefile.gcc || die

		# adjust Makefile
		sed -i "s:KDir =:# KDir =:" Makefile || die # kernel dir unneeded
		sed -i "s:BuildSquashfs =:# BuildSquashfs =:" Makefile || die	# dont build modules
	fi

	# adjust cflags
	sed -i "s:-O2:${CFLAGS}:" ${SQUASH_PV}/squashfs-tools/Makefile || die
}

src_compile() {
	if ! use lzma ; then
		cd "${WORKDIR}"/${SQUASH_PV}/squashfs-tools
	else
		cd "${WORKDIR}"
	fi

	emake CC="$(tc-getCC)" || die
}

src_install() {
	cd ${SQUASH_PV}/squashfs-tools
	dobin mksquashfs unsquashfs || die
	cd ..
	dodoc README ACKNOWLEDGEMENTS CHANGES PERFORMANCE.README README-3.3
	cd ..
	use lzma && dodoc sqlzma.txt
}

pkg_postinst() {
	elog "This version of mksquashfs requires a 2.6.27 kernel or better."
}
