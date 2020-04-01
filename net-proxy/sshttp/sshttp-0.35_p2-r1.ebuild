# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="An easy to use OSI-Layer5 switching daemon"
HOMEPAGE="https://c-skills.blogspot.com/"

MY_PV=${PV/./-}
MY_P="${PN}-splice-${MY_PV/_p/s}"
SRC_URI="https://github.com/stealth/sshttp/archive/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_P}"

src_prepare() {
	default
	sed -i "/^CFLAGS/s|-O2|${CFLAGS}|g" Makefile || die
}

src_compile() {
	emake CXX=$(tc-getCXX) LD=$(tc-getLD)
}

src_install() {
	dobin sshttpd
	dodoc *.md Changelog HINTS

	exeinto /usr/share/${PN}
	doexe nf-setup
}
