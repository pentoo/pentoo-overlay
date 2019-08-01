# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#Gopkg.lock
EGO_VENDOR=(
	"github.com/bogdanovich/dns_resolver a8e42bc6a5b6c9a93be01ca204be7e17f7ba4cd2"
	"github.com/miekg/dns 5a2b9fab83ff0f8bfc99684bd5f43a37abe560f1"
	"github.com/subfinder/urlx 8e731c8be06edbae81cab15937cd3c291c2a7680"
)

EGO_PN=github.com/subfinder/subfinder

inherit golang-build golang-vcs-snapshot

EGIT_COMMIT="357c3403ef3528c5b1883ce17a04389a76644de9"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz ${EGO_VENDOR_URI}"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

DESCRIPTION="subdomain discovery tool that discovers valid subdomains for websites"
HOMEPAGE="https://github.com/subfinder/subfinder"
LICENSE="MIT"
SLOT=0
IUSE=""
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

DEPEND=">=dev-lang/go-1.10
	dev-go/go-crypto
	dev-go/go-net
"
RDEPEND=""

src_install(){
	dobin subfinder
}
