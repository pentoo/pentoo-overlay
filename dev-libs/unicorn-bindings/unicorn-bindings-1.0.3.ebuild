# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
inherit multilib distutils-r1

DESCRIPTION="Unicorn bindings"
HOMEPAGE="http://www.unicorn-engine.org"
SRC_URI="https://github.com/unicorn-engine/unicorn/archive/${MY_PV}.tar.gz -> unicorn-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#use unicron[python] instead
#KEYWORDS="~amd64 ~x86"
IUSE="python"

RDEPEND="~dev-util/unicorn-${PV}"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	python? ( dev-python/setuptools[${PYTHON_USEDEP}] )
	"
#	go? ( dev-lang/go )
#	ruby? ( dev-lang/ruby:* )

S="${WORKDIR}/unicorn-${PV}"/bindings

pkg_setup() {
	python_setup
}

src_prepare(){
	#do not compile C extensions
	export LIBUNICORN_PATH=1

#	use go || sed -i -e '/go gen_const/d' Makefile
#	use java || sed -i -e '/java gen_const/d' Makefile
#	use python || sed -i -e '/python gen_const/d' Makefile
#	use ruby || sed -i -e '/ruby gen_const/d' Makefile

	sed -i -e '/const_generator.py dotnet/d' Makefile
	#fix python2 install
	sed -i "s|python setup.py install|python2 setup.py install|" python/Makefile || die
	eapply_user
}

src_compile(){
	einfo "Nothing to compile"
}

src_install(){
	if use python; then
		myinstall_python() {
			if python_is_python3; then
				emake -C python DESTDIR="${D}" install3
			else
				emake -C python DESTDIR="${D}" install
			fi
			python_optimize
		}
		python_foreach_impl myinstall_python
	fi
}
