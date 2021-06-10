# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/riverloopsec/killerbee.git"
else
	# py3 branch
	COMMIT_HASH="560d97687e0aca7a1192351652d730a1e7148c25"

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
DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-libs/libgcrypt:=
	$(python_gen_cond_dep '
		>=net-analyzer/scapy-2.4.0_p20180626[${PYTHON_MULTI_USEDEP}]
		dev-python/pyserial[${PYTHON_MULTI_USEDEP}]
		dev-python/pyusb[${PYTHON_MULTI_USEDEP}]
		dev-python/pycryptodome[${PYTHON_MULTI_USEDEP}]
		dev-python/rangeparser[${PYTHON_MULTI_USEDEP}]
	')"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

python_install_all() {
	distutils-r1_python_install_all
	if use doc; then
		mv doc html && dodoc -r html || die
	fi
}
