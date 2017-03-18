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
IUSE="ewf +aff +bfio +pff"

#	doc? ( dev-qt/assistant:4 )

RDEPEND="${PYTHON_DEPS}
	dev-python/sip[${PYTHON_USEDEP}]
	>=dev-python/PyQt4-4.4.0[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]
	dev-python/apsw[${PYTHON_USEDEP}]
	virtual/udev
	virtual/ffmpeg
	dev-python/tre-python
	sys-fs/fuse
	aff? ( >=app-forensics/afflib-3.6.8 )
	ewf? ( >=app-forensics/libewf-20100226 )
	dev-libs/icu
	"

DEPEND="${RDEPEND}
	bfio? ( >=app-forensics/libbfio-0.0.20120425 )
	pff? ( >=app-forensics/libpff-0.0.20120802_alpha )
	>=dev-lang/swig-1.3.38
	app-forensics/reglookup"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	#doc flag is broken, need to install help.* files manually
	epatch "${FILESDIR}/${PV}-disable-qtassistant.patch"
	#epatch "${FILESDIR}/${P}-libpff-0.0.20120513.patch"
#	epatch "${FILESDIR}/${PV}-libav10.patch"
#	epatch "${FILESDIR}/${PV}-ftbfs-libav9.patch"
	epatch "${FILESDIR}/${PV}-ffmpeg3.patch"

	python_fix_shebang .
	sed -i 's:^python:python2:' ressources/linux_launcher.sh || die "sed makefile"

	sed -i 's|^declare_icu_component(le|#declare_icu_component(le|' cmake_modules/FindICU.cmake
	sed -i 's|^declare_icu_component(lx|#declare_icu_component(lx|' cmake_modules/FindICU.cmake

	sed -i "s|/lib/dff/|/$(get_libdir)/dff/|" CMakeLists.txt
}

src_configure() {
	mycmakeargs+=( "-DINSTALL:BOOLEAN=ON" )
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	#byte-complation fix
	python_optimize
}
