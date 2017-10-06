# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )
inherit multilib distutils-r1 eutils

DESCRIPTION="Unicorn bindings"
HOMEPAGE="http://www.unicorn-engine.org"
SRC_URI="https://github.com/unicorn-engine/unicorn/archive/${PV}.tar.gz -> unicorn-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="python"

RDEPEND="~dev-util/unicorn-${PV}"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	python? ( dev-python/setuptools[${PYTHON_USEDEP}] )
	"
#	go? ( dev-lang/go )
#	ruby? ( dev-lang/ruby:* )

S="${WORKDIR}/unicorn-${PV}"/bindings

src_prepare(){
	epatch "${FILESDIR}"/prebuilt.patch

#	use go || sed -i -e '/go gen_const/d' Makefile
#	use java || sed -i -e '/java gen_const/d' Makefile
#	use python || sed -i -e '/python gen_const/d' Makefile
#	use ruby || sed -i -e '/ruby gen_const/d' Makefile

	sed -i -e '/const_generator.py dotnet/d' Makefile
	eapply_user
}

src_compile(){
	einfo "Nothing to compile"
#	emake -C python DESTDIR="${D}" check
}

src_install(){
	if use python; then
		if use python_targets_python2_7; then
			emake -C python DESTDIR="${D}" install
		fi
		if use python_targets_python3_4; then
			emake -C python DESTDIR="${D}" install3
		fi
	fi
}
