# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="HTML Entities for Python"
HOMEPAGE="https://github.com/cobrateam/python-htmlentities"
SRC_URI="https://github.com/cobrateam/python-htmlentities/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/python-${P}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
"

src_prepare() {
	sed -i -e "s/find_packages(/find_packages(exclude=['tests']/" setup.py
	eapply_user
}

distutils_enable_tests unittest
