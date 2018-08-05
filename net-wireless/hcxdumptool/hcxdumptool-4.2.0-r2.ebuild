# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Small tool to capture packets from wlan devices"
HOMEPAGE="https://github.com/ZerBea/hcxdumptool"
MY_COMMIT="f27b030c15bafc0789bc405b9061b7f8009fa8da"
SRC_URI="https://github.com/ZerBea/hcxdumptool/archive/${MY_COMMIT}.zip -> ${PN}-${MY_COMMIT}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="gpio"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

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
