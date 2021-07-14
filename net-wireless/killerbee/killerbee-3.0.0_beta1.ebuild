# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

MY_PV="$(ver_cut 1-3)-$(ver_cut 4).$(ver_cut 5)"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/riverloopsec/killerbee.git"
else
	SRC_URI="https://github.com/riverloopsec/killerbee/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${MY_PV}"
fi

DESCRIPTION="Framework and Tools for Attacking ZigBee and IEEE 802.15.4 networks"
HOMEPAGE="https://github.com/riverloopsec/killerbee"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"
RESTRICT="test"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-libs/libgcrypt:=
	>=dev-python/pyserial-2.0[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/rangeparser[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}]
	"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

python_install_all() {
	distutils-r1_python_install_all
	if use doc; then
		mv doc html && dodoc -r html || die
	fi
}
