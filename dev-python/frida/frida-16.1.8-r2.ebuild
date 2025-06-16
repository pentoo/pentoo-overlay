# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

#MY_PN="frida"

DESCRIPTION="Dynamic instrumentation toolkit for reverse-engineers and security researchers"
HOMEPAGE="https://github.com/frida/frida"

LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="~dev-libs/frida-core-${PV}
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	!dev-python/frida-bin"
DEPEND="${PYTHON_DEPS}"

# The QA_WX error is due to frida-core pre-build lib
QA_PREBUILT="usr/lib/python*/site-packages/_frida.abi3.so"

#S="${WORKDIR}/${MY_PN}-${PV}"

python_compile() {
	export FRIDA_CORE_DEVKIT="/usr/lib64/"
	distutils-r1_python_compile
}
