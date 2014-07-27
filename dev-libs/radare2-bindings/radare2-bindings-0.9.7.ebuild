# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

DESCRIPTION="Language bindings for radare2"
HOMEPAGE="http://www.radare.org"
HOMEPAGE="https://github.com/radare/radare2-bindings"
SRC_URI="https://github.com/radare/radare2-bindings/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
#IUSE="cxx python perl php lua nodejs guile ruby"
IUSE="perl lua ruby"

RDEPEND="perl? ( dev-lang/perl )
	lua? ( >=dev-lang/lua-5.1.4 )
	ruby? ( >=dev-lang/ruby-1.8.7 )"
#	php? ( >=dev-lang/php-5.3.8 )
#	nodejs? ( dev-lang/nodejs )
#	guile? ( dev-scheme/guile )

DEPEND="${RDEPEND}
	dev-util/radare2
	virtual/pkgconfig
	dev-util/valabind
	dev-lang/swig
	>=dev-lang/vala-0.14"

src_configure(){
	local myconf
	export PYTHON_CONFIG=python2.7-config

	#"ctypes cxx guile java lua node-ffi perl php5 python ruby"
	use perl && myconf+="perl"
	use ruby && myconf+="ruby"
	use lua && myconf+="lua"
	econf --disable="$myconf,ctypes,cxx,guile,java,node-ffi,python"
}

#src_compile() {
	# TODO: add another languages
#	local lang_var

#	for lang_var in cxx python perl php lua nodejs guile ruby ; do
#	for lang_var in python perl lua ruby ; do
#		if use ${lang_var} ; then
#			if [[ ${lang_var} == php ]] ; then
#				cd "${S}/${lang_var}5"
#			else
#				cd "${S}/${lang_var}"
#			fi

#			[[ ${lang_var} == python ]] && export PYTHON_CONFIG=python2.7-config
#			emake || die "compile failed"
#		fi
#	done

#	cd "${S}/python"
#	emake
#}

src_install() {
	# TODO: add another languages
#	local lang_var

#	for lang_var in cxx python perl php lua nodejs guile ruby ; do
#	for lang_var in python perl lua ruby ; do
#		if use ${lang_var} ; then
#			if [[ ${lang_var} == php ]] ; then
#				cd "${S}/${lang_var}5"
#			else
#				cd "${S}/${lang_var}"
#			fi

#			[[ ${lang_var} == python ]] && export PYTHON_CONFIG=python2.7-config
#			emake DESTDIR="${ED}" install || die "compile failed"
#		fi
#	done

#	export PYTHON_CONFIG=python2.7-config
#	cd "${S}/python"

	emake DESTDIR="${D}" PYTHON_CONFIG=python2.7-config install

#	emake DESTDIR="${ED}" install
}
