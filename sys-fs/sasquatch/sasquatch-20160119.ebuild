# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils toolchain-funcs

DESCRIPTION="The sasquatch project is a set of patches to the standard unsquashfs utility"
HOMEPAGE="https://github.com/devttys0/sasquatch"
SRC_URI="mirror://sourceforge/squashfs/squashfs4.3.tar.gz \
	https://raw.githubusercontent.com/devttys0/sasquatch/f6229d2cce3e07c2e96961086bc3e0c0522d7a65/patches/patch0.txt -> ${P}.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+xz lzma lz4 lzo xattr"

#build-essential liblzma-dev liblzo2-dev zlib1g-dev
RDEPEND="
	sys-libs/zlib
	!xz? ( !lzo? ( sys-libs/zlib ) )
	lz4? ( app-arch/lz4 )
	lzma? ( app-arch/xz-utils )
	lzo? ( dev-libs/lzo )
	xattr? ( sys-apps/attr )
	xz? ( app-arch/xz-utils )
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/squashfs4.3/squashfs-tools"

src_prepare() {
	epatch "${DISTDIR}/${P}.patch"
}

src_configure() {
	# set up make command line variables in EMAKE_SQUASHFS_CONF
	EMAKE_SQUASHFS_CONF=(
		$(usex lzma LZMA_XZ_SUPPORT=1 LZMA_XS_SUPPORT=0)
		$(usex lzo LZO_SUPPORT=1 LZO_SUPPORT=0)
		$(usex lz4 LZ4_SUPPORT=1 LZ4_SUPPORT=0)
		$(usex xattr XATTR_SUPPORT=1 XATTR_SUPPORT=0)
		$(usex xz XZ_SUPPORT=1 XZ_SUPPORT=0)
	)

	tc-export CC
}

src_compile() {
	emake ${EMAKE_SQUASHFS_CONF[@]}
}

src_install() {
	dobin sasquatch
#	dobin mksquashfs unsquashfs
#	dodoc ../README
}
