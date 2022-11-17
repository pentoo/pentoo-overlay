# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )

inherit python-any-r1 scons-utils subversion

DESCRIPTION="An utility for reading and querying Windows NT/2K/XP registries"
HOMEPAGE="http://projects.sentinelchicken.org/reglookup/"
ESVN_REPO_URI="https://code.blindspotsecurity.com/dav/reglookup/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	sys-libs/talloc
	virtual/libiconv"

S="${WORKDIR}/${PN}-src-${PV}"

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
