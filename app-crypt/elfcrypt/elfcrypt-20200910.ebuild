# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A Simple ELF crypter"
HOMEPAGE="https://github.com/droberson/ELFcrypt"

HASH_COMMIT="1699e97e07ac3d82e7845dc3e0eb8f35a8bf886d"

SRC_URI="https://github.com/droberson/ELFcrypt/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/ELFcrypt-${HASH_COMMIT}"

IUSE="examples"
LICENSE="MIT"
SLOT="0"

src_prepare() {
	sed -e "s/gcc/$(tc-getCC)/" \
		-e "s/-o ELFcrypt/${CFLAGS} -o ELFcrypt/" \
		-e "s/-o ELFcrypt2/${CFLAGS} -o ELFcrypt2/" \
		-e "s/^\(all:.*\)example/\1/" \
		-i Makefile || die

	default
}

src_install() {
	doheader ELFcrypt.h
	dobin ELFcrypt
	dobin ELFcrypt2
	dodoc README.md
	if use examples; then
		dodoc example.c
		docompress -x /usr/share/doc/${PF}/example.c
	fi
}
