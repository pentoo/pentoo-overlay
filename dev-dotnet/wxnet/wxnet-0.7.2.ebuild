# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils wxwidgets mono

DESCRIPTION="wxWidgets bindings for mono"
HOMEPAGE="http://wxnet.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/wx.NET-${PV}-Source.tar.gz"

LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc examples utils unicode"
RDEPEND=">=x11-libs/wxGTK-2.6.1:2.6[unicode]"
DEPEND="${RDEPEND}
		>=dev-lang/mono-1.0.4-r1
		dev-lang/perl
		dev-util/premake"

S="${WORKDIR}/wx.NET-${PV}"

pkg_setup() {
	export WX_GTK_VER="2.6"
}

src_prepare() {
	epatch "${FILESDIR}"/premake.patch
	epatch "${FILESDIR}"/premake.lua.patch

	cd "${S}"/Build/Linux || die "Could not change directory"
	cp Defs.in.template Defs.in
	epatch "${FILESDIR}"/Defs.in.patch
	cd "${S}"
	epatch "${FILESDIR}"/wx-config-helper.patch
	epatch "${FILESDIR}"/wxnet-64bit.patch
}

src_compile() {
	cd "${S}"/Build/Linux

	# Just satisfy the stupid wx-config-helper script
	mkdir -p "${S}"/wx/lib/wx/config

	cp ${WX_CONFIG} "${S}"/wx/lib/wx/config/ || \
		die "Could not copy wx-config file"

	export CONFIG="Release"
	emake wxnet-core || die "make wxnet-core failed"
	if use utils;then
		emake wxnet-utils || die "make wxnet-utils failed"
	fi
	if use examples; then
		emake wxnet-samples || die "make wxnet-samples failed"
	fi
}

src_install() {
	dolib Bin/libwx-c.so Bin/*dll

	if use utils; then
		exeinto /usr/bin
		doexe Bin/towxnet.exe
	fi
	# I delete the file so I can glob the samples
	rm "${S}"/Bin/towxnet.exe

	if use examples; then
		exeinto /usr/share/doc/${PF}/Samples
		doexe Bin/*.exe
	fi

	if use doc; then
		dodoc Bin/README.txt
		dohtml "${S}"/Docs/Manual/*
	fi
}
