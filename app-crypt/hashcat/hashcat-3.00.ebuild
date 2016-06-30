# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils

OPEHCL_COMMIT="8e196ba99632fc43998cf17cce87282c250d9177"
DESCRIPTION="An advanced CPU-based password recovery utility"
HOMEPAGE="https://github.com/hashcat/hashcat"
SRC_URI="https://github.com/hashcat/hashcat/archive/v3.00.tar.gz -> ${P}.tar.gz
	https://github.com/KhronosGroup/OpenCL-Headers/archive/${OPEHCL_COMMIT}.zip"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}"-release.patch
	mkdir -p deps/OpenCL-Headers/CL
	cp -r "${WORKDIR}"/OpenCL-Headers-${OPEHCL_COMMIT}/* deps/OpenCL-Headers/CL/
	#do not strip
	sed -i "/CFLAGS_NATIVE            += -s/d" src/Makefile || einfo "stripping failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
