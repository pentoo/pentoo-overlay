# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/zricethezav/gitleaks"
EGO_VENDOR=(
	"github.com/BurntSushi/toml v0.3.1"
	"github.com/alcortesm/tgz 9c5fe88"
	"github.com/anmitsu/go-shlex 648efa6"
	"github.com/armon/go-socks5 e753329"
	"github.com/creack/pty v1.1.7"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/emirpasic/gods v1.12.0"
	"github.com/flynn/go-shlex 3f9db97"
	"github.com/gliderlabs/ssh v0.2.2"
	"github.com/golang/protobuf v1.2.0"
	"github.com/google/go-cmp v0.4.0"
	"github.com/google/go-github v17.0.0"
	"github.com/google/go-querystring v1.0.0"
	"github.com/hako/durafmt 3f39dc1"
	"github.com/jbenet/go-context d14ea06"
	"github.com/jessevdk/go-flags v1.4.0"
	"github.com/kevinburke/ssh_config 01f96b0"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.1"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/pty v1.1.8"
	"github.com/kr/text v0.1.0"
	"github.com/mattn/go-colorable v0.1.2"
	"github.com/mattn/go-isatty v0.0.8"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/pelletier/go-buffruneio v0.2.0"
	"github.com/pkg/errors v0.8.1"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/sergi/go-diff v1.0.0"
	"github.com/sirupsen/logrus v1.4.2"
	"github.com/src-d/gcfg v1.4.0"
	"github.com/stretchr/objx v0.2.0"
	"github.com/stretchr/testify v1.4.0"
	"github.com/xanzy/go-gitlab v0.21.0"
	"github.com/xanzy/ssh-agent v0.2.1"
	"golang.org/x/crypto 4def268 github.com/golang/crypto"
	"golang.org/x/net ca1201d github.com/golang/net"
	"golang.org/x/oauth2 0f29369 github.com/golang/oauth2"
	"golang.org/x/sys fc99dfb github.com/golang/sys"
	"gopkg.in/check.v1 788fd78 github.com/go-check/check"
	"gopkg.in/src-d/go-billy.v4 v4.3.2 github.com/src-d/go-billy"
	"gopkg.in/src-d/go-git-fixtures.v3 v3.5.0 github.com/src-d/go-git-fixtures"
	"gopkg.in/src-d/go-git.v4 v4.13.1 github.com/src-d/go-git"
	"gopkg.in/warnings.v0 v0.1.2 github.com/go-warnings/warnings"
	"gopkg.in/yaml.v2 v2.2.2 github.com/go-yaml/yaml"
)

inherit eutils golang-vcs-snapshot

DESCRIPTION="Audit git repos for secrets"
HOMEPAGE="https://github.com/zricethezav/gitleaks"

SRC_URI="https://github.com/zricethezav/gitleaks/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

DEPEND="
	dev-go/go-text:=
	dev-go/go-tools:="

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-w" "${EGO_PN}" || die
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-w" "${EGO_PN}" || die

	dobin bin/${PN}
	dodoc \
		src/"${EGO_PN}"/{README.md,Dockerfile}
}
