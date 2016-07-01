# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="An advanced CPU-based password recovery utility"
HOMEPAGE="https://github.com/hashcat/hashcat"
SRC_URI="https://github.com/hashcat/hashcat/archive/v3.00.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+opencl"

DEPEND="opencl? ( virtual/opencl )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}"-release.patch
	#do not strip
	sed -i "/CFLAGS_NATIVE            += -s/d" src/Makefile || einfo "stripping failed"
	export PREFIX=/usr
}
