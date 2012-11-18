# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

DESCRIPTION="An open source framework for tools that can distribute brute force cryptanalysis"
HOMEPAGE="http://selectiveintellect.com/wisecracker.html"
KEYWORDS="~amd64"
SRC_URI="https://github.com/vikasnkumar/wisecracker/archive/v1.0.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="mpi"

DEPEND="virtual/opencl
	mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}
	dev-libs/openssl
	dev-util/xxd"

export OPENCL_ROOT="/usr/"

src_install() {
	emake DESTDIR="${D}" install
}
