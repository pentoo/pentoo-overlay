# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit flag-o-matic

DESCRIPTION="Remote packet capture daemon"
HOMEPAGE="http://www.winpcap.org/devel.htm"
SRC_URI="http://www.winpcap.org/install/bin/WpcapSrc_4_1_2.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"/winpcap/wpcap/libpcap

src_prepare() { 
	fperms +x configure runlex.sh
}

src_compile() {
	strip-flags
	make CCOPT="${CFLAGS} ${LDFLAGS}"
	cd rpcapd
	emake CFLAGS="${CFLAGS} -pthread -DHAVE_REMOTE -DHAVE_SNPRINTF ${LDFLAGS}"
}

src_install() {
	dosbin rpcapd/rpcapd
}
