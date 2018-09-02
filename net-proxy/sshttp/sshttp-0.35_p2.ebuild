# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="an easy to use OSI-Layer5 switching daemon"
HOMEPAGE="http://c-skills.blogspot.com/"
MY_PV=${PV/./-}
MY_P="${PN}-splice-${MY_PV/_p/s}"
SRC_URI="https://github.com/stealth/sshttp/archive/${MY_P}.tar.gz -> ${P}.tar.gz"

#sshttp-splice-0-35s2.tar.gz

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_P}"

src_prepare() {
	sed -i "s|-O2|$CFLAGS|g" Makefile || die
	eapply_user
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
