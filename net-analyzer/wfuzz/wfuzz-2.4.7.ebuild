# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 multilib

DESCRIPTION="Wfuzz is a tool designed for bruteforcing Web Applications"
HOMEPAGE="http://www.edge-security.com/wfuzz.php https://github.com/xmendez/wfuzz"
SRC_URI="https://github.com/xmendez/wfuzz/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/pycurl-7.43.0.2[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.3.0[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/shodan[${PYTHON_USEDEP}]"

#S="${WORKDIR}/${PN}-v.${PV}"

python_prepare_all() {
	# FIXME: https://github.com/xmendez/wfuzz/issues/135
	sed -e "/data_files/d" \
		-i setup.py || die "sed failed"

	distutils-r1_python_prepare_all
}
