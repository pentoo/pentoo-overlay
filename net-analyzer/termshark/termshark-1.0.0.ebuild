# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/gcla/termshark"
EGO_VENDOR=(
	"github.com/BurntSushi/toml			3012a1d" # v0.3.1
	"github.com/blang/semver			2ee8785" # v3.5.1
	"github.com/gcla/deep				1985ad2" # v1.0.2
	"github.com/gcla/gowid				bb6fd39" # v1.0.0
	"github.com/gdamore/tcell			dcf1bb3" # 20190407
	"github.com/hashicorp/golang-lru	7087cb7" # v0.5.1
	"github.com/jessevdk/go-flags		c6ca198" # v1.4.0
	"github.com/mattn/go-isatty			c2a7a6c" # v0.0.7
	"github.com/pkg/errors				ba968bf" # v0.8.1
	"github.com/shibukawa/configdir		e180dbd" # 20170330
	"github.com/sirupsen/logrus			8bdbc7b" # v1.4.1
	"github.com/spf13/viper				9e56dac" # v1.3.2
	"github.com/stretchr/testify		ffdc059" # v1.3.0
	"github.com/hashicorp/hcl			8cb6e5b" # v1.0.0
	"github.com/lucasb-eyer/go-colorful 30298f2" # v1.0.2
	"github.com/magiconair/properties	c235336" # v1.8.0
	"github.com/mattn/go-runewidth		3ee7d81" # v0.0.4
	"github.com/mitchellh/mapstructure	3536a92" # v1.1.2
	"github.com/pelletier/go-toml		63909f0" # v1.3.0
	"github.com/spf13/afero				588a75e" # v1.2.2
	"github.com/spf13/cast				8c9545a" # v1.3.0
	"github.com/spf13/jwalterweatherman	94f6ae3" # v1.1.0
	"github.com/spf13/pflag				298182f" # v1.0.3
	"github.com/gdamore/encoding		6289cdc" # v1.0.0
	"gopkg.in/yaml.v2					51d6538 github.com/go-yaml/yaml" # v2.2.2

	"github.com/fsnotify/fsnotify 		c282820" # v1.4.7
	"gopkg.in/fsnotify.v1 				c282820 github.com/fsnotify/fsnotify"
)

inherit golang-vcs-snapshot

DESCRIPTION="A terminal UI for tshark, inspired by Wireshark"
HOMEPAGE="https://termshark.io/ https://github.com/gcla/termshark"

SRC_URI="https://github.com/gcla/termshark/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64 ~arm ~arm64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="!net-analyzer/termshark-bin
	dev-go/go-text:=
	dev-go/go-sys:=
	net-analyzer/wireshark[dumpcap,pcap,tshark]"

DEPEND="${RDEPEND}
	>=dev-lang/go-1.12"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
	GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags "-s -w -X ${EGO_PN}.Version=${PV}" ./... || die
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
	GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags "-s -w -X ${MY_EGO_PN}.Version=${PV}" ./... || die

	dobin bin/${PN}
	dodoc src/"${EGO_PN}"/{README.md,docs/*}
}

pkg_postinst() {
	elog "\nSee documentation:"
	elog "    https://github.com/gcla/termshark/blob/master/docs/UserGuide.md"
	elog "    ~$ bzip2 -dc usr/share/doc/termshark-${PV}/UserGuide.md.bz2 | less"
	elog "    ~$ bzip2 -dc usr/share/doc/termshark-${PV}/FAQ.md.bz2 | less\n"
}
