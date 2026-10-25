# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Protected Active Directory authentication for ldap3 using Impacket"
HOMEPAGE="https://pypi.org/project/ldap3-ad-auth/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/ldap3-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/impacket-0.13.1[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_prepare_all() {
	sed -i \
		-e 's#Cryptodome\.#Crypto.#g' \
		-e "s#'Cryptodome'#'Crypto'#g" \
		-e 's#"Cryptodome"#"Crypto"#g' \
		$(grep -rl --color=never 'Cryptodome' .) || die
	distutils-r1_python_prepare_all
}
