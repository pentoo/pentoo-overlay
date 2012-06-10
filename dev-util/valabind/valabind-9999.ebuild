# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valabind/valabind-9999.ebuild,v 1.0 2011/12/07 06:20:21 akochkov Exp $

EAPI="3"
inherit base eutils mercurial

DESCRIPTION="Valabind is a tool to parse vala or vapi files to transform them into swig files"
HOMEPAGE="http://hg.youterm.com/valabind"
EHG_REPO_URI="http://hg.youterm.com/valabind"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/vala-0.14
		dev-lang/swig"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	base_src_prepare
}

src_compile() {
	emake -j1 || die "compile failed"
}

src_install() {
	emake DESTDIR="${ED}" install || die "install failed"
}
