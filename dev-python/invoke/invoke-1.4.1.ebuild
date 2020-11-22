# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7,8} )
inherit distutils-r1

DESCRIPTION="Pythonic task execution"
HOMEPAGE="https://pypi.org/project/invoke/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

# Depends on broken pytest-relaxed plugin
RESTRICT="test"

src_prepare(){
	rm -r ./invoke/vendor/yaml2
	eapply_user
}
