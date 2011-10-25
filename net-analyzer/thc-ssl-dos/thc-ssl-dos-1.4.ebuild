# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

DESCRIPTION="THC-SSL-DOS is a tool to verify the performance of SSL servers"
HOMEPAGE="http://www.thc.org"
SRC_URI="http://www.thc.org/thc-ssl-dos/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="dev-libs/openssl"

src_install() {
	dobin src/$PN || die "installation failed"
}
