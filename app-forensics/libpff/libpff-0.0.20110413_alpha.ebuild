# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit versionator

MY_DATE="$(get_version_component_range 3)"

DESCRIPTION="Library for accessing Personal Folder Files."
HOMEPAGE="http://sf.net/projects/libpff"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}-alpha/${PN}-alpha-${MY_DATE}/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-forensics/libbfio"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_DATE}"

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install"
}
