# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/sensepost/gowitness"
EGO_VENDOR=(
	"github.com/armon/consul-api eb2c6b5be1b6"
	"github.com/chromedp/cdproto d7cfa85db7d1"
	"github.com/chromedp/chromedp v0.7.2"
	"github.com/chromedp/sysutil v1.0.0"
	"github.com/corona10/goimagehash v1.0.3"
	"github.com/gobwas/httphead v0.1.0"
	"github.com/gobwas/pool v0.2.1"
	"github.com/gobwas/ws v1.1.0-rc.5"
	"github.com/h2non/filetype v1.1.1"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/jinzhu/inflection v1.0.0"
	"github.com/jinzhu/now v1.1.1"
	"github.com/josharian/intern v1.0.0"
	"github.com/knq/sysutil 15668db23d08"
	"github.com/mailru/easyjson v0.7.7"
	"github.com/mattn/go-runewidth v0.0.10"
	"github.com/mattn/go-sqlite3 v1.14.6"
	"github.com/nfnt/resize 83c6a9932646"
	"github.com/olekukonko/tablewriter v0.0.5"
	"github.com/PuerkitoBio/goquery v1.5.1"
	"github.com/remeh/sizedwaitgroup v1.0.0"
	"github.com/rivo/uniseg v0.2.0"
	"github.com/rs/zerolog v1.20.0"
	"github.com/shurcooL/httpfs 8d4bc4ba7749"
	"github.com/shurcooL/vfsgen 0d455de96546"
	"github.com/spf13/cobra v1.1.3"
	"github.com/spf13/pflag v1.0.5"
	"github.com/tomsteele/go-nmap 3507e0b03523"
	"github.com/ugorji/go v1.1.4"
	"github.com/xordataexchange/crypt b2862e3d0a77"
	"golang.org/x/net 3d97a244fca7 github.com/golang/net"
	"golang.org/x/sys e8d321eab015 github.com/golang/sys"
	"gorm.io/driver/sqlite v1.1.4 github.com/go-gorm/sqlite"
	"gorm.io/gorm v1.20.12 github.com/go-gorm/gorm"
)

inherit eutils golang-vcs-snapshot

DESCRIPTION="A web screenshot utility using Chrome Headless"
HOMEPAGE="https://github.com/sensepost/gowitness"

SRC_URI="https://github.com/sensepost/gowitness/archive/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="amd64 ~x86"
LICENSE="CC-BY-SA-4.0 GPL-3 AGPL-3"
SLOT="0"

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
