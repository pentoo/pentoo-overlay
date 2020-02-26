# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="Remote packet capture daemon"
HOMEPAGE="https://www.winpcap.org/devel.htm"
SRC_URI="https://www.winpcap.org/install/bin/WpcapSrc_$(ver_rs 1-2 _).zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"/winpcap/wpcap/libpcap

src_prepare() {
	# https://bugs.gentoo.org/426262
	#rm configure && mv configure.in configure.ac || die

	#eautoreconf
	chmod +x configure || die
	eapply_user
}

src_compile() {
	strip-flags

	emake CCOPT="${CFLAGS} ${LDFLAGS}"

	pushd "rpcapd" > /dev/null || die
	emake CFLAGS="${CFLAGS} -pthread -DHAVE_REMOTE -DHAVE_SNPRINTF ${LDFLAGS}"
	popd > /dev/null
}

src_install() {
	dosbin rpcapd/rpcapd
}
