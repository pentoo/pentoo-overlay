# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils toolchain-funcs flag-o-matic

LZMA_VER=${PV}
MY_P="${P/-ucl}"

DESCRIPTION="Ultimate Packer for eXecutables (free version using UCL compression and not NRV)"
HOMEPAGE="http://upx.sourceforge.net/"
SRC_URI="https://github.com/upx/upx/archive/v${PV}.tar.gz -> ${P}.tar.gz
	 https://github.com/upx/upx-lzma-sdk/archive/v${LZMA_VER}.tar.gz -> upx-lzma-sdk-${LZMA_VER}.tar.gz"

LICENSE="GPL-2+ UPX-exception" # Read the exception before applying any patches
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="zlib"

RDEPEND=">=dev-libs/ucl-1.02
	!app-arch/upx
	!app-arch/upx-bin"
DEPEND="${RDEPEND}
	dev-lang/perl"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	#do not overwrite LZMA variables
	echo > src/stub/src/c/Makevars.lzma
	eapply_user
}

src_configure() {
	use zlib && append-cppflags -DWITH_ZLIB=1
}

src_compile() {
	tc-export CXX
	emake UPX_LZMADIR="${WORKDIR}/upx-lzma-sdk-${LZMA_VER}" UPX_LZMA_VERSION=${LZMA_VER} all
	emake all
}

src_install() {
	newbin src/upx.out upx
	dodoc BUGS NEWS PROJECTS README* THANKS doc/*.txt
	doman doc/upx.1
}
