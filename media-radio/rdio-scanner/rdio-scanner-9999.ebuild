# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION=""
HOMEPAGE=""
EGIT_REPO_URI="https://github.com/chuot/rdio-scanner.git"
EGIT_BRANCH="v6-beta"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="doc"

DEPEND="doc? ( app-text/pandoc )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	addpredict /etc/npm
	if ! use doc; then
		sed -i '/pandoc/d' Makefile
	fi
	use amd64 && emake linux-amd64
	use x86 && emake linux-386
	use arm64 && emake linux-arm64
	use arm && emake linux-arm
}
