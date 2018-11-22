# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} pypy pypy3 )

inherit distutils-r1

MY_PN="GeoIP2-python"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python bindings for GeoIP2"
HOMEPAGE="https://github.com/maxmind/GeoIP2-python"
SRC_URI="https://github.com/maxmind/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-python/maxminddb-1.2.1[${PYTHON_USEDEP}]
		>=dev-python/requests-2.9[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

python_install_all() {
	distutils-r1_python_install_all
}
