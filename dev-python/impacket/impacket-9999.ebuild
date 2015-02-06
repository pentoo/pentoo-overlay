# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN=Impacket
MY_P=${MY_PN}-${PV}

PYTHON_COMPAT=( python2_{6,7} )
inherit distutils-r1 subversion

DESCRIPTION="A collection of Python classes focused on providing access to network packets"
HOMEPAGE="http://code.google.com/p/impacket"
ESVN_REPO_URI="http://impacket.googlecode.com/svn/trunk/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
    nosetests || die "Tests fail with ${EPYTHON}"
}
