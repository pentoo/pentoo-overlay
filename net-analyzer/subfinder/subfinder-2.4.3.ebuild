# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/projectdiscovery/subfinder"
EGO_VENDOR=(
	"github.com/alexbrainman/sspi e580b90"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/google/gofuzz v1.0.0"
	"github.com/gorilla/securecookie v1.1.1"
	"github.com/gorilla/sessions v1.2.0"
	"github.com/hako/durafmt c0fb7b4"
	"github.com/hashicorp/go-uuid v1.0.2"
	"github.com/jcmturner/aescts/v2 v2.0.0 github.com/jcmturner/aescts"
	"github.com/jcmturner/dnsutils/v2 v2.0.0 github.com/jcmturner/dnsutils"
	"github.com/jcmturner/gofork v1.0.0"
	"github.com/jcmturner/goidentity/v6 v6.0.1 github.com/jcmturner/goidentity"
	"github.com/jcmturner/gokrb5/v8 v8.2.0 github.com/jcmturner/gokrb5"
	"github.com/jcmturner/rpc/v2 v2.0.2 github.com/jcmturner/rpc"
	"github.com/json-iterator/go v1.1.10"
	"github.com/lib/pq v1.8.0"
	"github.com/logrusorgru/aurora e9ef32d"
	"github.com/miekg/dns v1.1.29"
	"github.com/modern-go/concurrent e0a39a4"
	"github.com/modern-go/reflect2 4b7aa43"
	"github.com/pkg/errors v0.9.1"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/projectdiscovery/chaos-client v0.1.6"
	"github.com/projectdiscovery/gologger v1.0.0"
	"github.com/rs/xid v1.2.1"
	"github.com/stretchr/objx v0.1.0"
	"github.com/stretchr/testify v1.5.1"
	"github.com/tomnomnom/linkheader 02ca582"
	"golang.org/x/crypto f7b0055 github.com/golang/crypto"
	"golang.org/x/net 6afb519 github.com/golang/net"
	"golang.org/x/sys 2837fb4 github.com/golang/sys"
	"gopkg.in/jcmturner/aescts.v1 v1.0.1 github.com/jcmturner/aescts"
	"gopkg.in/jcmturner/dnsutils.v1 v1.0.1 github.com/jcmturner/dnsutils"
	"gopkg.in/jcmturner/goidentity.v3 v3.0.0 github.com/jcmturner/goidentity"
	"gopkg.in/jcmturner/gokrb5.v7 v7.5.0 github.com/jcmturner/gokrb5"
	"gopkg.in/jcmturner/rpc.v1 v1.1.0 github.com/jcmturner/rpc"
	"gopkg.in/yaml.v2 v2.2.2 github.com/go-yaml/yaml"
	"gopkg.in/yaml.v3 a5ece68 github.com/go-yaml/yaml"
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
