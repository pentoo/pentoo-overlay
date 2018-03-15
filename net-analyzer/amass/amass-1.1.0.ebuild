# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=( "github.com/caffix/recon e2c3ea0ba9caf74eaa1643ab8642d1363997a147"
	"github.com/PuerkitoBio/gocrawl 3c6275ae0143e4fa9ee522c2d4008d983a2fefaf"
	"github.com/PuerkitoBio/goquery 61aa1975b1f7856927c526b0e0cd8c8b3a3030d0"
	"github.com/likexian/whois-go 2a3082919f1b4c463346655d09826ae07a6c843f"
	"github.com/likexian/whois-parser-go 34880469cbbedc02c20d2747e6082030a4b735b3"
	"github.com/PuerkitoBio/purell 975f53781597ed779763b7b65566e74c4004d8de"
	"github.com/PuerkitoBio/urlesc de5bf2ad457846296e2031421a34e2568e304e35"
	"github.com/andybalholm/cascadia 901648c87902174f774fac311d7f176f8647bdaa"
	"github.com/miekg/dns 906238edc6eb0ddface4a1923f6d41ef2a5ca59b"
	"github.com/temoto/robotstxt 9e4646fa705336d5b2fa9dddfafbe0a1a965acd7"
	"golang.org/x/net e0c57d8f86c17f0724497efcb3bc617e82834821 github.com/golang/net"
	"golang.org/x/text 4a13a3860a6e13b9c8d09ceeb19f19a4b68c1a4e github.com/golang/text"
)

EGO_PN=github.com/caffix/amass

inherit golang-build golang-vcs-snapshot

EGIT_COMMIT="v${PV}"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz ${EGO_VENDOR_URI}"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

DESCRIPTION="Subdomain OSINT Enumeration"
HOMEPAGE="https://github.com/caffix/amass"
LICENSE="GPL-3"
SLOT=0
IUSE=""
KEYWORDS="~amd64 ~arm ~arm64"

#fix me: gocrawl, goquery, purell cascadia, dns, text
DEPEND=">=dev-lang/go-1.10"
RDEPEND="${DEPEND}"

src_install(){
	dobin amass
}
