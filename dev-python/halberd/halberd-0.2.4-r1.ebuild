# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="threads"

inherit distutils-r1

DESCRIPTION="HTTP load balancer detector"
HOMEPAGE="https://github.com/jmbr/halberd"
SRC_URI="mirror://pypi/$(echo ${PN} | cut -c 1)/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=""
RDEPEND="${DEPEND}"

# patch to exit on failed tests
PATCHES=( "${FILESDIR}"/${PV}-man_location.patch )

# currently not passing
python_test() {
	distutils_install_for_testing
	esetup.py test || die "Tests failed with ${EPYTHON}"
}

python_install() {
	mydistutilsargs=( install --install-data="/usr/share")
	distutils-r1_python_install
}
