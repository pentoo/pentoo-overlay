# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit qmake-utils python-r1

DESCRIPTION="A Qt and C++ GUI for radare2 reverse engineering framework"
HOMEPAGE="http://www.radare.org"
SRC_URI="https://github.com/radareorg/cutter/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+jupyter webengine"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	>=dev-util/radare2-2.2.0
	jupyter? ( dev-python/jupyter_client
		dev-python/notebook )
	webengine? ( dev-qt/qtwebengine )"
RDEPEND="${DEPEND}"

REQUIRED_USE="webengine? ( jupyter )"

src_prepare(){
	python_setup
	if python_is_python3; then
		MY_PYTHON=${EPYTHON/python/python-}
		sed -i "s|packagesExist(python3)|packagesExist(${MY_PYTHON})|" src/Cutter.pro
		sed -i "s|PKGCONFIG += python3|PKGCONFIG += ${MY_PYTHON}|" src/Cutter.pro
	else
		die "python3 not found"
	fi

	eapply_user
}

src_configure() {
	eqmake5 PREFIX="/usr" \
	CUTTER_ENABLE_JUPYTER="$(usex jupyter 'true' 'false')" \
	CUTTER_ENABLE_QTWEBENGINE="$(usex webengine 'true' 'false')" \
	src
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
