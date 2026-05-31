# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="PowerShell Remoting Protocol and WinRM for Python"
HOMEPAGE="https://github.com/jborean93/pypsrp"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="kerberos test +credssp"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyspnego[${PYTHON_USEDEP}]
	>=dev-python/requests-2.27.0[${PYTHON_USEDEP}]
	credssp? ( >=dev-python/requests-credssp-2.0.0[${PYTHON_USEDEP}] )
	kerberos? (
		dev-python/gssapi[${PYTHON_USEDEP}]
		dev-python/krb5[${PYTHON_USEDEP}]
	)
"

BDEPEND="
	${RDEPEND}
	test? (
		app-text/xmldiff
		dev-python/pyyaml
	)
"

EPYTEST_PLUGINS=( pytest-mock )
distutils_enable_tests pytest
