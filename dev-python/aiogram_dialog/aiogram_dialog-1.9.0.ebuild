# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#https://projects.gentoo.org/python/guide/distutils.html#pep-517-build-systems
#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="GUI framework on top of aiogram"
HOMEPAGE="https://github.com/Tishka17/aiogram_dialog"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/Tishka17/aiogram_dialog/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="proxy fast"

RDEPEND="
	>=dev-python/aiogram-2.20[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	>=dev-python/cachetools-4.0[${PYTHON_USEDEP}]
	dev-python/magic-filter[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest

src_prepare(){
	sed -i -e 's|cachetools==4\.\*|cachetools|g' setup.py || die
	eapply_user
}
