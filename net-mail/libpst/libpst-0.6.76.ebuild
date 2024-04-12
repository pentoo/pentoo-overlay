# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utilities to read and convert MS Outlook personal folders (.pst) files."
HOMEPAGE="https://www.five-ten-sg.com/libpst/"
SRC_URI="https://www.five-ten-sg.com/libpst/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug static shared python profiling"

DEPEND="
	gnome-extra/libgsf
	sys-libs/zlib
	python? ( dev-libs/boost[python] )
"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
			$(use_enable debug pst-debug) \
			$(use_enable static static-tools) \
			$(use_enable shared libpst-shared) \
			$(use_enable python) \
			$(use_enable profiling)
}
