# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${PN}-8-2018-q4-major"
MY_PV="8-2018q4"

DESCRIPTION="GNU Arm Embedded Toolchain"
HOMEPAGE="https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"

#amd64 available only
#SRC_URI="amd64? ( https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 )
SRC_URI="amd64? ( https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/${MY_PV}/${MY_P}-linux.tar.bz2 )
"

LICENSE="BSD GPL-2 LGPL-2 LGPL-3 MIT NEWLIB ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="strip"
QA_PREBUILT="*"

DEPEND=""
RDEPEND="sys-libs/ncurses:5
		dev-lang/python:2.7"

S="${WORKDIR}/${MY_P}"

src_install() {
	dodir /opt/${PN}
	\cp -r "${S}"/* "${ED}"/opt/${PN}
	fowners -R root:0 /opt/${PN}

	local DEST=/opt/${PN}
	cat > "${T}/env" << EOF
PATH=${DEST}/bin
ROOTPATH=${DEST}/bin
LDPATH=${DEST}/lib
MANPATH=${DEST}/share/doc/arm-arm-none-eabi/man
EOF
	newenvd "${T}/env" 99gcc-arm-embedded-bin
}
