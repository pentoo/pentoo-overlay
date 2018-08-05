# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Portable solution for capturing wlan traffic and conversion to hashcat formats"
HOMEPAGE="https://github.com/ZerBea/hcxtools"
MY_COMMIT="5d14941d6b5134aea89d9cb43458e858b3c808a5"
SRC_URI="https://github.com/ZerBea/hcxtools/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/openssl:*
	sys-libs/zlib
	net-misc/curl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_prepare(){
	epatch "${FILESDIR}/makefile.patch"
	eapply_user
}

src_install(){
	emake ${GPIOSUPPORT} DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
