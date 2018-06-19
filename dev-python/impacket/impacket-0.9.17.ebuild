# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="A collection of Python classes focused on providing access to network packets"
HOMEPAGE="https://github.com/CoreSecurity/impacket"
SRC_URI=""
if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/CoreSecurity/impacket.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/CoreSecurity/impacket/archive/impacket_${PV//./_}.tar.gz -> ${P}.tar.gz"
#	inherit versionator
#	S="${WORKDIR}"/${PN}-${PN}_$(replace_all_version_separators _)
	S="${WORKDIR}"/${PN}-${PN}_${PV//./_}
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND=">=dev-python/pyasn1-0.2.3[${PYTHON_USEDEP}]
	|| ( dev-python/pycryptodome[${PYTHON_USEDEP}] dev-python/pycrypto[${PYTHON_USEDEP}] )
	>=dev-python/pyopenssl-0.13.1[${PYTHON_USEDEP}]
	>=dev-python/ldap3-2.5.0[${PYTHON_USEDEP}]
	dev-python/ldapdomaindump[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_test() {
	pushd impacket/testcases/dot11
	for test in $(ls *.py); do
		${PYTHON} ${test} || die "Tests fail with ${EPYTHON}"
	done
	popd
	pushd impacket/testcases/ImpactPacket
	for test in $(ls *.py); do
		${PYTHON} ${test} || die "Tests fail with ${EPYTHON}"
	done
	popd
}
