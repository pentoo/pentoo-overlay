# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A bruteforce cracker for openssl encrypted files"
HOMEPAGE="https://github.com/glv2/bruteforce-salted-openssl"
SRC_URI="https://github.com/glv2/bruteforce-salted-openssl/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

DEPEND="dev-libs/openssl:*"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	default
}
