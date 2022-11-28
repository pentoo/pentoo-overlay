# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

MY_PN="frida"

DESCRIPTION="Dynamic instrumentation toolkit for reverse-engineers and security researchers"
HOMEPAGE="https://github.com/frida/frida"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="dev-libs/frida-core"
DEPEND="${PYTHON_DEPS}"

S="${WORKDIR}/${MY_PN}-${PV}"

python_compile() {
	export FRIDA_CORE_DEVKIT="/usr/lib64/"
	distutils-r1_python_compile
}
