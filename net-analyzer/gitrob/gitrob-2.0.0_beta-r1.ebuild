# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/michenriksen/gitrob"
EGO_VENDOR=(
	"github.com/elazarl/go-bindata-assetfs v1.0.0"
	"github.com/gin-contrib/secure 312887e"
	"github.com/gin-contrib/static c1cdf9c"
	"github.com/gin-gonic/gin v1.4.0"
	"github.com/google/go-github v8.0.0"
	"github.com/fatih/color v1.7.0"
	"github.com/emirpasic/gods v1.12.0"
	"github.com/gin-contrib/sse v0.1.0"
	"github.com/golang/protobuf v1.3.2"
	"github.com/google/go-querystring v1.0.0"
	"github.com/jbenet/go-context d14ea06"
	"github.com/kevinburke/ssh_config 0.5"
	"github.com/mattn/go-isatty v0.0.8"
	"github.com/sergi/go-diff v1.0.0"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/pelletier/go-buffruneio v0.2.0"
	"github.com/src-d/gcfg v1.4.0"
	"github.com/ugorji/go v1.1.7"
	"github.com/xanzy/ssh-agent v0.2.1"
	"golang.org/x/oauth2 0f29369 github.com/golang/oauth2"
	"gopkg.in/go-playground/validator.v8 v8.5 github.com/go-playground/validator"
	"gopkg.in/yaml.v2 v2.2.2 github.com/go-yaml/yaml"
	"gopkg.in/src-d/go-billy.v4 v4.3.1 github.com/src-d/go-billy"
	"gopkg.in/src-d/go-git.v4 v4.10.0 github.com/src-d/go-git"
	"gopkg.in/warnings.v0 v0.1.2 github.com/go-warnings/warnings"
)

inherit eutils golang-vcs-snapshot

DESCRIPTION="Reconnaissance tool for GitHub organizations"
HOMEPAGE="https://github.com/michenriksen/gitrob https://michenriksen.com/blog/gitrob-now-in-go/"

SRC_URI="https://github.com/michenriksen/gitrob/archive/v${PV/_/-}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="MIT"
IUSE=""
SLOT=0

RDEPEND=""
DEPEND="
	dev-go/go-net:=
	dev-go/go-crypto:=
	dev-go/go-sys:=
	dev-go/go-text:=
	dev-lang/go"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-s -w" "${EGO_PN}" || die
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-s -w" "${EGO_PN}" || die

	dobin bin/${PN}
	dodoc \
		src/"${EGO_PN}"/{README.md,CHANGELOG.md}
}
