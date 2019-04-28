# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/riverloopsec/killerbee.git"
else
	# snapshot: 20190218
	COMMIT_HASH="cdee75784e0d44f225c6d1bc07fdae6044e73bb7"

	SRC_URI="https://github.com/riverloopsec/killerbee/archive/${COMMIT_HASH}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${COMMIT_HASH}"
fi

DESCRIPTION="Framework and Tools for Attacking ZigBee and IEEE 802.15.4 networks"
HOMEPAGE="https://github.com/riverloopsec/killerbee"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

#FIXME: https://bitbucket.org/secdev/scapy-com
DEPEND=""
RDEPEND="dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/pygtk[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/rangeparser[${PYTHON_USEDEP}]
	dev-libs/libgcrypt:=
	>=net-analyzer/scapy-2.4.0_p20180626"

python_install_all() {
	distutils-r1_python_install_all
	if use doc; then
		mv doc html && dodoc -r html || die
	fi
}
