# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils toolchain-funcs flag-o-matic

NASSL_PV="0.14.1"
DESCRIPTION="Fast SSL configuration scanner"
HOMEPAGE="https://github.com/rbsec/sslscan"
MY_FORK="rbsec"
SRC_URI="https://github.com/${MY_FORK}/${PN}/archive/${PV}-${MY_FORK}.tar.gz -> ${P}-${MY_FORK}.tar.gz
	static? ( https://github.com/nabla-c0d3/nassl/archive/${NASSL_PV}.tar.gz  -> nassl-${NASSL_PV}.tar.gz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+static"

# Depend on -bindist since sslscan unconditionally requires elliptic
# curve support, bug 491102
DEPEND="!static? ( dev-libs/openssl:0[-bindist] )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-${MY_FORK}"

src_prepare() {
	default
	if use static; then
		#hack: copy compiled librarys from NASSL/SSLYZE project
		mkdir -p ./openssl/include/openssl/
		cp "${WORKDIR}"/nassl-"${NASSL_PV}"/bin/openssl/include/openssl/* ./openssl/include/openssl/
		if use amd64; then
			cp "${WORKDIR}"/nassl-"${NASSL_PV}"/bin/openssl/linux64/* ./openssl
			cp "${WORKDIR}"/nassl-"${NASSL_PV}"/bin/zlib/linux64/libz.a ./openssl/
		fi
		if use x86; then
			cp "${WORKDIR}"/nassl-"${NASSL_PV}"/bin/openssl/linux32/* ./openssl
			cp "${WORKDIR}"/nassl-"${NASSL_PV}"/bin/zlib/linux32/libz.a ./openssl/
		fi
		#hack: use provided binaries
		sed -i "s|static opensslpull|static|g" Makefile
		sed -i "s|static: openssl/libcrypto.a|static:|g" Makefile
	fi
}

src_compile() {
	append-ldflags -Wl,-z,noexecstack

	if use static; then
		emake static
	else
		emake
	fi
}

src_install() {
	DESTDIR="${D}" emake install
	dodoc Changelog README.md
}
