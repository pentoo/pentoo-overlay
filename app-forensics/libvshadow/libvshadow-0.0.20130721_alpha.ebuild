# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="2"

inherit versionator python
MY_DATE="$(get_version_component_range 3)"

DESCRIPTION="Library and tools to support the Volume Shadow Snapshot (VSS) format."
HOMEPAGE="http://code.google.com/p/libvshadow/"
#SRC_URI="http://dev.pentoo.ch/~zero/distfiles/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="python"

DEPEND="app-forensics/libbfio"
RDEPEND="${DEPEND}
	sys-fs/fuse"

S="${WORKDIR}/${PN}-${MY_DATE}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	econf $(use_enable python)
}
