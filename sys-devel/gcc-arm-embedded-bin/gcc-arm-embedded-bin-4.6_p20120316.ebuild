# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Code Sourcery's CodeBench for ARM EABI"
HOMEPAGE="https://launchpad.net/gcc-arm-embedded/+download"
SRC_URI="https://launchpad.net/gcc-arm-embedded/4.6/4.6-2012-q1-update/+download/gcc-arm-none-eabi-4_6-2012q1-20120316.tar.bz2"

LICENSE="BSD GPL GPL-2 LGPL-2 LGPL-3 MIT NEWLIB ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86 -*"
IUSE=""
RESTRICT="strip binchecks"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"/gcc-arm-none-eabi-4_6-2012q1/

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

pkg_postinst() {
	env-update
}
