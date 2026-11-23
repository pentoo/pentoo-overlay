# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenPGP key used for Pentoo releases (binpkgs on the Pentoo binhost)"
HOMEPAGE="https://www.pentoo.org"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

src_install() {
	insinto /usr/share/openpgp-keys
	doins "${FILESDIR}"/pentoo-release.asc
}
