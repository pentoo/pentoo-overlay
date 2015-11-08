# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 multilib

DESCRIPTION="Wfuzz is a tool designed for bruteforcing Web Applications"
HOMEPAGE="http://www.edge-security.com/wfuzz.php"
SRC_URI="http://wfuzz.googlecode.com/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pycurl"

S="${WORKDIR}"/wfuzz-read-only

src_install() {

	dodoc README
	rm COPYING README LICENSES

	dodir /usr/$(get_libdir)/
	# should be as simple as copying everything into the target...
	cp -pPR "${S}" "${ED}"/usr/$(get_libdir)/${PN} || die
	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}
	fowners -R root:0 *

	dodir /usr/bin/

	cat <<-EOF > "${ED}"/usr/bin/${PN}
		#!/bin/sh
		cd /usr/$(get_libdir)/${PN}
		exec ./${PN}.py "\$@"
	EOF

	fperms +x /usr/bin/${PN}
	fperms +x /usr/$(get_libdir)/${PN}/${PN}.py
}
