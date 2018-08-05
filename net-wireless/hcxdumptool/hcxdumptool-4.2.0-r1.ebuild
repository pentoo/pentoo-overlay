# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Small tool to capture packets from wlan devices"
HOMEPAGE="https://github.com/ZerBea/hcxdumptool"
MY_COMMIT="ebfcdf0243604d36dfac2757d4373bd9331b8a9a"
SRC_URI="https://github.com/ZerBea/hcxdumptool/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="gpio"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_prepare(){
	epatch "${FILESDIR}/makefile.patch"
	eapply_user
}

src_configure(){
	local GPIOSUPPORT
	if use gpio; then
		GPIOSUPPORT="GPIOSUPPORT=on"
	fi
	emake ${GPIOSUPPORT}
}

src_install(){
	emake ${GPIOSUPPORT} DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
