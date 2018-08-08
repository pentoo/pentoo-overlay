# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Small set of tools to generate plainmasterkeys (rainbowtables) and hashes for the use with latest hashcat and John the Ripper"
HOMEPAGE="https://github.com/ZerBea/hcxkeys"
MY_COMMIT="39fdb0133cb2d1727cb8669c3f661f93d4cd4952"
SRC_URI="https://github.com/ZerBea/hcxkeys/archive/${MY_COMMIT}.tar.gz -> ${PN}-{MY_COMMIT}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="dev-libs/openssl:*
	sys-libs/zlib
	net-misc/curl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_prepare() {
	sed -i "s#-O3 -Wall -Wextra#${CFLAGS} ${LDFLAGS}#" Makefile || die
	default
}

src_install(){
	dobin wlangenpmk
	dobin wlangenpmkocl
	dobin pwhash
}
