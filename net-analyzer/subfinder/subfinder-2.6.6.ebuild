# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#EGO_PN="github.com/projectdiscovery/subfinder"

# go mod vendor && grep "# g" ./vendor/modules.txt | sort
inherit go-module

DESCRIPTION="A subdomain discovery tool that discovers valid subdomains for websites"
HOMEPAGE="https://github.com/projectdiscovery/subfinder"

SRC_URI="https://github.com/projectdiscovery/subfinder/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${P}-vendor.tar.xz
"
S="${WORKDIR}/${P}/v2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

#BDEPEND="dev-lang/go"

#src_compile() {
#	GOPATH="${S}:$(get_golibdir_gopath)" \
#		GOCACHE="${T}/go-cache" \
#		go build -v -work -x -ldflags="-w -X main.version=${PV}" ./... || die
#}

#src_install() {
#	GOPATH="${S}:$(get_golibdir_gopath)" \
#		GOCACHE="${T}/go-cache" \
#		go install -v -work -x -ldflags="-w -X main.version=${PV}" ./... || die

#	dobin bin/subfinder
#	dodoc "src/${EGO_PN}"/{*.md,Dockerfile}
#}

src_install() {
	dobin subfinder
}
