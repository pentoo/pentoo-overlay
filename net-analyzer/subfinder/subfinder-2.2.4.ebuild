# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#Gopkg.lock
#go mod init github.com/subfinder/subfinder
#extracted from 'go mod vendor' -> grep "# g" ./vendor/modules.txt | sort file
EGO_VENDOR=(
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/json-iterator/go v1.1.8"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.2"
	"github.com/logrusorgru/aurora 21d75270181e"
	"github.com/miekg/dns v1.1.22"
	"github.com/m-mizutani/urlscan-go v1.0.0"
	"github.com/modern-go/concurrent bacd9c7ef1dd"
	"github.com/modern-go/reflect2 4b7aa43c6742"
	"github.com/pkg/errors v0.8.1"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/projectdiscovery/subfinder v2.2.3"
	"github.com/rs/xid v1.2.1"
	"github.com/sirupsen/logrus v1.4.2"
	"github.com/stretchr/testify v1.4.0"
#	"golang.org/x/crypto v0.0.0-20191202143827-86a70503ff7e"
#	"golang.org/x/net v0.0.0-20191204025024-5ee1b9f4859a"
#	"golang.org/x/sys v0.0.0-20191204072324-ce4227a45e2e"
	"gopkg.in/yaml.v2 v2.2.7 github.com/go-yaml/yaml"
	"gopkg.in/yaml.v3 4206685974f2 github.com/go-yaml/yaml"

)

EGO_PN=github.com/subfinder/subfinder

inherit golang-build golang-vcs-snapshot

EGIT_COMMIT="v${PV}"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz ${EGO_VENDOR_URI}"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

DESCRIPTION="subdomain discovery tool that discovers valid subdomains for websites"
HOMEPAGE="https://github.com/subfinder/subfinder"
LICENSE="MIT"
SLOT=0
IUSE=""
KEYWORDS="~amd64 ~arm ~x86"

DEPEND=">=dev-lang/go-1.10
	dev-go/go-crypto
	dev-go/go-net
	dev-go/go-sys"
RDEPEND=""

S=${WORKDIR}/${P}/src/${EGO_PN}

src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go build -ldflags="-X main.version=${PV}" -o "subfinder" ./cmd/subfinder/main.go || die
}

src_install(){
	dobin subfinder
}
