# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

MY_P="${PN}.${PV}"
DESCRIPTION="A library to decode Bluetooth baseband packets"
HOMEPAGE="http://libbtbb.sourceforge.net/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="http://git.code.sf.net/p/libbtbb/code"
	inherit git
	KEYWORDS="-*"
else
	SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL2"
SLOT="0"
IUSE=""

S="${WORKDIR}/${PN}"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.5-makefile.patch
}

src_install() {
	dodir /usr/$(get_libdir)
	dodir /usr/include
	emake LDCONFIG=true DESTDIR="${D}" INSTALL_DIR="${ED}/usr/$(get_libdir)" INCLUDE_DIR="${ED}/usr/include" install
	}
