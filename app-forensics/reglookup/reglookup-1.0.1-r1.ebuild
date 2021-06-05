# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{7..9} )

inherit scons-utils distutils-r1

DESCRIPTION="An utility for reading and querying Windows NT/2K/XP registries"
HOMEPAGE="http://projects.sentinelchicken.org/reglookup/"
SRC_URI="http://projects.sentinelchicken.org/data/downloads/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos ~x86-macos"

RDEPEND="
	sys-libs/talloc
	virtual/libiconv"

S="${WORKDIR}/${PN}-src-${PV}"

PATCHES=( "${FILESDIR}"/${PV}-cflags.patch )

src_prepare() {
	mv pyregfi-distutils.py setup.py || die
	distutils-r1_src_prepare
}

src_compile() {
	escons
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install
	dobin bin/reglookup-timeline src/reglookup src/reglookup-recover
	dolib.so lib/libregfi.so
	doman doc/*.1.gz
	dodir /usr/include/regfi
	insinto /usr/include/regfi
	doins include/*.h
}
