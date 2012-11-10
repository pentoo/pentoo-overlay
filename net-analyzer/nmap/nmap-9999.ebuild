# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-6.01.ebuild,v 1.3 2012/09/23 09:14:51 pinkbyte Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit eutils flag-o-matic python subversion

MY_P=${P/_beta/BETA}

DESCRIPTION="A utility for network exploration or security auditing"
HOMEPAGE="http://nmap.org/"
SRC_URI=""
ESVN_REPO_URI="https://svn.nmap.org/nmap/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gtk lua ncat ndiff nmap-update nping ssl"

DEPEND="dev-libs/libpcre
	net-libs/libpcap[ipv6]
	dev-libs/apr
	gtk? ( >=x11-libs/gtk+-2.6:2
		   >=dev-python/pygtk-2.6
		   || ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] dev-lang/python:2.5[sqlite] dev-python/pysqlite:2 )
		 )
	lua? ( >=dev-lang/lua-5.1.4-r1[deprecated] )
	nmap-update? ( dev-libs/apr dev-vcs/subversion )
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-4.75-include.patch
	epatch "${FILESDIR}"/${PN}-4.75-nolua.patch
	epatch "${FILESDIR}"/${PN}-5.10_beta1-string.patch
	epatch "${FILESDIR}"/${PN}-5.21-python.patch
#	epatch "${FILESDIR}"/${PN}-5.51-su-to-zenmap-fix.patch
	sed -i -e 's/-m 755 -s ncat/-m 755 ncat/' ncat/Makefile.in

	# bug #416987
	epatch "${FILESDIR}"/${PN}-6.01-make.patch

	# Fix desktop files wrt bug #432714
	sed -i -e '/^Encoding/d' zenmap/install_scripts/unix/zenmap.desktop
	sed -i -e '/^Encoding/d' zenmap/install_scripts/unix/zenmap-root.desktop
	sed -i -e 's/Categories=Application;Network;Security/Categories=Network;System;Security/' zenmap/install_scripts/unix/zenmap.desktop
	sed -i -e 's/Categories=Application;Network;Security/Categories=Network;System;Security/' zenmap/install_scripts/unix/zenmap-root.desktop
}

src_configure() {
	# The bundled libdnet is incompatible with the version available in the
	# tree, so we cannot use the system library here.
	econf --with-libdnet=included \
		$(use_with gtk zenmap) \
		$(use_with lua liblua) \
		$(use_with ncat) \
		$(use_with ndiff) \
		$(use_with nmap-update) \
		$(use_with nping) \
		$(use_with ssl openssl)
}

src_install() {
	LC_ALL=C emake DESTDIR="${D}" -j1 STRIP=: nmapdatadir="${EPREFIX}"/usr/share/nmap install
	if use nmap-update;then
		LC_ALL=C emake DESTDIR="${D}" -j1 STRIP=: \
			nmapdatadir="${EPREFIX}"/usr/share/nmap -C nmap-update install
	fi
	dodoc CHANGELOG HACKING docs/README docs/*.txt

	use gtk && doicon "${FILESDIR}/nmap-logo-64.png"
}
