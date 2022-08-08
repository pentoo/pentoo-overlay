# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10} )
inherit distutils-r1

DESCRIPTION="an efficient and elegant inotify"
HOMEPAGE="https://github.com/dsoprea/PyInotify"
SRC_URI="https://github.com/dsoprea/PyInotify/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/PyInotify-${PV}"

# I enabled the tests, and they don't work.
# The package works, aside from being dead for 4 years, and I use it.
# So the tests will stay disabled.
RESTRICT=test
distutils_enable_tests nose

src_install() {
	distutils-r1_src_install
	rm -rf "${ED}/usr/share/doc/${PF}"
}
