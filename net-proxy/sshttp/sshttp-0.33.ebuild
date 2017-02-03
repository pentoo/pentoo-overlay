# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="an easy to use OSI-Layer5 switching daemon"
HOMEPAGE="http://c-skills.blogspot.com/"
WEIRD_TAG="sshttp-0-33s"
SRC_URI="https://github.com/stealth/sshttp/archive/${WEIRD_TAG}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${WEIRD_TAG}"

src_prepare() {
	eapply_user
	sed -i "s|-O2|$CFLAGS|g" Makefile || die
}

src_compile() {
	einfo "This is about to die due to https://github.com/stealth/sshttp/issues/7"
	default
}

src_install() {
	dobin sshttpd || die
	dodoc README || die
	dobin nf-setup || die
}
