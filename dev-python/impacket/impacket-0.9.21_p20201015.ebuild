# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="A collection of Python classes focused on providing access to network packets"
HOMEPAGE="https://github.com/CoreSecurity/impacket"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/CoreSecurity/impacket"
else
	HASH_COMMIT="78e8c8e41b3f163f1271a01ce3f2bf3bb880f687"
	SRC_URI="https://github.com/CoreSecurity/impacket/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/pyasn1-0.2.3[${PYTHON_USEDEP}]
	dev-python/pycryptodomex[${PYTHON_USEDEP}]
	>dev-python/pyopenssl-0.13.1[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	>=dev-python/ldap3-2.5.1[${PYTHON_USEDEP}]
	>=dev-python/ldapdomaindump-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/flask-1.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_prepare_all() {
	# do not install data files under Gentoo
	sed -i -e "s|Darwin|Linux|" setup.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	cd tests || die
	./runall.sh || die
}
