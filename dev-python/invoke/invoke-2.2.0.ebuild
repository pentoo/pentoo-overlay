# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Pythonic task execution"
HOMEPAGE="https://pypi.org/project/invoke/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

#FIXME: replace invoke/vendor/{ fluidity lexicon  yaml } with external packages
RDEPEND=""
DEPEND="${RDEPEND}"

# Depends on broken pytest-relaxed plugin
RESTRICT="test"

#src_prepare(){
#	rm -r ./invoke/vendor/yaml2
#	eapply_user
#}
