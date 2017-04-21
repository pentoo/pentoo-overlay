# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Application Layer DoS attack simulator"
HOMEPAGE="https://github.com/shekyan/slowhttptest"
SRC_URI="https://github.com/shekyan/slowhttptest/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=" ~arm amd64 x86"
IUSE=""

DEPEND="dev-libs/openssl:="
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/1.4-add-includes.patch
	eapply_user
}

src_install() {
	dobin src/slowhttptest
}
