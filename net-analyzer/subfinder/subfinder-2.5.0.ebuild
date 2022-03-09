# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/projectdiscovery/subfinder"

# go mod vendor && grep "# g" ./vendor/modules.txt | sort
EGO_VENDOR=(
	"github.com/andres-erbsen/clock 9e14626cd129"
	"github.com/cnf/structhash e1b16c1ebc08"
	"github.com/corpix/uarand v0.1.1"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/hako/durafmt 3a2c319c1acd"
	"github.com/json-iterator/go v1.1.10"
	"github.com/karrick/godirwalk v1.16.1"
	"github.com/lib/pq v1.10.0"
	"github.com/logrusorgru/aurora v2.0.3"
	"github.com/miekg/dns v1.1.41"
	"github.com/mitchellh/mapstructure v1.4.1"
	"github.com/modern-go/concurrent bacd9c7ef1dd"
	"github.com/modern-go/reflect2 v1.0.1"
	"github.com/pkg/errors v0.9.1"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/projectdiscovery/chaos-client v0.1.8"
	"github.com/projectdiscovery/dnsx v1.0.3"
	"github.com/projectdiscovery/fdmax v0.0.3"
	"github.com/projectdiscovery/fileutil cab279c5d4b5"
	"github.com/projectdiscovery/goflags 9bbeacc2fb8f"
	"github.com/projectdiscovery/gologger v1.1.4"
	"github.com/projectdiscovery/retryabledns eec3ac17d61e"
	"github.com/projectdiscovery/stringsutil fd3c28dbaafe"
	"github.com/rs/xid v1.3.0"
	"github.com/spyse-com/go-spyse v1.2.3"
	"github.com/stretchr/testify v1.7.0"
	"github.com/tomnomnom/linkheader 02ca5825eb80"
	"golang.org/x/net e915ea6b2b7d github.com/golang/net"
	"golang.org/x/sys 37df388d1f33 github.com/golang/sys"
	"golang.org/x/time 1f47c861a9ac github.com/golang/time"
	"gopkg.in/yaml.v2 v2.4.0 github.com/go-yaml/yaml"
	"gopkg.in/yaml.v3 496545a6307b github.com/go-yaml/yaml"
	"go.uber.org/ratelimit v0.2.0 github.com/uber-go/ratelimit"
)

#https://github.com/golang/sys/archive/22a9840ba4d7f9769592a29c2d9b1d5865dea066.tar.gz

inherit golang-vcs-snapshot

DESCRIPTION="A subdomain discovery tool that discovers valid subdomains for websites"
HOMEPAGE="https://github.com/projectdiscovery/subfinder"

SRC_URI="https://github.com/projectdiscovery/subfinder/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MIT"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"

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
