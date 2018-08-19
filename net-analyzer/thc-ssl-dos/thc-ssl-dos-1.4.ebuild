# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="THC-SSL-DOS is a tool to verify the performance of SSL servers"
HOMEPAGE="https://github.com/vanhauser-thc"
SRC_URI="https://github.com/vanhauser-thc/THC-Archive/raw/master/Exploits/thc-ssl-dos-1.4.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="dev-libs/openssl"

src_install() {
	dobin src/$PN || die "installation failed"
}
