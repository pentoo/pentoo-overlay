# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

SQUASH_PV="squashfs3.3"
LZMA_PV="lzma449"

DESCRIPTION="Tool for creating compressed filesystem type squashfs with LZMA"
HOMEPAGE="http://www.squashfs-lzma.org/"
SRC_URI="mirror://sourceforge/squashfs/${SQUASH_PV}.tgz
mirror://sourceforge/sevenzip/${LZMA_PV}.tar.bz2
http://www.squashfs-lzma.org/dl/sqlzma3.3-fixed.tar.bz2"
# http://www.squashfs-lzma.org/dl/${SQUASH_PV}.tar.gz
# http://www.squashfs-lzma.org/dl/${LZMA_PV}.tar.bz2

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="sys-libs/zlib"

src_unpack() {
	cd ${WORKDIR}
	unpack ${SQUASH_PV}.tgz sqlzma3.3-fixed.tar.bz2
	mkdir ${LZMA_PV}
	cd ${LZMA_PV}
	unpack ${LZMA_PV}.tar.bz2
	cd ..
	epatch sqlzma1-449.patch
	epatch sqlzma2u-3.3.patch
	sed -i "s:-O2:${CFLAGS}:" ${SQUASH_PV}/squashfs-tools/Makefile
	sed -i "s:-O2:${CFLAGS}:" ${LZMA_PV}/C/Compress/Lzma/sqlzma.mk
	sed -i "s:-O2:${CFLAGS}:" ${LZMA_PV}/CPP/7zip/Compress/LZMA_Alone/makefile.gcc
	sed -i -e "s:KDir =:# KDir =:" -e "s:BuildSquashfs =:# BuildSquashfs =:" Makefile
	find ${SQUASH_PV} -type f | xargs -L 1 sed -i "s:exort:export:"
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	cd ${SQUASH_PV}/squashfs-tools
	dobin mksquashfs unsquashfs || die
	cd ..
	dodoc README ACKNOWLEDGEMENTS CHANGES COPYING PERFORMANCE.README README-3.3
	cd ..
	dodoc sqlzma.txt
}
