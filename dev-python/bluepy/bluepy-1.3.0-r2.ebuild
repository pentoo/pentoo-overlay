# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi fcaps

DESCRIPTION="Python interface to Bluetooth LE on Linux"
HOMEPAGE="https://github.com/IanHarvey/bluepy"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="${PYTHON_DEPS}
	dev-libs/glib:2"
DEPEND="${RDEPEND}"

src_prepare(){
	sed -i 's|description-file|description_file|' setup.cfg || die "failed to sed setup.cfg"
	sed -i 's|$(CFLAGS) $(CPPFLAGS)|$(CFLAGS) $(CPPFLAGS) $(LDFLAGS)|' bluepy/Makefile || die "failed to sed Makefile"
	#compile bluepy-helper using python_compile() later. Or not
	#sed -i '/pre_install()$/d' setup.py || die "failed to sed setup.py"
	distutils-r1_src_prepare
#	eapply_user
}

#python_compile() {
#	pushd bluepy > /dev/null
	#FIXME: broken Makefile, do not untar multiple times
#	emake -j1
#	popd > /dev/null
#	distutils-r1_python_compile
#}

pkg_postinst() {
	python_setup
	fcaps cap_net_raw,cap_net_admin+eip  $(python_get_sitedir)/bluepy/bluepy-helper
	rm $(python_get_sitedir)/${PN}/{bluez-src.tgz,bluepy-helper.c,Makefile,version.h}
}
