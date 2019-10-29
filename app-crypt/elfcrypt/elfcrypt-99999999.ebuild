# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A Simple ELF crypter"
HOMEPAGE="https://github.com/droberson/ELFcrypt"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/droberson/ELFcrypt"
else
	HASH_COMMIT="340873de5547857e37e0fc48e8fea5a8c6a04b77"

	SRC_URI="https://github.com/droberson/ELFcrypt/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/ELFcrypt-${HASH_COMMIT}"
fi

LICENSE="MIT"
SLOT="0"

src_prepare() {
	sed -e "s/gcc/$(tc-getCC)/" \
		-e "s/-o ELFcrypt2/${CFLAGS} -o ELFcrypt2/" \
		-i Makefile || die

	default
}

src_install() {
	dobin ELFcrypt
	dodoc README.md
}
