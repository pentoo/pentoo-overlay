# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A brute force program that works against pptp vpn endpoints"
HOMEPAGE="https://www.thc.org"
SRC_URI="https://github.com/vanhauser-thc/THC-Archive/raw/master/Tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/openssl:0="
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${P/thc/THC}

src_prepare() {
	# TODO: please test me!
	eapply "${FILESDIR}"/add_a_new_openssl_API_support.patch

	sed -i "s|-O2|${CFLAGS}|g" configure.in || die "sed failed"
	mv configure.in configure.ac || die

	eautoreconf
	default
}

src_install() {
	dobin src/$PN
	dodoc README TODO
}
