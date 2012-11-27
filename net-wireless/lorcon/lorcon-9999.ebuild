# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

USE_RUBY="ruby18 ruby19"
RUBY_OPTIONAL=yes

inherit git-2 distutils ruby-ng

DESCRIPTION="A generic library for injecting 802.11 frames"
HOMEPAGE="http://802.11ninja.net/lorcon"
EGIT_REPO_URI="https://code.google.com/p/lorcon/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="python ruby"

DEPEND="ruby? ( $(ruby_implementations_depend) )"
RDEPEND="${DEPEND}
	dev-libs/libnl"

S="${WORKDIR}"/all

pkg_setup() {
        if use python; then
                python_pkg_setup;
                DISTUTILS_SETUP_FILES=("${S}/pylorcon2|setup.py")
	fi
	use ruby && ruby-ng_pkg_setup
}

src_unpack() {
	git-2_src_unpack
	use ruby && ruby-ng_src_unpack
}

src_prepare() {
	use python && distutils_src_prepare
	sed -i 's#<lorcon2/lorcon.h>#"../lorcon.h"#' pylorcon2/PyLorcon2.c
	sed -i 's#find_library("orcon2", "lorcon_list_drivers", "lorcon2/lorcon.h") and ##' ruby-lorcon/extconf.rb
	sed -i "s#-I/usr/include/lorcon2#-I${WORKDIR}/all#" ruby-lorcon/extconf.rb
	sed -i 's#<lorcon2/lorcon.h>#"../lorcon.h"#' ruby-lorcon/Lorcon2.h
	use ruby && ruby-ng_src_prepare
}

src_configure() {
	default_src_configure
	use ruby && ruby-ng_src_configure
}

src_compile() {
	default_src_compile
	if use python; then
		LDFLAGS+=" -L${S}/.libs/"
		distutils_src_compile
	fi
	use ruby && ruby-ng_src_compile
}

src_install() {
	emake DESTDIR="${ED}" install
	use python && distutils_src_install
	use ruby && ruby-ng_src_install
}

src_test() {
	:
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}
pkg_postrm() {
	use python && distutils_pkg_postrm
}

each_ruby_configure() {
	${RUBY} -C "ruby-lorcon" extconf.rb
	sed -i "s#-L\.#-L. -L${WORKDIR}/all/.libs -lorcon2 #g" ruby-lorcon/Makefile
}

each_ruby_compile() {
	emake -C ruby-lorcon
}

each_ruby_install() {
	DESTDIR="${ED}" emake -C ruby-lorcon install
}
