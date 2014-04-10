# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI=5

MY_P=capstone-"${PV}"
PYTHON_COMPAT=( python2_7 )
inherit eutils multilib distutils-r1

DESCRIPTION="A lightweight multi-platform, multi-architecture disassembly framework"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="https://github.com/aquynh/capstone/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="cython"

RDEPEND="cython? ( dev-python/cython
	dev-util/capstone[python] )"
DEPEND=""

S=${WORKDIR}/${MY_P}/bindings/python

python_prepare() {
	epatch ${FILESDIR}/"${P}"-setup.patch

	#our hack to adjust cython setup
	if use cython; then
		cp setup_cython.py setup.py
		sed -e 's|install:|install_default:|' -i Makefile || die "sed failed"
		sed -e 's|install_cython:|install:|' -i Makefile || die "sed failed"
		#this section is from Makefile
		cp capstone/__init__.py pyx/__init__.py
		cp capstone/capstone.py pyx/capstone.pyx
		cp capstone/arm.py pyx/arm.pyx
		cp capstone/arm_const.py pyx/arm_const.pyx
		cp capstone/arm64.py pyx/arm64.pyx
		cp capstone/arm64_const.py pyx/arm64_const.pyx
		cp capstone/mips.py pyx/mips.pyx
		cp capstone/mips_const.py pyx/mips_const.pyx
		cp capstone/ppc.py pyx/ppc.pyx
		cp capstone/ppc_const.py pyx/ppc_const.pyx
		cp capstone/x86.py pyx/x86.pyx
		cp capstone/x86_const.py pyx/x86_const.pyx
	fi
}
