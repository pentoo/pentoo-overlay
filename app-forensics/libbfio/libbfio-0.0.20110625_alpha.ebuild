# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit versionator

MY_DATE="$(get_version_component_range 3)"

DESCRIPTION="Library for providing a basic file input/output abstraction layer."
HOMEPAGE="http://sf.net/projects/libbfio"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}-alpha/${PN}-alpha-${MY_DATE}/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_DATE}"

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install"
}
