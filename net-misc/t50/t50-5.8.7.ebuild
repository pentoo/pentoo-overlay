# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Mixed Packet Injector & Network Stress Testing Tool"
HOMEPAGE="https://github.com/merces/t50"

HASH_COMMIT="7e204662dacf0dcd46fd9a0b853efb72f2ce6c91"
SRC_URI="https://gitlab.com/fredericopissarra/t50/-/archive/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-v${PV}-${HASH_COMMIT}

src_prepare() {
	#Fix broken Makefile
	sed -i "s|STRIP=-s|STRIP=|" Makefile || die
	sed -i "s|\$(CFLAGS)|\$(CFLAGS) \$(LDFLAGS)|" Makefile || die
	eapply_user
}

src_install() {
	#It's easy to re-write the install script
#	emake DESTDIR="${D}" install
	dosbin bin/${PN}
	doman doc/t50.8
}
