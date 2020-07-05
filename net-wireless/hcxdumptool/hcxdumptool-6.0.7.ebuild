# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Small tool to capture packets from wlan devices"
HOMEPAGE="https://github.com/ZerBea/hcxdumptool"
SRC_URI="https://github.com/ZerBea/hcxdumptool/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="gpio"

DEPEND="dev-libs/openssl:="
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e "s/^install: build/install:/" \
		-i Makefile || die

	default
}

src_compile() {
	emake $(usex gpio \
		"GPIOSUPPORT=on" \
		"GPIOSUPPORT=off")
}

src_install(){
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
