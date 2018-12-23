# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Small tool to capture packets from wlan devices"
HOMEPAGE="https://github.com/ZerBea/hcxdumptool"
SRC_URI="https://github.com/ZerBea/hcxdumptool/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="gpio"

DEPEND=""
RDEPEND="${DEPEND}"

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
