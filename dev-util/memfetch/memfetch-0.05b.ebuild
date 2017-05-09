# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A simple utility to dump all memory of a running process"
HOMEPAGE="http://lcamtuf.coredump.cx/"
SRC_URI="http://lcamtuf.coredump.cx/soft/${PN}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -e "s:asm/page:sys/user:" -i memfetch.c || die "sed failed"
	eapply_user
}

#src_compile() {
#	emake || die "Compile failed"
#}

src_install() {
	dobin memfetch mffind.pl
	dodoc README
}
