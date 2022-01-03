# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV=${PV/_/-}

DISTUTILS_OPTIONAL=1
PYTHON_COMPAT=( python3_{9..10} )
inherit cmake multilib distutils-r1

DESCRIPTION="A lightweight multi-platform, multi-architecture CPU emulator framework"
HOMEPAGE="http://www.unicorn-engine.org"
SRC_URI="https://github.com/unicorn-engine/unicorn/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

IUSE_UNICORN_TARGETS="x86 arm aarch64 riscv mips sparc m68k ppc"

use_unicorn_targets=$(printf ' unicorn_targets_%s' ${IUSE_UNICORN_TARGETS})
IUSE="python ${use_unicorn_targets} static-libs"

REQUIRED_USE="|| ( ${use_unicorn_targets} )
	python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="dev-libs/glib:2
	virtual/pkgconfig
	${PYTHON_DEPS}"
RDEPEND="python? ( ${PYTHON_DEPS} )"

S="${WORKDIR}/${PN}-${MY_PV}"

wrap_python() {
	if use python; then
		#src_prepare
		#do not compile C extensions
		export LIBUNICORN_PATH=1

		pushd bindings/python >/dev/null || die
		distutils-r1_${1} "$@"
		popd >/dev/null
	fi
}

src_prepare() {
	#build from sources
	rm -r bindings/python/prebuilt || die "failed to remove prebuild"
	cmake_src_prepare
	wrap_python ${FUNCNAME}
}

src_configure(){
	local target
	for target in ${IUSE_UNICORN_TARGETS} ; do
		if use "unicorn_targets_${target}"; then
			unicorn_targets+="${target} "
		fi
	done

	#the following variable is getting recreated using UNICORN_ARCHS below
#	UNICORN_TARGETS=""

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DUNICORN_BUILD_SHARED="$(usex static-libs OFF ON)"
		-DUNICORN_ARCH="${unicorn_targets}"
	)
	cmake_src_configure
	wrap_python ${FUNCNAME}
}

src_compile() {
#	export CC INSTALL_BIN PREFIX PKGCFGDIR LIBDIRARCH LIBARCHS CFLAGS LDFLAGS
#	UNICORN_ARCHS="${unicorn_targets}" \
#		UNICORN_STATIC="$(use static-libs && echo yes || echo no)" \
#		UNICORN_DEBUG="$(use debug && echo yes || echo no)" \
#		emake V=s

	cmake_src_compile
	wrap_python ${FUNCNAME}
}

#src_test() {
#	default
#	wrap_python ${FUNCNAME}
#}

src_install() {
#	emake \
#		UNICORN_ARCHS="${unicorn_targets}" \
#		DESTDIR="${D}" \
#		LIBDIR="/usr/$(get_libdir)" \
#		UNICORN_STATIC="$(use static-libs && echo yes || echo no)" \
#		install

	cmake_src_install

	wrap_python ${FUNCNAME}
}
