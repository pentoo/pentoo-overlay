# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Code Sourcery's CodeBench for ARM EABI"
HOMEPAGE=""
SRC_URI="http://www.codesourcery.com/sgpp/lite/arm/portal/package8734/public/arm-none-eabi/arm-2011.03-42-arm-none-eabi-i686-pc-linux-gnu.tar.bz2"

LICENSE="nfc"
SLOT="0"
KEYWORDS="~amd64 ~x86 -*"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"/arm-2011.03/

src_install() {
	dodir /opt/${PN}
	#insinto /opt/${PN}
	#doins -r *
	\cp -r "${S}"/* "${ED}"/opt/${PN}
	fowners -R root:0 /opt/${PN}

	local DEST=/opt/${PN}
	cat > "${T}/env" << EOF
PATH=${DEST}/bin
ROOTPATH=${DEST}/bin
LDPATH=${DEST}/lib
MANPATH=${DEST}/share/doc/arm-arm-none-eabi/man
EOF
	newenvd "${T}/env" 99sourcery-arm-gcc-bin
}

pkg_postinst() {
	env-update
}
