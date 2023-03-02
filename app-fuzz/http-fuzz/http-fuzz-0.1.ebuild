# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuzz/http-fuzz/http-fuzz-0.1.ebuild,v 1.1.1.1 2006/03/08 21:22:06 grimmlin Exp $

EAPI=8

DESCRIPTION="A http fuzzer"
HOMEPAGE="none"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# required by Portage, as we have no SRC_URI...
S="${WORKDIR}"

src_install() {
        newbin "${FILESDIR}/${PN}".pl "${PN}"

}
