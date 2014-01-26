# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI=5

MY_P=capstone-"${PV}"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit eutils multilib distutils-r1

DESCRIPTION="A lightweight multi-platform, multi-architecture disassembly framework"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="https://github.com/aquynh/capstone/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
#IUSE="cython"

#RDEPEND="cython? ( dev-python/cython )"
#DEPEND=""

S=${WORKDIR}/${MY_P}/bindings/python

#src_prepare() {
#	#can we hack this way?
#	if use cython; then
#		cp setup_cython.py setup.py
#		sed -e 's|install:|install_default:|' -i Makefile || die "sed failed"
#		sed -e 's|install_cython:|install:|' -i Makefile || die "sed failed"
#		cp -r capstone/* pyx/
#	fi
#}
