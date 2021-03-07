# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN=github.com/tomnomnom/${PN}
EGO_VENDOR=(
	"github.com/jakewarren/tldomains dd0852eb6e50"
)

inherit golang-vcs-snapshot

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="amd64 x86"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
		${EGO_VENDOR_URI}"
fi

DESCRIPTION="Pull out bits of URLs provided on stdin"
HOMEPAGE="https://github.com/tomnomnom/unfurl"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-s -w" "${EGO_PN}" || die
}

src_install(){
	dobin unfurl
}
