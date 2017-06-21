# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

DESCRIPTION="Language bindings for radare2"
HOMEPAGE="http://www.radare.org"
HOMEPAGE="https://github.com/radare/radare2-bindings"
SRC_URI="https://github.com/radare/radare2-bindings/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
#full set: "ctypes cxx guile java lua node-ffi perl php5 python ruby"
IUSE="ctypes cxx guile lua perl php5 python ruby"

#QA_MULTILIB_PATHS="usr/lib/ruby/1.9.1/r2/.*"

RDEPEND="
	cxx? ( sys-devel/gcc:*[cxx] )
	perl? ( dev-lang/perl )
	guile? ( dev-scheme/guile:* )
	lua? ( >=dev-lang/lua-5.1.4:* )
	php5? ( >=dev-lang/php-5.3.8:* )
	ruby? ( || ( dev-lang/ruby:2.1 dev-lang/ruby:2.2 ) )
"

DEPEND="${RDEPEND}
	~dev-util/radare2-${PV}
	virtual/pkgconfig
	dev-util/valabind
	dev-lang/swig"

src_prepare(){
	epatch "${FILESDIR}/01_use_python_2.7.patch"
	eapply_user
}

src_configure(){
	local myconf
	local mylang

	use php5 && myconf="php"

	for mylang in ctypes cxx guile lua perl python ruby; do
		if use $mylang; then
			[ -z "$myconf" ] || myconf+=","
			myconf+="$mylang"
		fi
	done

	#not included languages will be disabled
	econf --enable="$myconf"
}

src_install() {
#	emake install INSTALL_ROOT="${D}"
	default
	python_optimize
}
