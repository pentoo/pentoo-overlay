# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/gcla/termshark"

# go mod vendor && grep "# g" ./vendor/modules.txt | sort
EGO_VENDOR=(
	"github.com/adam-hanna/arrayOperations v0.2.5"
	"github.com/antchfx/xmlquery v1.0.0"
	"github.com/antchfx/xpath v1.0.0"
	"github.com/blang/semver v3.5.1"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/fsnotify/fsnotify v1.4.7"
	"github.com/gcla/deep v1.0.2"
	"github.com/gcla/gowid 45eed270dfd5"
	"github.com/gcla/tail 650e90873359"
	"github.com/gdamore/encoding v1.0.0"
	"github.com/gdamore/tcell bff4943f9a29 github.com/gcla/tcell"
	"github.com/hashicorp/golang-lru v0.5.3"
	"github.com/hashicorp/hcl v1.0.0"
	"github.com/jessevdk/go-flags v1.4.0"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.2"
	"github.com/lucasb-eyer/go-colorful v1.0.2"
	"github.com/magiconair/properties v1.8.0"
	"github.com/mattn/go-isatty v0.0.9"
	"github.com/mattn/go-runewidth v0.0.4"
	"github.com/mitchellh/mapstructure v1.1.2"
	"github.com/mreiferson/go-snappystream v0.2.3"
	"github.com/pelletier/go-toml v1.2.0"
	"github.com/pkg/errors v0.8.1"
	"github.com/pkg/term aa71e9d9e942"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/shibukawa/configdir e180dbd"
	"github.com/sirupsen/logrus v1.4.2"
	"github.com/spf13/afero v1.1.2"
	"github.com/spf13/cast v1.3.0"
	"github.com/spf13/jwalterweatherman v1.0.0"
	"github.com/spf13/pflag v1.0.3"
	"github.com/spf13/viper v1.3.2"
	"github.com/stretchr/testify v1.3.0"
	"github.com/tevino/abool 9b9efcf221b5"
	"gopkg.in/fsnotify.v1 v1.4.7 github.com/fsnotify/fsnotify"
	"gopkg.in/fsnotify/fsnotify.v1 v1.4.7 github.com/fsnotify/fsnotify"
	"gopkg.in/tomb.v1 dd632973f1e7 github.com/go-tomb/tomb"
	"gopkg.in/yaml.v2 v2.2.2 github.com/go-yaml/yaml"
)

inherit golang-vcs-snapshot

DESCRIPTION="A terminal UI for tshark, inspired by Wireshark"
HOMEPAGE="https://termshark.io/"

SRC_URI="https://github.com/gcla/termshark/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64 ~arm ~arm64 ~x86"
RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-go/go-crypto:=
	dev-go/go-text:=
	dev-go/go-sys:=
	dev-go/go-net:=
	dev-go/go-tools:=
	net-analyzer/wireshark[dumpcap,pcap,tshark]"

DEPEND="${RDEPEND}"
BDEPEND="dev-lang/go"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
	GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags "-w -X ${EGO_PN}.Version=${PV}" ./... || die
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
	GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags "-w -X ${MY_EGO_PN}.Version=${PV}" ./... || die

	dobin bin/${PN}
	dodoc "src/${EGO_PN}"/{README.md,docs/*}
}
