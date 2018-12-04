# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Library to instrument executable formats"
HOMEPAGE="https://lief.quarkslab.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip
	https://github.com/lief-project/LIEF/releases/download/0.9.0/lief-0.9.0-py2.7-linux.egg
	https://github.com/lief-project/LIEF/releases/download/0.9.0/lief-0.9.0-py3.6-linux.egg"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

QA_FLAGS_IGNORED="usr/lib.*/python.*/site-packages/_pylief.*\.so"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_install() {
	distutils-r1_src_install
	dobin ${FILESDIR}/lief_inject.py
}
