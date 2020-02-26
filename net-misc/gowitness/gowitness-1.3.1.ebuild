# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/sensepost/gowitness"
EGO_VENDOR=(
	"github.com/BurntSushi/toml v0.3.1"
	"github.com/corona10/goimagehash v1.0.1"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/elazarl/goproxy ecfe977"
	"github.com/elazarl/goproxy/ext 473e67f github.com/elazarl/goproxy"
	"github.com/fsnotify/fsnotify v1.4.7"
	"github.com/golang/protobuf v1.2.0"
	"github.com/gopherjs/gopherjs 0766667"
	"github.com/hashicorp/hcl 23c074d"
	"github.com/hpcloud/tail v1.0.0"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/jtolds/gls v4.20.0"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/pty v1.1.1"
	"github.com/kr/text v0.1.0"
	"github.com/magiconair/properties v1.7.3"
	"github.com/mattn/go-runewidth v0.0.4"
	"github.com/mcuadros/go-version 88e56e0"
	"github.com/mitchellh/go-homedir b8bc1bf"
	"github.com/mitchellh/mapstructure 06020f8"
	"github.com/moul/http2curl v1.0.0"
	"github.com/nfnt/resize 83c6a99"
	"github.com/olekukonko/tablewriter v0.0.1"
	"github.com/onsi/ginkgo v1.10.1"
	"github.com/onsi/gomega v1.7.0"
	"github.com/parnurzeal/gorequest v0.2.15"
	"github.com/pelletier/go-toml v1.0.1"
	"github.com/pkg/errors v0.8.0"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/reconquest/barely 0f12e3b"
	"github.com/reconquest/loreley 9e95b93"
	"github.com/remeh/sizedwaitgroup 4b44541"
	"github.com/rogpeppe/go-charset 2471d30"
	"github.com/sirupsen/logrus v1.0.3"
	"github.com/smartystreets/assertions b2de0cb"
	"github.com/smartystreets/goconvey 505e419"
	"github.com/spf13/afero 5660eee"
	"github.com/spf13/cast v1.1.0"
	"github.com/spf13/cobra v0.0.1"
	"github.com/spf13/jwalterweatherman 12bd96e"
	"github.com/spf13/pflag v1.0.0"
	"github.com/spf13/viper v1.0.0"
	"github.com/stretchr/objx v0.1.0"
	"github.com/stretchr/testify v1.4.0"
	"github.com/tidwall/btree 9876f14"
	"github.com/tidwall/buntdb b67b1b8"
	"github.com/tidwall/gjson v1.0.1"
	"github.com/tidwall/grect ba9a043"
	"github.com/tidwall/match v1.0.0"
	"github.com/tidwall/rtree d4a8a3d"
	"github.com/tomsteele/go-nmap 3b9bafd"
	"golang.org/x/crypto c2843e0 github.com/golang/crypto"
	"golang.org/x/net d888771 github.com/golang/net"
	"golang.org/x/sync 1d60e46 github.com/golang/sync"
	"golang.org/x/sys d0b11bd github.com/golang/sys"
	"golang.org/x/text v0.3.0 github.com/golang/text"
	"golang.org/x/tools ab21143 github.com/golang/tools"
	"gopkg.in/airbrake/gobrake.v2 v2.0.9 github.com/airbrake/gobrake"
	"gopkg.in/check.v1 41f04d3 github.com/go-check/check"
	"gopkg.in/fsnotify.v1 v1.4.7 github.com/fsnotify/fsnotify"
	"gopkg.in/gemnasium/logrus-airbrake-hook.v2 v2.1.2 github.com/gemnasium/logrus-airbrake-hook"
	"gopkg.in/yaml.v2 v2.2.2 github.com/go-yaml/yaml"
)

inherit eutils golang-vcs-snapshot

DESCRIPTION="A web screenshot utility using Chrome Headless"
HOMEPAGE="https://github.com/sensepost/gowitness"

SRC_URI="https://github.com/sensepost/gowitness/archive/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="CC-BY-SA-4.0 GPL-3 AGPL-3"
SLOT="0"

RESTRICT="mirror"

BDEPEND="dev-lang/go"

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
	dodoc "src/${EGO_PN}/README.md"
}

pkg_postinst() {
	einfo "\nYou need install Google Chrome or chrome based browser before using it"
	einfo "See documentation: https://github.com/sensepost/gowitness#usage\n"
}
