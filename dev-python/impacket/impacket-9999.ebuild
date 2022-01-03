# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="A collection of Python classes focused on providing access to network packets"
HOMEPAGE="https://github.com/SecureAuthCorp/impacket"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/SecureAuthCorp/impacket"
elif [[ ${PV} == *"_p202"* ]]; then
	HASH_COMMIT="25c62f65a420e7ce3541c9099e32e91f6e9d3bd9"
	SRC_URI="https://github.com/SecureAuthCorp/impacket/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~arm64 x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
else
	SRC_URI="https://github.com/SecureAuthCorp/impacket/archive/impacket_${PV//./_}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~arm64 x86"
	S="${WORKDIR}/${PN}-${PN}_${PV//./_}"
fi

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/pyasn1-0.2.3[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.16.2[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/ldap3[${PYTHON_USEDEP}]
	>=dev-python/ldapdomaindump-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/flask-1.0[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

python_prepare_all() {
	# do not install data files under Gentoo
	sed -i -e "s|Darwin|Linux|" setup.py || die
	#use pycryptodome instead of pycryptodomex
	#the only thing different appears to be the namespace and gentoo is removing pycryptodomex
	sed -i -e 's#Cryptodome#Crypto#' $(grep -r --color=never 'Cryptodome' | awk -F':' '{print $1}') || die
	distutils-r1_python_prepare_all
}

python_test() {
	cd tests || die
	./runall.sh || die
}
