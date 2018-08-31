# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN=github.com/OJ/${PN}

inherit golang-build

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~x86 ~arm ~arm64"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi

DESCRIPTION="A tool to brute-force URIs and DNS subdomains."
HOMEPAGE="https://github.com/OJ/gobuster"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/go-1.10
		dev-go/go-crypto
		dev-go/go-multierror
		>=dev-go/go-uuid-0.2"
DEPEND="${RDEPEND}"

src_install(){
	dobin gobuster
}
