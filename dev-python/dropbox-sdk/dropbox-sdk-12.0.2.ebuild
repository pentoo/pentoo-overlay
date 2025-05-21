# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A Python SDK for integrating with the Dropbox API v2."
HOMEPAGE="https://github.com/dropbox/dropbox-sdk-python"
SRC_URI="https://github.com/dropbox/${PN}-python/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="
	>=dev-python/requests-2.16.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.12.0[${PYTHON_USEDEP}]
	>=dev-python/stone-2.0.0[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-python-${PV}"

distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

python_prepare_all() {
	# deprecated
	sed -e '/setup_requires=setup_requires/d' -i setup.py
	sed -e '/tests_require=test_reqs/d' -i setup.py
	distutils-r1_python_prepare_all
}
