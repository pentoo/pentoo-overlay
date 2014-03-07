# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="Mass IP port scanner"
HOMEPAGE="https://github.com/robertdavidgraham/masscan"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="pf_ring"

RDEPEND="net-libs/libpcap
	pf_ring? ( sys-kernel/pf_ring-kmod )"
DEPEND="${RDEPEND}"

src_prepare(){
	sed -i \
		-e '/$(CC)/s!$(CFLAGS)!$(LDFLAGS) $(CFLAGS)!g' \
		-e "/^GITVER :=/s!= .(.*!=!g" \
		-e '/$(CC)/s!-DGIT=\"$(GITVER)\"!!g' \
		-e '/^CFLAGS =/{s,=,+=,;s,-g -ggdb,,;s,-O3,,;}' \
		Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake install DESTDIR="${D}" PREFIX=/usr

	insinto /etc/masscan
	doins data/exclude.conf
	doins "${FILESDIR}"/masscan.conf

	[ -f doc/bot.hml ] && mv doc/bot.{hml,html}
	dohtml doc/bot.html
	doman doc/masscan.8
	dodoc *.md
}

pkg_postinst() {
	if ! use pf_ring; then
		ewarn "You have compiled without pf_ring flag being enabled"
		ewarn "To get beyond 2 million packets/second, you need an Intel 10-gbps"
		ewarn "Ethernet adapter and a special driver known as PF_RING DNA"
		ewarn "from http://www.ntop.org/products/pf_ring/ "
	fi
}
