# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="PowerShell Remoting Protocol and WinRM for Python"
HOMEPAGE="https://github.com/jborean93/pypsrp"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
#dev-python/gssapi not keyworded
KEYWORDS="~amd64"
IUSE="kerberos test +credssp"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyspnego[${PYTHON_USEDEP}]
	>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	credssp? ( dev-python/requests-credssp[${PYTHON_USEDEP}] )
	kerberos? ( dev-python/gssapi[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
