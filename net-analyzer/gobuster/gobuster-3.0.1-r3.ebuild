# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN=github.com/OJ/${PN}

# go mod vendor && grep "# g" ./vendor/modules.txt | sort
EGO_VENDOR=(
# github.com/google/uuid v1.1.1
	"github.com/inconshreveable/mousetrap v1.0.0"
# github.com/spf13/cobra v0.0.4
# github.com/spf13/pflag v1.0.3
	"golang.org/x/crypto 22d7a77e9e5f github.com/golang/crypto"
	"golang.org/x/sys abf6ff778158 github.com/golang/sys"
)

inherit golang-build

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	inherit golang-vcs-snapshot
	KEYWORDS="~amd64 ~x86 ~arm ~arm64"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"
fi

DESCRIPTION="A tool to brute-force URIs and DNS subdomains"
HOMEPAGE="https://github.com/OJ/gobuster"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-go/uuid-1.1.1
	>=dev-go/cobra-0.0.4
	>=dev-lang/go-1.10"
RDEPEND=""

src_install() {
	dobin gobuster
}
