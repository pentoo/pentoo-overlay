# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PV=${PV/_p/-}

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="sslstrip remove https and forwards http"
HOMEPAGE="http://www.thoughtcrime.org/software/sslstrip/"
SRC_URI="https://github.com/moxie0/sslstrip/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	|| ( >=dev-python/twisted-16.0.0[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/twisted-web[${PYTHON_USEDEP}]' 'python2_7')
	)"

S="${WORKDIR}/${PN}-${MY_PV}"

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
