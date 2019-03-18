# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/go-sourcemap/sourcemap gopkg.in/sourcemap.v1"

#EGO_PN="gopkg.in/sourcemap.v1 github.com/go-sourcemap/sourcemap"

#EGO_VENDOR=(
#	"gopkg.in/sourcemap.v1"
#	"gopkg.in/sourcemap.v1 6e83acea0053641eff084973fee085f0c193c61a github.com/go-sourcemap/sourcemap"
#	"github.com/go-sourcemap/sourcemap"
#)

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
#https://bugs.gentoo.org/673704
#	KEYWORDS="~amd64 ~x86 ~arm ~arm64"
#	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://github.com/go-sourcemap/sourcemap/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi

inherit golang-build

DESCRIPTION="Source maps consumer for Golang"
HOMEPAGE="https://godoc.org/github.com/go-sourcemap/sourcemap"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/go-1.10"
DEPEND="${RDEPEND}"
