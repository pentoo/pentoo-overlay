# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1

DESCRIPTION="Windows SSPI library in pure Python"
HOMEPAGE="https://github.com/skelsec/winsspi"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

RDEPEND=">=dev-python/minikerberos-0.2.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
