# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

#FIXME: migrate to new python eclass
#PYTHON_DEPEND="3"
#inherit python

DESCRIPTION="An automatic SQL Injection exploitation tool"
HOMEPAGE="http://themole.nasel.com.ar/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}-lin-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/readline
	dev-python/lxml"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 3
	python_pkg_setup
}

src_install() {
	dodir /usr/lib/${PN}
	insinto /usr/lib/${PN}
	doins -r *
	chmod +x "${D}/usr/lib/${PN}/mole.py"
	dosym "/usr/lib/${PN}/mole.py" "/usr/bin/${PN}"
	dodoc README changelog
}
