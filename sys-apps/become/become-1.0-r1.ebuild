# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="utility for changing the current real, effective or group id"
HOMEPAGE="http://www.bindshell.net/tools/become"
SRC_URI="http://www.bindshell.net/tools/become/become.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/$PN

src_prepare() {
	sed -i "s|-g|$CFLAGS|g" Makefile || die "sed failed"
	epatch "${FILESDIR}"/become-maxuid.patch || die "patch failed"
}

src_install() {
	dosbin become || die "failed to install become"
	doman become.8 || die "failed to install manpage"
}
