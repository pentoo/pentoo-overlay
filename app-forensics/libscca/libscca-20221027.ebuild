# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Library and tools to access the Windows Prefetch File (SCCA) format"
HOMEPAGE="https://github.com/libyal/libscca"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"
#upstream removed the release
#SRC_URI="https://pentoo.org/~zero/distfiles/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="nls unicode"

DEPEND="dev-libs/libcerror
	dev-libs/libcthreads
	dev-libs/libcdata
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libcsplit
	dev-libs/libuna
	dev-libs/libcfile
	dev-libs/libcpath
	app-forensics/libbfio
	dev-libs/libfcache
	dev-libs/libfdata
	dev-libs/libfdatetime
	dev-libs/libfvalue
	dev-libs/libfwnt
	"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type)
#		--with-libcerror \
#		--with-libcthreads \
#		--with-libcdata \
#		--with-libclocale \
#		--with-libcnotify \
#		--with-libcsplit \
#		--with-libuna \
#		--with-libcfile \
#		--with-libcpath
}
