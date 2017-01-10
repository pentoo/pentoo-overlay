# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils python-single-r1 multilib

DESCRIPTION="A framework which aims to analyze and recover any kind of digital artifact"
HOMEPAGE="http://tracker.digital-forensic.org/"
SRC_URI="http://dev.pentoo.ch/~zero/distfiles/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc ewf +aff +dff +pff"

RDEPEND="${PYTHON_DEPS}
	dev-python/sip[${PYTHON_USEDEP}]
	doc? ( >=dev-python/PyQt4-4.4.0[help,webkit,assistant,${PYTHON_USEDEP}] )
	!doc? ( >=dev-python/PyQt4-4.4.0[${PYTHON_USEDEP}] )
	dev-python/python-magic[${PYTHON_USEDEP}]
	"

DEPEND="${RDEPEND}
	ewf? ( >=app-forensics/libewf-20100226 )
	aff? ( >=app-forensics/afflib-3.6.8 )
	dff? ( >=app-forensics/libbfio-0.0.20120425 )
	pff? ( >=app-forensics/libpff-0.0.20120802_alpha )
	>=dev-lang/swig-1.3.38
	dev-libs/tre[python]
	"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	#epatch "${FILESDIR}/${P}-disable-qtassistant.patch"
	#epatch "${FILESDIR}/${P}-libpff-0.0.20120513.patch"

	epatch "${FILESDIR}/${PV}-libav10.patch"
	epatch "${FILESDIR}/${PV}-fix-ftbfs-libav9.patch"

	python_fix_shebang .
	sed -i 's:^python:python2:' ressources/linux_launcher.sh || die "sed makefile"

	sed -i 's|^declare_icu_component(le|#declare_icu_component(le|' cmake_modules/FindICU.cmake
	sed -i 's|^declare_icu_component(lx|#declare_icu_component(lx|' cmake_modules/FindICU.cmake

}

src_configure() {
	export LIBDIR=$(get_libdir)
	mycmakeargs+=( "-DINSTALL:BOOLEAN=ON" )
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	#byte-complation fix
	python_optimize
}
