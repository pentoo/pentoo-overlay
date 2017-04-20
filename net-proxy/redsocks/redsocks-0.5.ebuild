# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Transparent redirector of any TCP connection to proxy"
HOMEPAGE="http://darkk.net.ru/redsocks/"
SRC_URI="https://github.com/darkk/${PN}/archive/release-${PV}.tar.gz -> ${P}.tar.gz"
#         https://github.com/darkk/redsocks/archive/release-0.5.tar.gz

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="dev-libs/libevent
	net-firewall/iptables"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

S="${WORKDIR}"/"${PN}"-release-"${PV}"

#src_compile() {
#	emake
#}

src_install() {
	dobin redsocks
	dodoc README doc/*
	insinto /etc/redsocks
	newins redsocks.conf.example redsocks.conf
}
