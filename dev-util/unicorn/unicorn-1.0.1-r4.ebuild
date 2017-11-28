# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit multilib distutils-r1

DESCRIPTION="A lightweight multi-platform, multi-architecture CPU emulator framework"
HOMEPAGE="http://www.unicorn-engine.org"
SRC_URI="https://github.com/unicorn-engine/unicorn/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~m68k ~arm ~arm64 ~mips ~sparc"
IUSE="python static-libs"

IUSE_UNICORN_TARGETS="x86 m68k arm aarch64 mips sparc"
use_unicorn_targets=$(printf ' unicorn_targets_%s' ${IUSE_UNICORN_TARGETS})
IUSE+=" ${use_unicorn_targets}"

DEPEND="dev-libs/glib:2
	${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	virtual/pkgconfig"
PDEPEND="dev-libs/unicorn-bindings[python?]"

REQUIRED_USE="|| ( ${use_unicorn_targets} )"

src_configure(){
	local target
	unicorn_softmmu_targets=""

	for target in ${IUSE_UNICORN_TARGETS} ; do
		if use "unicorn_targets_${target}"; then
			unicorn_targets+="${target} "
		fi
	done

	#the following variable is getting recreated using UNICORN_ARCHS below
	UNICORN_TARGETS=""
}

src_compile() {
	UNICORN_ARCHS="${unicorn_targets}" UNICORN_STATIC="$(use static-libs && echo yes || echo no)" ./make.sh
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" UNICORN_STATIC="$(use static-libs && echo yes || echo no)" install
}
