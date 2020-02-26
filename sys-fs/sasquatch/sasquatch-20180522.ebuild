# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
SQSHFS_P="squashfs4.3"

inherit eutils flag-o-matic git-r3 toolchain-funcs

DESCRIPTION="The sasquatch project is a set of patches to the standard unsquashfs utility"
HOMEPAGE="https://github.com/devttys0/sasquatch http://squashfs.sourceforge.net"
SRC_URI="mirror://sourceforge/squashfs/${SQSHFS_P}.tar.gz -> ${P}.${SQSHFS_P}.tar.gz"

EGIT_REPO_URI="https://github.com/devttys0/sasquatch"
if [[ "${PV}" != *9999 ]]; then
	EGIT_COMMIT="3e0cc40fc6dbe32bd3a5e6c553b3320d5d91ceed"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"
IUSE="debug lz4 lzo static xattr +xz"

LIB_DEPEND="
	sys-libs/zlib[static-libs(+)]
	!xz? ( !lzo? ( sys-libs/zlib[static-libs(+)] ) )
	lz4? ( app-arch/lz4[static-libs(+)] )
	lzo? ( dev-libs/lzo[static-libs(+)] )
	xattr? ( sys-apps/attr[static-libs(+)] )
	xz? ( app-arch/xz-utils[static-libs(+)] )"

RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )"

S="${WORKDIR}/${SQSHFS_P}/squashfs-tools"

src_unpack() {
	git-r3_src_unpack
	unpack ${A}
}

src_prepare() {
	# Apply debian patches and using upstream...
	# eapply -p2 "${FILESDIR}"/*.patch
	eapply "${WORKDIR}/${P}"/patches/patch0.txt

	# Enable target toolchain/params for child "make" process
	sed -e "s/make -C \$(/make CC=$(tc-getCXX) ${MAKEOPTS} -C \$(/" \
		-e "s/-Wall -Werror/-Wall/" \
		-i Makefile || die 'sed failed!'

	eapply_user
}

src_compile() {
	append-cflags -std=gnu89
	use debug && append-cppflags -DSQUASHFS_TRACE
	use static && append-ldflags -static

	tc-export CC
	emake \
		LZMA_SUPPORT=1 \
		$(usex lzo LZO_SUPPORT=1 LZO_SUPPORT=0) \
		$(usex lz4 LZ4_SUPPORT=1 LZ4_SUPPORT=0) \
		$(usex xattr XATTR_SUPPORT=1 XATTR_SUPPORT=0) \
		$(usex xz XZ_SUPPORT=1 XZ_SUPPORT=0)
} 

src_install() {
	dobin sasquatch
	dodoc \
		../CHANGES \
		../ACKNOWLEDGEMENTS \
		../PERFORMANCE.README \
		"${WORKDIR}/${P}"/README.md
}
