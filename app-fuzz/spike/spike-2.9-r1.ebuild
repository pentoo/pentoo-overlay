# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit eutils

MY_PN="SPIKE"
MY_P="${MY_PN}${PV}"
DESCRIPTION="A generic network fuzzer"
HOMEPAGE="http://www.immunitysec.com/resources-freesoftware.shtml"
SRC_URI="http://www.immunitysec.com/downloads/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
S="${WORKDIR}/${MY_PN}/${MY_PN}/src"

src_prepare() {
	default
	# patch from http://resources.infosecinstitute.com/intro-to-fuzzing/
	eapply "${FILESDIR}/spike-fix-return_1_on_closed_socket.patch" || die "Patch failed"
}

src_configure(){
	econf || die "econf failed"
}

src_install() {
	local bin
	for bin in `grep "BINS = " Makefile | sed -e 's/BINS = //' -e 's/libdlrpc.so//'`
	do
		newbin "${bin}" "spike-${bin}"
	done
	dolib.so libdlrpc.so
	insinto /usr/share/${PN}
	doins *.spk
	doins -r audits/*
	cd ..
	dodoc README.txt TODO.txt CHANGELOG.txt
	if use doc; then
		dodoc documentation/*
	fi
}
