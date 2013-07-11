# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

PYTHON_DEPEND="2"

inherit git-2 multilib python

HOMEPAGE="https://defense.ballastsecurity.net/wiki/index.php/Zarp"
DESCRIPTION="Local network attack toolkit"
EGIT_REPO_URI="https://github.com/hatRiot/zarp.git"
EGIT_COMMIT="c3926ce003534b7d8cbf88cc2766739650364c3f"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="wireless"

DEPEND=""
RDEPEND="dev-python/paramiko
	net-analyzer/scapy
	net-analyzer/tcpdump
	wireless? ( net-wireless/aircrack-ng )"
#nfqueue-bindings (packet modifier)

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
	# TODO
	# rm Wifite
	# rm Scapy
}

src_install() {
	# should be as simple as copying everything into the target...
	dodir /usr/$(get_libdir)/${PN}
	cp -R "${S}"/* "${D}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	rm -Rf "${D}"/usr/$(get_libdir)/${PN}/README
#	chown -R root:0 "${D}"
	dosbin "${FILESDIR}"/zarp
# ${MY_P}
}
