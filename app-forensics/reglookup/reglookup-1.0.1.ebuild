# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit scons-utils distutils-r1

DESCRIPTION="An utility for reading and querying Windows NT/2K/XP registries"
HOMEPAGE="http://projects.sentinelchicken.org/reglookup/"
SRC_URI="http://projects.sentinelchicken.org/data/downloads/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE=""

RDEPEND="sys-libs/talloc
	virtual/libiconv"

S="${WORKDIR}/${PN}-src-${PV}"

src_prepare() {
	mv pyregfi-distutils.py setup.py
}
src_compile() {
	escons
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
