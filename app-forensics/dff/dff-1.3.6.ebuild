# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils python-single-r1 multilib

CMODULES_COMMIT="92aac8b367c42024cdc1c13ded3d4579ded3dab7"
DOC_COMMIT="50d549e578718db8971e7949ee3828db7bca6522"

API_COMMIT="aafabd74cfb12d2694fc7a68d9d4469f9da7cb8f"
MODULES_COMMIT="2031af67221eb28df2f4304c6ac387d034498860"
UI_COMMIT="709998b9cfb65b7783a6e93d6fed08f871cb47f3"
UNSUPP_COMMIT="e66a6b0963c5d4da3c48f80cac70518b1eefda52"

DESCRIPTION="A framework which aims to analyze and recover any kind of digital artifact"
HOMEPAGE="https://github.com/arxsys/dff"
SRC_URI="https://github.com/arxsys/dff/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/arxsys/dff-cmake_modules/archive/${CMODULES_COMMIT}.zip -> dff-cmake_modules-${CMODULES_COMMIT}.zip
	https://github.com/arxsys/dff-doc/archive/${DOC_COMMIT}.zip -> dff-doc-${DOC_COMMIT}.zip

	https://github.com/arxsys/dff-api/archive/${API_COMMIT}.zip -> dff-api-${API_COMMIT}.zip
	https://github.com/arxsys/dff-modules/archive/${MODULES_COMMIT}.zip -> dff-modules-${MODULES_COMMIT}.zip
	https://github.com/arxsys/dff-ui/archive/${UI_COMMIT}.zip -> dff-ui-${UI_COMMIT}.zip
	https://github.com/arxsys/dff-unsupported/archive/${UNSUPP_COMMIT}.zip -> dff-unsupported-${UNSUPP_COMMIT}.zip
"

RESTRICT="mirror"

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
	ewf? ( >=app-forensics/libewf-20170701 )
	dev-libs/icu
	"

DEPEND="${RDEPEND}
	bfio? ( >=app-forensics/libbfio-0.0.20120425 )
	pff? ( >=app-forensics/libpff-0.0.20120802_alpha )
	>=dev-lang/swig-1.3.38
	app-forensics/reglookup"

#CMAKE_IN_SOURCE_BUILD=1

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	python_fix_shebang .

#	ln -s ${WORKDIR}/dff-cmake_modules-${CMODULES_COMMIT}/* cmake_modules/
#	ln -s ${WORKDIR}/dff-doc-${DOC_COMMIT}/* doc/
#	ln -s ${WORKDIR}/dff-api-${API_COMMIT}/* dff/api/
#	ln -s ${WORKDIR}/dff-modules-${MODULES_COMMIT}/* dff/modules/
#	ln -s ${WORKDIR}/dff-ui-${UI_COMMIT}/* dff/ui/
#	ln -s ${WORKDIR}/dff-unsupported-${UNSUPP_COMMIT}/* dff/unsupported/

	cp -r ${WORKDIR}/dff-cmake_modules-${CMODULES_COMMIT}/* cmake_modules/
	cp -r ${WORKDIR}/dff-doc-${DOC_COMMIT}/* doc/
	cp -r ${WORKDIR}/dff-api-${API_COMMIT}/* dff/api/
	cp -r ${WORKDIR}/dff-modules-${MODULES_COMMIT}/* dff/modules/
	cp -r ${WORKDIR}/dff-ui-${UI_COMMIT}/* dff/ui/
	cp -r ${WORKDIR}/dff-unsupported-${UNSUPP_COMMIT}/* dff/unsupported/

	sed -i "s|exceptions/breakpad/libbreakpad.a|crashreporter/breakpad/libbreakpad.a|" dff/api/crashreporter/CMakeLists.txt
	sed -i "s|exceptions/breakpad/libbreakpad.a|crashreporter/breakpad/libbreakpad.a|" dff/modules/CMakeLists.txt

	sed -i "s|else (WIN32)|elseif (UNIX)|" dff/api/crashreporter/reporter/CMakeLists.txt
#dl "${CMAKE_BINARY_DIR}/dff/api/crashreporter/breakpad/libbreakpad.a"
	sed -i "s|dl \"\${CMAKE_BINARY_DIR}/dff/api/crashreporter/breakpad/libbreakpad.a\"|\"\${CMAKE_BINARY_DIR}/dff/api/crashreporter/breakpad/libbreakpad.a\" dl|" dff/api/crashreporter/reporter/CMakeLists.txt

	epatch "${FILESDIR}/fixes.patch"
	sed -i "s|/lib/dff/|/$(get_libdir)/dff/|" CMakeLists.txt

	eapply_user
}

#src_configure() {
#	mycmakeargs+=( "-DINSTALL:BOOLEAN=ON" )
#	cmake-utils_src_configure
#}

#src_prepare() {
#	sed \
#		-e '/ggo/s:CMAKE_CURRENT_SOURCE_DIR}:CMAKE_BINARY_DIR}/src:g' \
#		-i src/CMakeLists.txt || die
#	cmake-utils_src_prepare
#}


#src_install() {
#	cmake-utils_src_install
	#byte-complation fix
#	python_optimize
#}
