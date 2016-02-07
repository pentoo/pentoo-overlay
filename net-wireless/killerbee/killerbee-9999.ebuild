# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 git-r3

DESCRIPTION="Framework and Tools for Attacking ZigBee and IEEE 802.15.4 networks"
HOMEPAGE="https://github.com/riverloopsec/killerbee"
EGIT_REPO_URI="https://github.com/riverloopsec/killerbee.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
#DEPEND="doc? ( dev-python/epydoc )

DEPEND="${RDEPEND}"
RDEPEND="dev-python/pyserial
	dev-python/pyusb
	dev-python/pycrypto
	dev-python/pygtk
	dev-python/pycairo"
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
