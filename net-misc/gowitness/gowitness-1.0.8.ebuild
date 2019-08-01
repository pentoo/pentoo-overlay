# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/sensepost/gowitness"
EGO_VENDOR=(
	"github.com/fsnotify/fsnotify v1.4.2"
	"github.com/hashicorp/hcl 23c074d"
	"github.com/inconshreveable/mousetrap v1.0"
	"github.com/magiconair/properties v1.7.3"
	"github.com/mcuadros/go-version 88e56e0"
	"github.com/mitchellh/go-homedir b8bc1bf"
	"github.com/mitchellh/mapstructure 06020f8"
	"github.com/moul/http2curl 9ac6cf4"
	"github.com/parnurzeal/gorequest v0.2.15"
	"github.com/pelletier/go-toml v1.0.1"
	"github.com/pkg/errors v0.8.0"
	"github.com/reconquest/barely 0f12e3b"
	"github.com/remeh/sizedwaitgroup 4b44541"
	"github.com/sirupsen/logrus v1.0.3"
	"github.com/spf13/afero 5660eee"
	"github.com/spf13/cast v1.1.0"
	"github.com/spf13/cobra v0.0.1"
	"github.com/spf13/jwalterweatherman 12bd96e"
	"github.com/spf13/pflag v1.0.0"
	"github.com/spf13/viper v1.0.0"
	"github.com/tidwall/btree 9876f14"
	"github.com/tidwall/buntdb b67b1b8"
	"github.com/tidwall/gjson v1.0.1"
	"github.com/tidwall/grect ba9a043"
	"github.com/tidwall/match 1731857"
	"github.com/tidwall/rtree d4a8a3d"
	"gopkg.in/yaml.v2 eb3733d github.com/go-yaml/yaml"
)

inherit eutils golang-vcs-snapshot

DESCRIPTION="A web screenshot utility using Chrome Headless"
HOMEPAGE="https://github.com/sensepost/gowitness"

SRC_URI="https://github.com/sensepost/gowitness/archive/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="CC-BY-SA-4.0"
IUSE=""
SLOT=0

RDEPEND=""
DEPEND="
	dev-go/go-net:=
	dev-go/go-crypto:=
	dev-go/go-sys:=
	dev-go/go-text:=
	>=dev-lang/go-1.12"

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
		src/"${EGO_PN}"/README.md
}

pkg_postinst() {
	einfo "\nYou need install Google Chrome or chrome based browser before using it"
	einfo "See documentation: https://github.com/sensepost/gowitness#usage\n"
}
