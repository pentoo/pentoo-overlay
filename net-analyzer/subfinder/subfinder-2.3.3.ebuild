# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/projectdiscovery/subfinder"

#Generated using the following:
#go mod init github.com/projectdiscovery/subfinder
#go mod vendor && grep "# g" ./vendor/modules.txt | sort > /tmp/subfinder_deps
EGO_VENDOR=(
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/json-iterator/go v1.1.8"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.2"
	"github.com/lib/pq v1.5.2"
	"github.com/logrusorgru/aurora e9ef32dff381"
	"github.com/miekg/dns v1.1.22"
	"github.com/m-mizutani/urlscan-go v1.0.0"
	"github.com/modern-go/concurrent bacd9c7ef1dd"
	"github.com/modern-go/reflect2 4b7aa43c6742"
	"github.com/pkg/errors v0.8.1"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/projectdiscovery/gologger v1.0.0"
	"github.com/rs/xid v1.2.1"
	"github.com/sirupsen/logrus v1.4.2"
	"github.com/stretchr/testify v1.5.1"
	"golang.org/x/crypto 86a70503ff7e github.com/golang/crypto"
	"golang.org/x/net 5ee1b9f4859a github.com/golang/net"
	"golang.org/x/sys ce4227a45e2e github.com/golang/sys"
	"gopkg.in/yaml.v2 v2.2.7 github.com/go-yaml/yaml"
	"gopkg.in/yaml.v3 4206685974f2 github.com/go-yaml/yaml"
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

BDEPEND=">=dev-lang/go-1.13.6"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-w -X main.version=${PV}" ./... || die
}

src_install(){
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-w -X main.version=${PV}" ./... || die

	dobin bin/subfinder
	dodoc "src/${EGO_PN}"/{config.yaml,*.md,Dockerfile}
}
