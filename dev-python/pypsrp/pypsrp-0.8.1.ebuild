# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="PowerShell Remoting Protocol and WinRM for Python"
HOMEPAGE="https://github.com/jborean93/pypsrp"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 amd64 ~x86"
IUSE="kerberos test +credssp"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyspnego[${PYTHON_USEDEP}]
	>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	credssp? ( dev-python/requests-credssp[${PYTHON_USEDEP}] )
	kerberos? ( dev-python/gssapi[${PYTHON_USEDEP}]
		dev-python/krb5[${PYTHON_USEDEP}]
	)"
DEPEND="${RDEPEND}"
