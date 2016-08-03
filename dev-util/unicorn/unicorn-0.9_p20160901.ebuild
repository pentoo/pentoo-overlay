# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="A lightweight multi-platform, multi-architecture CPU emulator framework"
HOMEPAGE="http://www.unicorn-engine.org"
#SRC_URI="https://github.com/unicorn-engine/unicorn/archive/${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/unicorn-engine/unicorn.git"
EGIT_COMMIT="7b47ab6b667f8959cbfe149fc67de7cfcd0bcf54"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~m68k ~arm ~arm64 ~mips ~sparc"

IUSE_UNICORN_TARGETS="x86 m68k arm aarch64 mips sparc"
use_unicorn_targets=$(printf ' unicorn_targets_%s' ${IUSE_UNICORN_TARGETS})
IUSE+=" ${use_unicorn_targets}"

DEPEND="dev-libs/glib:2"
RDEPEND="${DEPEND}
	virtual/pkgconfig"

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
	#UNICORN_QEMU_FLAGS="--python=/path/to/python2" ./make.sh
	#use amd64 && UNICORN_ARCHS="arm x86" UNICORN_STATIC="no"  ./make.sh
	UNICORN_ARCHS="${unicorn_targets}" UNICORN_STATIC="no" ./make.sh
}
