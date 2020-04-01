# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A Simple ELF crypter"
HOMEPAGE="https://github.com/droberson/ELFcrypt"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/droberson/ELFcrypt"
else
	HASH_COMMIT="f3c0121dc153d49756403cad83cbd160933edf78"

	SRC_URI="https://github.com/droberson/ELFcrypt/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/ELFcrypt-${HASH_COMMIT}"
fi

LICENSE="MIT"
SLOT="0"

src_prepare() {
	sed -e "s/gcc/$(tc-getCC)/" \
		-e "s/-o ELFcrypt2/${CFLAGS} -o ELFcrypt2/" \
		-e "s/^\(all:.*\)example/\1/" \
		-i Makefile || die

	default
}

src_install() {
	dobin ELFcrypt
	dodoc README.md
}
