# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo git-r3

DESCRIPTION="The fastest and cross-platform subdomain enumerator, don't waste your time"
HOMEPAGE="https://github.com/Edu4rdSHL/findomain"
EGIT_REPO_URI="https://github.com/Edu4rdSHL/findomain"

LICENSE="GPL-3"
SLOT="0"

BDEPEND=">=virtual/rust-1.40.0"

src_unpack() {
	if [[ ${PV} == *9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_prepare() {
	if [[ ${PV} != *9999 ]]; then
		sed -e "s/^version: \"\(.*\)\"/version: \"${PV}\"/" \
			-i src/cli.yml || die
	fi

	default
}

src_install() {
	dobin target/release/findomain

	doman findomain.1
	dodoc -r docs/* README.md
}
