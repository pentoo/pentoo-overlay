# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=(
	"github.com/Ullaakut/nmap dd19ce29bb85f6c3671afe725cbb1d9968cc97c7"
	"github.com/ullaakut/nmap dd19ce29bb85f6c3671afe725cbb1d9968cc97c7"
	"github.com/fatih/color v1.7.0"
	"github.com/gernest/wow v0.1.0"
	"github.com/go-playground/locales v0.12.1"
	"github.com/go-playground/universal-translator v0.16.0"
	"github.com/leodido/go-urn v1.1.0"
	"github.com/mattn/go-colorable v0.1.1"
	"github.com/mattn/go-isatty v0.0.6"
	"github.com/pkg/errors v0.8.1"
	"github.com/spf13/pflag v1.0.3"
	"github.com/spf13/viper v1.3.1"
	"github.com/ullaakut/disgo v0.3.0"
	"github.com/ullaakut/go-curl 597e157bbffd17fd6b8d7c5c0a8a573d036b048e"
	"gopkg.in/go-playground/validator v9.27.0 github.com/go-playground/validator"

	"github.com/fsnotify/fsnotify v1.4.7"
	"github.com/hashicorp/hcl v1.0.0"
	"github.com/magiconair/properties v1.8.1"
	"github.com/mitchellh/mapstructure v1.1.2"
	"github.com/pelletier/go-toml v1.4.0"
	"github.com/spf13/afero v1.2.2"
	"github.com/spf13/cast v1.3.0"
	"github.com/spf13/jwalterweatherman v1.1.0"
	"gopkg.in/yaml.v2 v2.2.2 github.com/go-yaml/yaml"
)

EGO_PN=github.com/ullaakut/cameradar
inherit golang-build golang-vcs-snapshot

DESCRIPTION="Cameradar hacks its way into RTSP videosurveillance cameras"
HOMEPAGE="https://github.com/ullaakut/cameradar"
LICENSE="BSD"

EGIT_COMMIT="0f011a17978e12b99f154449540cdd78ec248c61"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz ${EGO_VENDOR_URI}"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome X"

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	eapply "${FILESDIR}"/path.patch
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
