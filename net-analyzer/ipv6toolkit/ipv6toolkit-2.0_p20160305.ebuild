# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-2 eutils

DESCRIPTION="Set of IPv6 security/trouble-shooting tools to send arbitrary IPv6-based packets"
HOMEPAGE="http://www.si6networks.com/tools/ipv6toolkit/"
EGIT_REPO_URI="https://github.com/fgont/ipv6toolkit.git"
EGIT_COMMIT="98749ce154dd66f263b13190be72bf9faf778960"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libpcap[ipv6]"
RDEPEND="${DEPEND}
	sys-apps/hwids"

HWIDS_OUI_PATH=/usr/share/misc/oui.txt
SNPN_PATH=/usr/share/ipv6toolkit/service-names-port-numbers.csv

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0-oui-snpn-path.patch
	cd "${S}"
	sed -i "s,/usr/share/[^[:space:]\"']*/?oui.txt,${HWIDS_OUI_PATH},g" \
		manuals/ipv6toolkit.conf.5 \
		|| die "failed to sed out oui path"
}

src_compile() {
	emake CFLAGS="-Wall ${CFLAGS}" OUI_DATABASE="${HWIDS_OUI_PATH}" SNPN_PATH="${SNPN_PATH}" PREFIX=/usr
}

src_install() {
	dodir /etc
	emake install DESTDIR="${D}" OUI_DATABASE="${HWIDS_OUI_PATH}" SNPN_PATH="${SNPN_PATH}" PREFIX=/usr
	rm -f "${D}"/usr/share/ipv6toolkit/oui.txt
	rmdir "${D}"/usr/share/ipv6toolkit
	dodoc CHANGES.TXT README*
}
