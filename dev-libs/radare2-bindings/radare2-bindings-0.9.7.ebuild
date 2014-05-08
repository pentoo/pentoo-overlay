# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

DESCRIPTION="Language bindings for radare2"
HOMEPAGE="http://www.radare.org"
HOMEPAGE="https://github.com/radare/radare2-bindings"
SRC_URI="https://github.com/radare/radare2-bindings/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
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
	virtual/pkgconfig
	dev-util/valabind
	dev-lang/swig
	>=dev-lang/vala-0.14"

src_compile() {
	# TODO: add another languages
	local lang_var

#	for lang_var in cxx python perl php lua nodejs guile ruby ; do
	for lang_var in python perl lua ruby ; do
		if use ${lang_var} ; then
                        einfo "language: ${lang_var}"
			if [[ ${lang_var} == php ]] ; then
				cd "${S}/${lang_var}5"
			else
				cd "${S}/${lang_var}"
			fi

			[[ ${lang_var} == python ]] && export PYTHON_CONFIG=python2.7-config
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
				cd "${S}/${lang_var}5"
			else
				cd "${S}/${lang_var}"
			fi

			[[ ${lang_var} == python ]] && export PYTHON_CONFIG=python2.7-config
			emake DESTDIR="${ED}" install || die "compile failed"
		fi
	done
}
