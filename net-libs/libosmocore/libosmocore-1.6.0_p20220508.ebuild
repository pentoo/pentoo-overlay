# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Utility functions for OsmocomBB, OpenBSC and related projects"
HOMEPAGE="http://bb.osmocom.org/trac/wiki/libosmocore"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.osmocom.org/${PN}.git"
	KEYWORDS=""
else
	COMMIT="8f25fd27ed35d6cb47b5e57aea632d088b69bfe0"
	SRC_URI="https://github.com/osmocom/libosmocore/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	#Tests fail, no keywords for you
	#KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="GPL-2 LGPL-3"
SLOT="0"
IUSE="pcsc-lite"
RESTRICT="test"

RDEPEND="virtual/libusb:1
	net-libs/gnutls:=
	net-libs/libmnl:=
	net-misc/lksctp-tools
	sys-libs/talloc
	pcsc-lite? ( sys-apps/pcsc-lite )"

DEPEND="${RDEPEND}
	app-doc/doxygen
"

PATCHES=( "${FILESDIR}/${PN}-0.6.0-automake-1.13.patch" )

src_prepare() {
	default_src_prepare
	# set correct version in pkgconfig files
	sed -i "s/UNKNOWN/${PV}/" git-version-gen || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable pcsc-lite pcsc)
}

src_install() {
	default
	find "${D}" -xtype f -name '*.la' -delete || die
}
