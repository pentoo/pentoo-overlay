# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Utility functions for OsmocomBB, OpenBSC and related projects"
HOMEPAGE="http://bb.osmocom.org/trac/wiki/libosmocore"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.osmocom.org/${PN}.git"
else
#	COMMIT="8f25fd27ed35d6cb47b5e57aea632d088b69bfe0"
#	SRC_URI="https://github.com/osmocom/libosmocore/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
#	S="${WORKDIR}/${PN}-${COMMIT}"

	KEYWORDS="amd64 arm64 x86"
	SRC_URI="https://github.com/osmocom/libosmocore/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
fi

LICENSE="GPL-2 LGPL-3"
SLOT="0"
IUSE="doc pcsc-lite"
#RESTRICT="test"

RDEPEND="virtual/libusb:1
	net-libs/gnutls:=
	net-libs/libmnl:=
	net-misc/lksctp-tools
	sys-libs/talloc
	pcsc-lite? ( sys-apps/pcsc-lite )"

DEPEND="${RDEPEND}
	doc? ( app-text/doxygen )
"

PATCHES=( "${FILESDIR}/${PN}-0.6.0-automake-1.13.patch" )

src_prepare() {
	# set correct version in pkgconfig files
	sed -i "s/UNKNOWN/${PV}/" git-version-gen || die
#	default_src_prepare
	eautoreconf
	eapply_user
}

src_configure() {
	local myconf=(
		$(use_enable doc doxygen)
		$(use_enable pcsc-lite pcsc)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	find "${D}" -xtype f -name '*.la' -delete || die
}
