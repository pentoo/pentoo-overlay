# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} pypy3 )
inherit distutils-r1

DESCRIPTION="Simple bencode parser (for Python2, Python 3 and PyPy)"
HOMEPAGE="
	https://pypi.org/project/bencode_py/
	https://github.com/fuzeman/bencode.py
"
MY_PN="bencode.py"
MY_P="${MY_PN}-${PV}"

SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_P}"

LICENSE="BOSL-1.1"
SLOT="0"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	>=dev-python/pbr-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/setuptools-17.1.0[${PYTHON_USEDEP}]
"
DEPEND="${PYTHON_DEPS}"
RDEPEND="${PYTHON_DEPS}"

src_prepare() {
	# preliminary fixes for some of the issues reported in https://github.com/fuzeman/bencode.py/issues/21
	eapply "${FILESDIR}/${PN}"_setup_cfg.patch

	# There's still a setuptools QA issue here ("easy_install command is deprecated. Use build and pip and
	# other standards-based tools."). This has been reported to upstream - it should not affect this ebuild
	# at the moment.
	default
}

distutils_enable_tests pytest
