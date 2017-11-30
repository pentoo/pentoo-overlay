# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PV="${PV//_/-}"
MY_P=capstone-"${MY_PV}"

PYTHON_COMPAT=( python{2_7,3_4,3_5} )
inherit eutils multilib distutils-r1

DESCRIPTION="A lightweight multi-platform, multi-architecture disassembly framework"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="https://github.com/aquynh/capstone/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="cython"

RDEPEND="cython? ( dev-python/cython
	dev-libs/capstone[python] )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/${MY_P}/bindings/python

python_prepare() {
	#our hack to adjust cython setup
	if use cython; then
		einfo "cython flag is enabled"
		cp setup_cython.py setup.py
		sed -e "s|'xcore_const']|'xcore_const', 'tms320c64x', 'tms320c64x_const']|" -i setup.py || die "sed failed"
#		sed -e 's|install:|install_default:|' -i Makefile || die "sed failed"
#		sed -e 's|install_cython:|install:|' -i Makefile || die "sed failed"
		#this section is from Makefile
		cp capstone/__init__.py pyx/__init__.py
		for i in arm{,_const} arm64{,_const} mips{,_const} ppc{,_const} x86{,_const} sparc{,_const} systemz sysz_const xcore{,_const} tms320c64x{,_const}; do
			cp capstone/${i}.py pyx/${i}.pyx
		done
	fi
}
