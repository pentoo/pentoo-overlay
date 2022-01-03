# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="Parser for Android XML file and get Application Name without using Androguard"
HOMEPAGE="https://github.com/appknox/pyaxmlparser"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="amd64 ~arm64 x86"
SLOT="0"
IUSE=""

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]
	>=dev-python/click-6.7[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i 's#man/man1#share/man/man1#' setup.py
	default
}
