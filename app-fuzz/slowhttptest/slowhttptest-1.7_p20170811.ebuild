# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Application Layer DoS attack simulator"
HOMEPAGE="https://github.com/shekyan/slowhttptest"
COMMIT="28a863e3128df1a5d717240cbc07eec8f6f352dd"
SRC_URI="https://github.com/shekyan/slowhttptest/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

DEPEND="dev-libs/openssl:="
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}-${COMMIT}"

src_prepare() {
	eapply "${FILESDIR}"/1.4-add-includes.patch
	eapply_user
}

src_install() {
	dobin src/slowhttptest
}
