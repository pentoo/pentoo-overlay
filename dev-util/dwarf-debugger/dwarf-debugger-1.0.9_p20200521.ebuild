# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

MY_PN="dwarf_debugger"
HASH_COMMIT="58dde266edff2e059bb54c3467ffd0eca1fa43a4"

DESCRIPTION="Full featured multi arch/os debugger built on top of PyQt5 and frida"
HOMEPAGE="https://github.com/iGio90/Dwarf"
#SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"
SRC_URI="https://github.com/iGio90/Dwarf/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${PYTHON_DEPS}
	>=dev-libs/capstone-4.0.1[python,${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/frida-python-12.8.0[${PYTHON_USEDEP}]
	>=dev-python/PyQt5-5.11.3[${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.7.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=""${FILESDIR}"/dwart-disable-update2.patch"

S="${WORKDIR}/Dwarf-${HASH_COMMIT}"
