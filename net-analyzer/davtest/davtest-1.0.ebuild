# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 multilib

DESCRIPTION="tests WebDAV enabled servers"
HOMEPAGE="https://github.com/cldrn/davtest"
EGIT_REPO_URI="https://github.com/cldrn/davtest.git"
EGIT_COMMIT="f8e53a6e27fefec728b7b4fce8c95946298d64a8"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
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
