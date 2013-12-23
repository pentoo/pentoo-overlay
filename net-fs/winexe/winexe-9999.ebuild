# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit git-2 eutils python-single-r1

DESCRIPTION="remotely execute commands on Windows NT/2000/XP/2003 systems, with lmhash passthrough support"
HOMEPAGE="http://sourceforge.net/projects/winexe/"
EGIT_REPO_1="git://git.code.sf.net/p/winexe/winexe-waf"
EGIT_REPO_2="git://git.samba.org/samba.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+static"

DEPEND="net-libs/gnutls
	dev-libs/popt
	dev-libs/cyrus-sasl
	dev-util/mingw64-runtime
	dev-libs/libbsd
	!static? ( >=net-fs/samba-4.0.0 )"
RDEPEND="${DEPEND}"

# a nasty hack to get Samba sources for the static option
src_unpack() {
	EGIT_REPO_URI="${EGIT_REPO_1}"
	git-2_src_unpack

	if use static; then
		EGIT_SOURCEDIR="${S}/samba"
		EGIT_REPO_URI="${EGIT_REPO_2}"
		git-2_src_unpack
	fi
}

src_configure() {
	cd source

	local myconf
	if use static; then
	    myconf = "--samba-dir=../samba"
	else
		#--samba-inc-dirs=... --samba-lib-dirs=...
		myconf = "--enable-shared"
	fi

	./waf configure ${myconf}
}

src_compile() {
	cd source
	./waf build
}

src_install() {
	dobin "${S}"/build/winexe-static
}
