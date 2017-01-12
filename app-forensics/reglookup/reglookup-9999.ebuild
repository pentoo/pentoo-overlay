# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id $

EAPI="5"

SONAME_PV="1.0.1"

PYTHON_COMPAT=( python2_7 )
inherit scons-utils distutils-r1 subversion

DESCRIPTION="An utility for reading and querying Windows NT/2K/XP registries"
HOMEPAGE="http://projects.sentinelchicken.org/reglookup/"
ESVN_REPO_URI="https://code.blindspotsecurity.com/dav/reglookup/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="sys-libs/talloc
	virtual/libiconv"

src_compile() {
	escons
}

src_install() {
	distutils-r1_src_install
	dobin bin/reglookup-timeline src/reglookup src/reglookup-recover
	dolib.so lib/libregfi.so
	dolib.so lib/libregfi.so.1
	dolib.so lib/libregfi.so."${SONAME_PV}"
	#fix me, add Doxygen
#	doman doc/*.1.gz
	dodir /usr/include/regfi
	insinto /usr/include/regfi
	doins include/*.h
}
