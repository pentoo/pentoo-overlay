# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit git-r3 python-single-r1

DESCRIPTION="Unicorn bindings"
HOMEPAGE="http://www.unicorn-engine.org"
EGIT_REPO_URI="https://github.com/unicorn-engine/unicorn.git"
EGIT_COMMIT="7b47ab6b667f8959cbfe149fc67de7cfcd0bcf54"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="go java python ruby"

RDEPEND="
	go? ( dev-lang/go )
	ruby? ( || ( dev-lang/ruby:2.1 dev-lang/ruby:2.2 dev-lang/ruby:2.3 ) )
"

DEPEND="${RDEPEND}
	~dev-util/unicorn-${PV}
	virtual/pkgconfig"

S="${WORKDIR}/${P}"/bindings

src_prepare(){
	use go || sed -i -e '/cd go/d' Makefile
	use java || sed -i -e '/cd java/d' Makefile
}
