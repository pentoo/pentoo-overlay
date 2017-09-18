# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A wifi-protected-setup (WPS) brute force attack tool, similar to reaver"
HOMEPAGE="https://github.com/aanarchyy/bully/releases"
EGIT_REPO_URI="https://github.com/aanarchyy/bully.git"
EGIT_COMMIT="04185d7b1d1a7909f47f23fbd85691401c7fabd7"

SLOT="0"
LICENSE="GPL-3+ GPL-2 BSD"
KEYWORDS="amd64 arm x86"

DEPEND="net-libs/libpcap"

src_compile() {
	cd "${S}/src"
	emake
}

src_install() {
	cd "${S}/src"
	emake DESTDIR="${D}" prefix=/usr install
	dodoc "${S}/README.md"
}
