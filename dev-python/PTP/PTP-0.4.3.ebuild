# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Pentester's Tools Parser"
HOMEPAGE="http://owtf.github.io/ptp/"
SRC_URI="https://github.com/owtf/ptp/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/ptp-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

RDEPEND="
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/Js2Py[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
"
# can't test because Js2Py bug. must uncomment when this issue is closed
# https://github.com/PiotrDabkowski/Js2Py/issues/334
	#test? (
	#	dev-python/mock[${PYTHON_USEDEP}]
	#	dev-python/pyhamcrest[${PYTHON_USEDEP}]
	#)

distutils_enable_sphinx 'docs/source'
#distutils_enable_tests unittest

src_prepare() {
	rm -r tests/
	eapply_user
}
