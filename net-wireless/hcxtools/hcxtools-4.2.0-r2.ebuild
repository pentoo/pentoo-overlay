# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Portable solution for capturing wlan traffic and conversion to hashcat formats"
HOMEPAGE="https://github.com/ZerBea/hcxtools"
MY_COMMIT="a093979688d0444bbd2cf8b9686ca11608c4e8d6"
SRC_URI="https://github.com/ZerBea/hcxtools/archive/${MY_COMMIT}.tar.gz -> ${PN}-{MY_COMMIT}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="dev-libs/openssl:*
	sys-libs/zlib
	net-misc/curl
	net-libs/libpcap:="
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_prepare() {
	sed -i "s#-O3 -Wall -Wextra#${CFLAGS} ${LDFLAGS}#" Makefile || die
	default
}

src_install(){
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
