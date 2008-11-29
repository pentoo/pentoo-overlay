# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

# versions as of 2008/04/07
SQUASH_PV="squashfs${PV}"
LZMA_PV="lzma457"
SQLZMA_PV="sqlzma${PV}-${LZMA_PV/#lzma}-2"

DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net http://www.squashfs-lzma.org"
SRC_URI="mirror://sourceforge/squashfs/${SQUASH_PV}.tar.gz
	lzma? (	mirror://sourceforge/sevenzip/${LZMA_PV}.tar.bz2
		http://www.squashfs-lzma.org/dl/${LZMA_PV}.tar.bz2
		http://www.squashfs-lzma.org/dl/${SQLZMA_PV}.tar.bz2
		http://www.squashfs-lzma.org/dl/squashfs-${PV}-cvsfix.tar.gz	)"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="lzma"

RDEPEND="sys-libs/zlib"


src_unpack() {
	cd ${WORKDIR}
	unpack ${SQUASH_PV}.tar.gz || die

	if use lzma ; then
		unpack ${SQLZMA_PV}.tar.bz2 || die
		mkdir ${LZMA_PV}
		cd ${LZMA_PV}
		unpack ${LZMA_PV}.tar.bz2 || die
		cd ..
		sed -i "s:lzma449:${LZMA_PV}:g" sqlzma1-449.patch
		epatch sqlzma1-449.patch || die
		epatch sqlzma2u-${PV}.patch || die

		# cvs fixes
		unpack squashfs-${PV}-cvsfix.tar.gz
		epatch code_cleanup.patch
		epatch mksquashfs_code_cleanups.patch
		epatch mksquashfs_bug_fixes.patch
		epatch mksquashfs_trace_fixes.patch
		epatch mksquashfs_unused_vars.patch
		epatch typo_mkflags_u.patch
		epatch unsquashfs_bugfixes.patch

		# adjust cflags
		sed -i "s:-O2:${CFLAGS}:" ${LZMA_PV}/C/Compress/Lzma/sqlzma.mk || die
		sed -i "s:-O2:${CFLAGS}:" ${LZMA_PV}/CPP/7zip/Compress/LZMA_Alone/makefile.gcc || die
		
		# adjust Makefile
		sed -i "s:KDir =:# KDir =:" Makefile || die # kernel dir unneeded
		sed -i "s:BuildSquashfs =:# BuildSquashfs =:" Makefile || die	# dont build modules
		sed -i "s:^LzmaVer =.*:LzmaVer = ${LZMA_PV}:" Makefile || die	# correct lzma version
	fi

	# adjust cflags
	sed -i "s:-O2:${CFLAGS}:" ${SQUASH_PV}/squashfs-tools/Makefile || die
} 

src_compile() {
	if ! use lzma ; then
		cd ${WORKDIR}/${SQUASH_PV}/squashfs-tools
	else
		cd ${WORKDIR}
	fi

        emake CC="$(tc-getCC)" || die
}

src_install() {
	cd ${SQUASH_PV}/squashfs-tools
	dobin mksquashfs unsquashfs || die
	cd ..
	dodoc README ACKNOWLEDGEMENTS CHANGES COPYING PERFORMANCE.README README-3.3
	cd ..
	use lzma && dodoc sqlzma.txt
}

pkg_postinst() {
	elog "This version of mksquashfs requires a 2.6.24 kernel or better."
}
