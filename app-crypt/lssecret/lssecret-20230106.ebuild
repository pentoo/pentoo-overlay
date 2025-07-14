# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

HASH_COMMIT="7f63780a8621305a8cc5e0455a603654e472fd30"

DESCRIPTION="List all secret items using libsecret (e.g. GNOME Keyring)."
HOMEPAGE="https://github.com/gileshuang/lssecret"
SRC_URI="https://github.com/gileshuang/lssecret/archive/${HASH_COMMIT}.tar.gz -> ${PN}.gh.tar.gz"
S="${WORKDIR}/${PN}-${HASH_COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

DEPEND="app-crypt/libsecret
	dev-libs/glib"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-makefile-changes.patch" )

src_compile() {
	emake CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"
}

#src_install() {
#	emake DESTDIR="${D}/usr" install
#	einstalldocs
#}
