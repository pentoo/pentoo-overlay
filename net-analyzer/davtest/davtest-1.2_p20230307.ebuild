# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="tests WebDAV enabled servers"
HOMEPAGE="https://github.com/cldrn/davtest"
EGIT_COMMIT="34d31db7927b39480e984d595b82caaced6f5130"
SRC_URI="https://github.com/cldrn/davtest/archive/${EGIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/perl-Getopt-Long
	dev-perl/HTTP-DAV"

src_install() {
	insinto /usr/$(get_libdir)/${PN}/
	doins -r .
	dodoc README.txt

	dodir /usr/bin
	cat <<-EOF > "${ED}"/usr/bin/${PN}
		#!/bin/sh
		cd /usr/$(get_libdir)/${PN}
		exec ./${PN}.pl "\$@"
	EOF
	fperms +x /usr/bin/${PN} /usr/$(get_libdir)/${PN}/${PN}.pl

}
