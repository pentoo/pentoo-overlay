# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# go mod vendor && grep "# g" ./vendor/modules.txt | sort
EGO_PN=github.com/ullaakut/${PN}
EGO_VENDOR=(
	"github.com/andybalholm/cascadia v1.0.0"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/fatih/color v1.7.0"
	"github.com/fsnotify/fsnotify v1.4.7"
	"github.com/hashicorp/hcl v1.0.0"
	"github.com/magiconair/properties v1.8.0"
	"github.com/mattn/go-colorable v0.1.2"
	"github.com/mattn/go-isatty v0.0.8"
	"github.com/mitchellh/mapstructure v1.1.2"
	"github.com/pelletier/go-toml v1.2.0"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/PuerkitoBio/goquery v1.5.0"
	"github.com/spf13/afero v1.1.2"
	"github.com/spf13/cast v1.3.0"
	"github.com/spf13/jwalterweatherman v1.0.0"
	"github.com/spf13/pflag v1.0.3"
	"github.com/spf13/viper v1.4.0"
	"github.com/stretchr/objx v0.1.1"
	"github.com/stretchr/testify v1.2.2"
	"github.com/Ullaakut/disgo v0.3.1"
	"github.com/Ullaakut/go-curl 597e157bbffd"
	"github.com/Ullaakut/nmap v2.0.0"
	"github.com/vbauerster/mpb v3.4.0"
	"github.com/VividCortex/ewma v1.1.1"
	"golang.org/x/crypto c2843e01d9a2 github.com/golang/crypto"
	"golang.org/x/net f3200d17e092 github.com/golang/net"
	"golang.org/x/sys a9d3bda3a223 github.com/golang/sys"
	"golang.org/x/text v0.3.0 github.com/golang/text"
	"gopkg.in/yaml.v2 v2.2.2 github.com/go-yaml/yaml"
	)

inherit golang-vcs-snapshot

DESCRIPTION="Cameradar hacks its way into RTSP videosurveillance cameras"
HOMEPAGE="https://github.com/ullaakut/cameradar"
LICENSE="BSD"

SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz
	${EGO_VENDOR_URI}"

SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome X"

RDEPEND=">=dev-lang/go-1.12"

DEPEND="${RDEPEND}"

src_prepare() {
	eapply "${FILESDIR}/5-path.patch"

	#https://github.com/Ullaakut/nmap/issues/78
	mkdir -p "${S}/src/github.com/ullaakut/${PN}/vendor/github.com/Ullaakut/nmap/v2/"
	ln -s "${S}/src/github.com/ullaakut/${PN}/vendor/github.com/Ullaakut/nmap/pkg/" "${S}/src/github.com/ullaakut/${PN}/vendor/github.com/Ullaakut/nmap/v2/"

	ln -s "${S}/src/github.com/ullaakut/${PN}/" "${S}/src/github.com/ullaakut/${PN}/v5"
	ln -s "${S}/src/github.com/ullaakut" "${S}/src/github.com/Ullaakut"
	eapply_user
}

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
	GOCACHE="${T}/go-cache" \
	go build -v -work -x -ldflags="-s -w" "${EGO_PN}/cmd/cameradar/" || die
}

src_install() {
	dobin cameradar

	insinto /usr/share/cameradar/dictionaries/
	doins src/"${EGO_PN}"/dictionaries/{credentials.json,routes}
}
