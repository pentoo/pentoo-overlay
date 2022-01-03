# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Windows Negotiate Authentication Client and Server"
HOMEPAGE="https://github.com/jborean93/pyspnego"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="kerberos test yaml"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	kerberos? ( dev-python/gssapi[${PYTHON_USEDEP}] )
	yaml? ( dev-python/ruamel-yaml[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
