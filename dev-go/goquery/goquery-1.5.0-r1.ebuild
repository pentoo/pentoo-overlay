# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN=github.com/PuerkitoBio/${PN}

EGO_VENDOR=(
	"golang.org/x/net adae6a3d119a github.com/golang/net"
	"github.com/andybalholm/cascadia v1.0.0"
)

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	inherit golang-vcs-snapshot
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"
fi
inherit golang-build

DESCRIPTION="A little like that j-thing"
HOMEPAGE="https://github.com/PuerkitoBio/goquery"
LICENSE="BSD"
SLOT="0"
IUSE=""

#FIXME: use external
#RDEPEND="dev-go/cascadia:="
RDEPEND=""
DEPEND="${RDEPEND}"

#src_compile() {
#	GOPATH="${S}:$(get_golibdir_gopath)" \
#		GOCACHE="${T}/go-cache" \
#		go build -v -work -x -ldflags="-s -w" ./... "${EGO_PN}" || die
#}
