# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Python library for interacting with Censys Search Engine (censys.io)"
HOMEPAGE="https://censys-python.readthedocs.io/"
SRC_URI="https://github.com/censys/censys-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-python-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="examples test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/requests-2.29.0[${PYTHON_USEDEP}]
	<dev-python/urllib3-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/backoff-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/rich-10.16.2[${PYTHON_USEDEP}]
	>=dev-python/argcomplete-2.0.0[${PYTHON_USEDEP}]
	<dev-python/argcomplete-4.0.0[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/parameterized[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs dev-python/sphinx-rtd-theme \
	dev-python/sphinx-prompt \
	dev-python/sphinx-tabs \
	dev-python/sphinx-copybutton \
	dev-python/sphinxcontrib-autoprogram

distutils_enable_tests pytest

src_prepare() {
	if use test; then
		sed -i 's/--cov //' pytest.ini
	fi

	if use doc; then
		sed -i 's/-prompt/_prompt/' docs/conf.py
	fi

	eapply_user
}

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	distutils-r1_python_install_all
}
