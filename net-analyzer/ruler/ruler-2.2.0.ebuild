# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=( "github.com/urfave/cli 8e01ec4cd3e2d84ab2fe90d8210528ffbb06d8ff"
	"github.com/howeyc/gopass  bf9dde6d0d2c004a008c27aaee91170c786f6db8"
	"gopkg.in/yaml.v2 5420a8b6744d3b0345ab293f6fcba19c978f1183 github.com/go-yaml/yaml"
	"github.com/staaldraad/go-ntlm 447d8aaecab06da9873f6df6c08ecc97dc033c94"
	"golang.org/x/crypto 12892e8c234f4fe6f6803f052061de9057903bb2 github.com/golang/crypto"
	"golang.org/x/sys 7dca6fe1f43775aa6d1334576870ff63f978f539 github.com/golang/sys"
	"github.com/ThomsonReutersEikon/go-ntlm 2a7c173f9e18233a4ae29891da6a0a63637e2d8d"
)

EGO_PN=github.com/sensepost/ruler

inherit golang-build golang-vcs-snapshot

EGIT_COMMIT="${PV}"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz ${EGO_VENDOR_URI}"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

DESCRIPTION="A tool to abuse Exchange services"
HOMEPAGE="https://github.com/sensepost/ruler"
LICENSE="CC-BY-NC-SA-4.0"
SLOT=0
IUSE=""
KEYWORDS="~amd64 ~arm ~arm64"

#cli dev-go/cli
DEPEND=""
RDEPEND=""

src_install(){
	dobin ruler
}
