# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit git-2 distutils

DESCRIPTION="A generic library for injecting 802.11 frames"
HOMEPAGE="http://802.11ninja.net/lorcon"
SRC_URI=""
#ESVN_REPO_URI="http://802.11ninja.net/svn/lorcon/trunk/"
EGIT_REPO_URI="https://code.google.com/p/lorcon/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+python "

DEPEND="${RDEPEND}"
RDEPEND="dev-libs/libnl"

pkg_setup() {
        if use python; then
                python_pkg_setup;
                DISTUTILS_SETUP_FILES=("${S}/pylorcon2|setup.py")
		PYTHON_MODNAME="pylorcon2"
	fi
}

src_compile() {
	default_src_compile
	use python && distutils_src_compile
	#if use ruby; then
	#	cd "${S}"/ruby-lorcon
	#	ruby extconf.rb
	#	emake
	#fi
}

src_install () {
	emake DESTDIR="${D}" install
	use python && distutils_src_install
	#if use ruby; then
	#	cd "${S}"/ruby-lorcon
	#	emake DESTDIR="${ED}" install
	#fi
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}

