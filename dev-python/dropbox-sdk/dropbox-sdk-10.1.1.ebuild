# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
EGO_PN=github.com/dropbox/${PN}-python

inherit distutils-r1

DESCRIPTION="A Python SDK for integrating with the Dropbox API v2."
HOMEPAGE="https://github.com/dropbox/dropbox-sdk-python"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND=">=dev-python/requests-2.16.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.12.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-python-${PV}"

python_prepare_all() {
	sed -e '/setup_requires=setup_requires/d' -i setup.py
	sed -e '/tests_require=test_reqs/d' -i setup.py
	distutils-r1_python_prepare_all
}
