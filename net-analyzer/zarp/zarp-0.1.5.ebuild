# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI="5"

PYTHON_COMPAT=( python2_{6,7} )
inherit multilib python-r1

HOMEPAGE="https://defense.ballastsecurity.net/wiki/index.php/Zarp"
DESCRIPTION="Local network attack toolkit"
SRC_URI="https://github.com/hatRiot/zarp/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+wireless"

DEPEND=""
RDEPEND="dev-python/paramiko
	dev-python/netlib
	dev-python/flask
	net-analyzer/scapy
	net-analyzer/tcpdump
	net-libs/nfqueue-bindings
	wireless? ( net-wireless/aircrack-ng )"

# TODO: unbundle the following:
# rm Wifite
# rm Scapy
# libmproxy (netlib, flask)

src_install() {
	# should be as simple as copying everything into the target...
	dodir /usr/$(get_libdir)/${PN}
	cp -R "${S}"/* "${D}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	rm -Rf "${D}"/usr/$(get_libdir)/${PN}/README
	dosbin "${FILESDIR}"/zarp
}
