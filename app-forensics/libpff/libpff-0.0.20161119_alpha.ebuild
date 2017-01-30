# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit versionator

MY_DATE="$(get_version_component_range 3)"

DESCRIPTION="Library for accessing Personal Folder Files."
HOMEPAGE="https://github.com/libyal/libpff"
SRC_URI="https://github.com/libyal/libpff/archive/20161119.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-forensics/libbfio"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-20161119"
