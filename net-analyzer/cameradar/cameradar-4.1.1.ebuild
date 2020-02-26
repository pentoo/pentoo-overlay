# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#extracted using 'go mod vendor' -> grep "# g" ./vendor/modules.txt | sort file
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
#	"golang.org/x/crypto c2843e01d9a2"
#	"golang.org/x/net f3200d17e092"
#	"golang.org/x/sys a9d3bda3a223"
#	"golang.org/x/text v0.3.0"
	"gopkg.in/yaml.v2 v2.2.2 github.com/go-yaml/yaml"
#	"gopkg.in/go-playground/validator v9.27.0 github.com/go-playground/validator"
)

EGO_PN=github.com/ullaakut/cameradar
inherit golang-build golang-vcs-snapshot

DESCRIPTION="Cameradar hacks its way into RTSP videosurveillance cameras"
HOMEPAGE="https://github.com/ullaakut/cameradar"
LICENSE="BSD"

ARCHIVE_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz ${EGO_VENDOR_URI}"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome X"

DEPEND=">=dev-lang/go-1.12
	dev-go/go-crypto
	dev-go/go-net
	dev-go/go-sys
	dev-go/go-text"

DEPEND="${RDEPEND}"

src_prepare() {
	eapply "${FILESDIR}/${PV}-path.patch"
	eapply_user
}

src_compile() {
	cd src/${EGO_PN}/cmd/cameradar

	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
	go build -v -work -x ${EGO_BUILD_FLAGS} -o "${S}/bin/cameradar" || die
}

src_install() {
	dobin bin/cameradar

	insinto /usr/share/cameradar/
	doins src/"${EGO_PN}"/dictionaries/{credentials.json,routes}
}
