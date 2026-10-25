# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Unified interface for cryptographic libraries"
HOMEPAGE="https://github.com/skelsec/unicrypto"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/pycryptodome[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/python-mbedtls[${PYTHON_USEDEP}]
	)
"

python_prepare_all() {
	sed -i \
		-e 's#Cryptodome\.#Crypto.#g' \
		-e "s#'Cryptodome'#'Crypto'#g" \
		-e 's#"Cryptodome"#"Crypto"#g' \
		$(grep -rl --color=never 'Cryptodome' .) || die
	distutils-r1_python_prepare_all
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
