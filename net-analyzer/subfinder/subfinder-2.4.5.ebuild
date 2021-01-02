# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/projectdiscovery/subfinder"

# go mod vendor && grep "# g" ./vendor/modules.txt | sort
EGO_VENDOR=(
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/hako/durafmt c0fb7b4da026"
	"github.com/json-iterator/go v1.1.10"
	"github.com/lib/pq v1.8.0"
	"github.com/logrusorgru/aurora v2.0.3"
	"github.com/miekg/dns v1.1.31"
	"github.com/modern-go/concurrent bacd9c7ef1dd"
	"github.com/modern-go/reflect2 v1.0.1"
	"github.com/pkg/errors v0.9.1"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/projectdiscovery/chaos-client v0.1.6"
	"github.com/projectdiscovery/fdmax v0.0.2"
	"github.com/projectdiscovery/gologger v1.0.1"
	"github.com/rs/xid v1.2.1"
	"github.com/stretchr/testify v1.5.1"
	"github.com/tomnomnom/linkheader 02ca5825eb80"
	"golang.org/x/crypto 5c72a883971a github.com/golang/crypto"
	"golang.org/x/net 05aa5d4ee321 github.com/golang/net"
	"golang.org/x/sys d9f96fdee20d github.com/golang/sys"
	"gopkg.in/yaml.v2 v2.2.2 github.com/go-yaml/yaml"
	"gopkg.in/yaml.v3 eeeca48fe776 github.com/go-yaml/yaml"
)

inherit golang-vcs-snapshot

DESCRIPTION="A subdomain discovery tool that discovers valid subdomains for websites"
HOMEPAGE="https://github.com/projectdiscovery/subfinder"

SRC_URI="https://github.com/projectdiscovery/subfinder/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MIT"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"

RESTRICT="mirror"

BDEPEND="dev-lang/go"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-w -X main.version=${PV}" ./... || die
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-w -X main.version=${PV}" ./... || die

	dobin bin/subfinder
	dodoc "src/${EGO_PN}"/{*.md,Dockerfile}
}
