# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:
# /var/cvsroot/gentoo-x86/dev-util/r2-bindings/r2-bindings-9999.ebuild,v 1.0 2011/12/12 06:20:21 akochkov Exp $

EAPI="4"
inherit base eutils mercurial python

DESCRIPTION="Language bindings for radare2"
HOMEPAGE="http://www.radare.org"
EHG_REPO_URI="http://radare.org/hg/radare2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cxx python perl php lua nodejs guile ruby"

RDEPEND="perl? ( dev-lang/perl )
	php? ( >=dev-lang/php-5.3.8 )
	lua? ( >=dev-lang/lua-5.1.4 )
	nodejs? ( dev-lang/nodejs )
	guile? ( dev-scheme/guile )
	ruby? ( >=dev-lang/ruby-1.8.7 )"

DEPEND="${RDEPEND}
	dev-util/radare2
	dev-util/pkgconfig
	dev-util/valabind
	dev-lang/swig
	>=dev-lang/vala-0.14"

PYTHON_DEPEND="python? 2:2.7"

src_prepare() {
	base_src_prepare
}

src_configure() {
	cd "${S}/r2-bindings"
	econf --enable-devel
}

src_compile() {
	# TODO: add another languages
	local lang_var

	for lang_var in cxx python perl php lua nodejs guile ruby ; do
		if use ${lang_var} ; then
			if [[ ${lang_var} == php ]] ; then
				cd "${S}/r2-bindings/${lang_var}5"
			else
				cd "${S}/r2-bindings/${lang_var}"
			fi

			[[ ${lang_var} == python ]]  && export
			PYTHON_CONFIG=python2.7-config

			emake || die "compile failed"
		fi
	done

}

src_install() {
	# TODO: add another languages
	local lang_var

	for lang_var in cxx python perl php lua nodejs guile ruby ; do
		if use ${lang_var} ; then
			if [[ ${lang_var} == php ]] ; then
				cd "${S}/r2-bindings/${lang_var}5"
			else
				cd "${S}/r2-bindings/${lang_var}"
			fi

			[[ ${lang_var} == python ]]  && export
			PYTHON_CONFIG=python2.7-config

			emake DESTDIR="${ED}" install || die "compile failed"
		fi
	done
}
