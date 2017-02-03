# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="sslstrip remove https and forwards http"
HOMEPAGE="http://www.thoughtcrime.org/software/sslstrip/"
SRC_URI="http://www.thoughtcrime.org/software/sslstrip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
		 >=dev-python/twisted-web-8.1.0[${PYTHON_USEDEP}]"

src_install() {
	dodir /usr/lib/"${PN}"
	insinto /usr/lib/"${PN}"
	doins sslstrip.py lock.ico
	dodir /usr/lib/${PN}/sslstrip
	insinto /usr/lib/${PN}/sslstrip
	doins sslstrip/*.py
	newsbin "${FILESDIR}"/sslstrip-r1 sslstrip
	dodoc README
}
