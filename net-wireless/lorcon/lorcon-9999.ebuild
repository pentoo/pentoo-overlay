# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit git-2 distutils

DESCRIPTION="A generic library for injecting 802.11 frames"
HOMEPAGE="http://802.11ninja.net/lorcon"
SRC_URI=""
EGIT_REPO_URI="https://code.google.com/p/lorcon/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="python ruby"

DEPEND="${RDEPEND}"
RDEPEND="dev-libs/libnl"

pkg_setup() {
        if use python; then
                python_pkg_setup;
                DISTUTILS_SETUP_FILES=("${S}/pylorcon2|setup.py")
	fi
}

src_prepare() {
	use python && distutils_src_prepare
	sed -i 's#<lorcon2/lorcon.h>#"../lorcon.h"#' pylorcon2/PyLorcon2.c
	sed -i 's#find_library("orcon2", "lorcon_list_drivers", "lorcon2/lorcon.h") and ##' ruby-lorcon/extconf.rb
	sed -i "s#-I/usr/include/lorcon2#-I${S}/#" ruby-lorcon/extconf.rb
	sed -i 's#<lorcon2/lorcon.h>#"../lorcon.h"#' ruby-lorcon/Lorcon2.h
}

src_compile() {
	emake
	if use python; then
		LDFLAGS+=" -L${S}/.libs/"
		distutils_src_compile
	fi
	if use ruby; then
		cd "${S}"/ruby-lorcon
		ruby extconf.rb
		sed -i "s#-L\.#-L. -L${S}/.libs -lorcon2 #g" Makefile
		emake
	fi
}

src_install () {
	emake DESTDIR="${ED}" install
	use python && distutils_src_install
	if use ruby; then
		cd "${S}"/ruby-lorcon
		emake DESTDIR="${ED}" install
	fi
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}
pkg_postrm() {
	use python && distutils_pkg_postrm
}
