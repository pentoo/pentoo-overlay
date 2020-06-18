# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN=github.com/OJ/${PN}

# go mod vendor && grep "# g" ./vendor/modules.txt | sort
EGO_VENDOR=(
	"github.com/google/uuid v1.1.1"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/spf13/cobra v0.0.4"
	"github.com/spf13/pflag v1.0.3"
	"golang.org/x/crypto 22d7a77e9e5f github.com/golang/crypto"
	"golang.org/x/sys abf6ff778158 github.com/golang/sys"
)

inherit golang-build golang-vcs-snapshot

SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

DESCRIPTION="A tool to brute-force URIs and DNS subdomains"
HOMEPAGE="https://github.com/OJ/gobuster"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"

DEPEND=">=dev-lang/go-1.10"
RDEPEND="${DEPEND}"

src_install() {
	dobin gobuster
}
