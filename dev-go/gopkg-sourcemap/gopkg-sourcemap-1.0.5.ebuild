# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="gopkg.in/sourcemap.v1"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
	KEYWORDS=""
else
	KEYWORDS="amd64 arm64 x86"
	SRC_URI="https://github.com/go-sourcemap/sourcemap/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi

inherit golang-build

DESCRIPTION="Source maps consumer for Golang"
HOMEPAGE="https://godoc.org/github.com/go-sourcemap/sourcemap"

LICENSE="BSD-2"
SLOT="0"
IUSE=""

RDEPEND=">=dev-lang/go-1.10"
DEPEND="${RDEPEND}"
