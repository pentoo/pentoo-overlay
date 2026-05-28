# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

HASH_COMMIT="cc600ee98c4ed23b8ab0bc2cf6b6c6e9cb587e89"

DESCRIPTION="Utilities to read and convert MS Outlook personal folders (.pst) files."
HOMEPAGE="https://www.five-ten-sg.com/libpst/"
#SRC_URI="https://www.five-ten-sg.com/libpst/packages/${P}.tar.gz"
SRC_URI="https://github.com/pst-format/libpst/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${HASH_COMMIT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug static shared python profiling"

BDEPEND="python? ( dev-python/setuptools )"

DEPEND="
	gnome-extra/libgsf
	sys-libs/zlib
	python? ( dev-libs/boost[python] )
"
RDEPEND="${DEPEND}"

#PATCHES=(
#	"${FILESDIR}"/gcc_c23.patch
#	"${FILESDIR}"/python3-modern.patch
#	"${FILESDIR}"/python-sitedir.patch
#)

src_prepare() {
	cp "${FILESDIR}"/{readpst.1,pst2ldif.1,pst2dii.1,lspst.1,outlook.pst.5} man/ || die
	mkdir -p m4 || die
	cp "${FILESDIR}"/ax_python.m4 m4/ || die
	cp "${FILESDIR}"/ax_python_devel.m4 m4/ || die
	cp "${FILESDIR}"/ax_boost_python.m4 m4/ || die
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
			$(use_enable debug pst-debug) \
			$(use_enable static static-tools) \
			$(use_enable shared libpst-shared) \
			$(use_enable python) \
			$(use_enable profiling)
}
