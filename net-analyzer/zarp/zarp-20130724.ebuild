# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

PYTHON_COMPAT=( python2_{6,7} )
inherit git-2 multilib python-r1

HOMEPAGE="https://defense.ballastsecurity.net/wiki/index.php/Zarp"
DESCRIPTION="Local network attack toolkit"
EGIT_REPO_URI="https://github.com/hatRiot/zarp.git"
EGIT_COMMIT="ef1e8398cdd27e1b0a6ab2292fd037bf859c695f"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
