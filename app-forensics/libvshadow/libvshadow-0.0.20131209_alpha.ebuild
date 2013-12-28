# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )
inherit versionator python-single-r1

MY_DATE="$(get_version_component_range 3)"

DESCRIPTION="Library and tools to support the Volume Shadow Snapshot (VSS) format."
HOMEPAGE="http://code.google.com/p/libvshadow/"
SRC_URI="http://dev.pentoo.ch/~blshkv/distfiles/${PN}-alpha-${MY_DATE}.tar.gz http://dev.pentoo.ch/~zero/distfiles/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="python"

DEPEND="app-forensics/libbfio"
RDEPEND="${DEPEND}
	sys-fs/fuse"

S="${WORKDIR}/${PN}-${MY_DATE}"

src_configure() {
	econf $(use_enable python)
}
