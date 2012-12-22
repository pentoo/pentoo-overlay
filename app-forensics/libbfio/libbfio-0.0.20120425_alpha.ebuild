# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit versionator

MY_DATE="$(get_version_component_range 3)"

DESCRIPTION="Library for providing a basic file input/output abstraction layer."
HOMEPAGE="http://code.google.com/p/libbfio/"
SRC_URI="http://libbfio.googlecode.com/files/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="unicode"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_DATE}"

src_configure() {
	econf $(use_enable unicode wide-character-type)
}

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install"
}
