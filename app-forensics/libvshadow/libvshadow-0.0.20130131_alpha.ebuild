# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit versionator
MY_DATE="$(get_version_component_range 3)"

DESCRIPTION="Library and tools to support the Volume Shadow Snapshot (VSS) format."
HOMEPAGE="http://code.google.com/p/libvshadow/"
SRC_URI="http://libvshadow.googlecode.com/files/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="python"

DEPEND=""
RDEPEND="${DEPEND}
	sys-fs/fuse"

S="${WORKDIR}/${PN}-${MY_DATE}"

src_configure() {
	econf $(use_enable python)
}
