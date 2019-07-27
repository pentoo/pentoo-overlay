# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/mame82/mjackit"
EGO_VENDOR=(
	"github.com/google/gousb a50ac95"
	"github.com/manifoldco/promptui v0.3.2"
)

inherit golang-vcs-snapshot toolchain-funcs

DESCRIPTION="Demo tool for Logitech Unifying vulnerabilities"
HOMEPAGE="https://github.com/mame82/UnifyingVulnsDisclosureRepo/"

HASH_COMMIT="7bfa689104ab3d54d2a18e69a5a60195ec1cd876"
SRC_URI="https://github.com/mame82/UnifyingVulnsDisclosureRepo/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64 ~arm ~arm64"
LICENSE="Unlicense"
IUSE="doc"
SLOT=0

RDEPEND="virtual/libusb:1"
DEPEND="${RDEPEND}"

src_unpack() {
	golang-vcs-snapshot_src_unpack

	mv "${S}/src/${EGO_PN}/tools/mjackit"/* \
		"${S}/src/${EGO_PN}" || die
}

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		CGO_ENABLED=1 \
		go build -v -work -x -ldflags="-extld=$(tc-getCC)" "${EGO_PN}" || die
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		CGO_ENABLED=1 \
		go install -v -work -x -ldflags="-extld=$(tc-getCC)" "${EGO_PN}" || die

	dobin bin/${PN}
	dodoc src/"${EGO_PN}"/README.md

	if use doc; then
		dodoc -r src/"${EGO_PN}"/{documents,vulnerability_reports}
	fi
}
