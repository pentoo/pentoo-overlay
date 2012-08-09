# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 eutils python

DESCRIPTION="remotely execute commands on Windows NT/2000/XP/2003 systems, with lmhash passthrough support"
HOMEPAGE="http://sourceforge.net/projects/winexe/"
EGIT_REPO_URI="git://winexe.git.sourceforge.net/gitroot/winexe/winexe"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/gnutls
	dev-libs/popt
	dev-libs/cyrus-sasl"
RDEPEND="${DEPEND}"

#This probably should be merged into the samba ebuild on a useflag

pkg_setup() {
        python_set_active_version 2
        python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/winexe-passthrough.patch
}
src_configure() {
	cd source4
	./autogen.sh # should we be using eautoreconf really?
	econf \
		--enable-fhs
}
src_compile() {
	cd source4
	emake || die "compile failed"
}
src_install() {
	dobin "${S}"/source4/bin/winexe
}
