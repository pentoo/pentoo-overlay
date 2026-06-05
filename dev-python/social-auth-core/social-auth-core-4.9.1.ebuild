# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python social authentication made simple"
HOMEPAGE="https://github.com/python-social-auth/social-core"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="saml test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/cryptography-46.0.7[${PYTHON_USEDEP}]
	>=dev-python/defusedxml-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/google-auth-2.40.0[${PYTHON_USEDEP}]
	>=dev-python/oauthlib-3.3.1[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-2.12.1[${PYTHON_USEDEP}]
	>=dev-python/python3-openid-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.33.1[${PYTHON_USEDEP}]
	>=dev-python/requests-oauthlib-2.0.0[${PYTHON_USEDEP}]
	<dev-python/google-auth-2.50.0[${PYTHON_USEDEP}]
	saml? ( >=dev-python/python3-saml-1.16.0 )
"

BDEPEND="
	test? (
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
EPYTEST_IGNORE=(
	social_core/tests/backends/test_steam.py
)
distutils_enable_tests pytest

python_test() {
	sed -i -e '166,167d' pyproject.toml
	epytest
}
