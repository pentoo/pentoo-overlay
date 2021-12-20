# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/gcla/termshark"

# go mod vendor && grep "# g" ./vendor/modules.txt | sort
EGO_VENDOR=(
	"github.com/adam-hanna/arrayOperations v0.2.5"
	"github.com/antchfx/xmlquery v1.3.3"
	"github.com/antchfx/xpath v1.1.11"
	"github.com/araddon/dateparse 0eec95c9db7e"
	"github.com/blang/semver v3.5.1"
	"github.com/creack/pty v1.1.15"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/fsnotify/fsnotify v1.4.7"
	"github.com/gcla/deep v1.0.2"
	"github.com/gcla/gowid c4910818c6b3"
	"github.com/gcla/tail 650e90873359"
	"github.com/gdamore/encoding v1.0.0"
	"github.com/gdamore/tcell decc2045f510 github.com/gcla/tcell"
	"github.com/golang/groupcache 8c9f03a8e57e"
	"github.com/hashicorp/golang-lru v0.5.3"
	"github.com/hashicorp/hcl v1.0.0"
	"github.com/jessevdk/go-flags v1.4.0"
	"github.com/kballard/go-shellquote 95032a82bc51"
	"github.com/klauspost/compress v1.11.13"
	"github.com/lucasb-eyer/go-colorful v1.0.3"
	"github.com/magiconair/properties v1.8.4"
	"github.com/mattn/go-isatty v0.0.12"
	"github.com/mattn/go-runewidth v0.0.10"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/mapstructure v1.4.0"
	"github.com/mreiferson/go-snappystream v0.2.3"
	"github.com/pelletier/go-toml v1.8.1"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/term 31cba2f9f402 github.com/gcla/term"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/psanford/wormhole-william 049df45b8d5a"
	"github.com/rakyll/statik v0.1.7"
	"github.com/rivo/uniseg v0.1.0"
	"github.com/shibukawa/configdir e180dbdc8da0"
	"github.com/sirupsen/logrus v1.7.0"
	"github.com/spf13/afero v1.5.1"
	"github.com/spf13/cast v1.3.1"
	"github.com/spf13/jwalterweatherman v1.1.0"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/viper v1.7.1"
	"github.com/stretchr/testify v1.7.0"
	"github.com/subosito/gotenv v1.2.0"
	"github.com/tevino/abool v1.2.0"
	"golang.org/x/crypto 75b288015ac9 github.com/golang/crypto"
	"golang.org/x/net 6772e930b67b github.com/golang/net"
	"golang.org/x/sys 0df2131ae363 github.com/golang/sys"
	"golang.org/x/text v0.3.5 github.com/golang/text"
	"gopkg.in/fsnotify/fsnotify.v1 v1.4.7 github.com/fsnotify/fsnotify"
	"gopkg.in/ini.v1 v1.62.0 github.com/go-ini/ini"
	"gopkg.in/tomb.v1 dd632973f1e7 github.com/go-tomb/tomb"
	"gopkg.in/yaml.v2 v2.4.0 github.com/go-yaml/yaml"
	"gopkg.in/yaml.v3 496545a6307b github.com/go-yaml/yaml"
	
	"nhooyr.io/websocket v1.8.7 github.com/nhooyr/websocket"
	"salsa.debian.org/vasudev/gospake2 adcc69dd31d5 salsa.debian.org/vasudev/gospake2/-/"
	"salsa.debian.org/vasudev/ed25519group 3aff6cc605d469a7d618240e4a5cee3e1a861b43 salsa.debian.org/vasudev/ed25519group/-/"
)

inherit golang-vcs-snapshot

DESCRIPTION="A terminal UI for tshark, inspired by Wireshark"
HOMEPAGE="https://termshark.io/"

SRC_URI="https://github.com/gcla/termshark/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64 ~arm ~x86"
RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

#	dev-go/go-text:=
#	dev-go/go-tools:=
RDEPEND="
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
