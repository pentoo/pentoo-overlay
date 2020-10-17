# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#FIXME: Gentoo: add python3.8 to requests-credssp
PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="PowerShell Remoting Protocol and WinRM for Python"
HOMEPAGE="https://github.com/jborean93/pypsrp"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test +credssp"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	>=dev-python/ntlm-auth-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
		credssp? ( dev-python/requests-credssp[${PYTHON_USEDEP}] )
	"
DEPEND="${RDEPEND}"
