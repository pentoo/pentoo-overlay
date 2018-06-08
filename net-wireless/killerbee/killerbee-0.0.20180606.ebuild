# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Framework and Tools for Attacking ZigBee and IEEE 802.15.4 networks"
HOMEPAGE="https://github.com/riverloopsec/killerbee"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
COMMIT_HASH="57de78a13043dfb6deb4f479f962e2c008aa753d"
SRC_URI="https://github.com/riverloopsec/killerbee/archive/${COMMIT_HASH}.tar.gz -> ${P}.tar.gz"

RDEPEND="dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/pygtk[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-libs/libgcrypt:="
#DEPEND="doc? ( dev-python/epydoc )
DEPEND="${RDEPEND}"
#FIXME: https://bitbucket.org/secdev/scapy-com

#FIXME: doc fails to comiple
#python_compile_all() {
#	ewarn "running compile_all"
#	distutils-r1_python_compile
#	if use doc; then
#		mkdir pdf
#		epydoc --pdf -o pdf killerbee/
#	fi
#}

#python_install_all() {
#	distutils-r1_src_install
#	if use doc; then
#		 dodoc "${S}/pdf/*.tex"
#	fi
#}
