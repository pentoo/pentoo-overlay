# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/gcla/termshark/cmd/termshark"
MY_EGO_PN="github.com/gcla/termshark"

inherit golang-vcs

DESCRIPTION="A terminal UI for tshark, inspired by Wireshark"
HOMEPAGE="https://termshark.io/ https://github.com/gcla/termshark"

LICENSE="MIT"
SLOT=0

RDEPEND="net-analyzer/wireshark[dumpcap,pcap,tshark]"
DEPEND="${RDEPEND}
	!net-analyzer/termshark-bin"

S="${WORKDIR}/${P}"

src_unpack() {
	golang-vcs_src_unpack

	# `go get ...` can't structuring graph of available depends
	cp -r "${EGO_STORE_DIR}/src/${MY_EGO_PN%/...}" \
		"${WORKDIR}/${P}/src/${MY_EGO_PN%/...}/.." || die
}

src_compile() {
	GOPATH="${S}:${EGO_STORE_DIR}:$(get_golibdir_gopath)" \
	GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags "-s -w -X ${MY_EGO_PN}.Version=${PV}" ./... || die
}

src_install() {
	GOPATH="${S}:${EGO_STORE_DIR}:$(get_golibdir_gopath)" \
	GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags "-s -w -X ${MY_EGO_PN}.Version=${PV}" ./... || die

	dobin bin/${PN}
	dodoc src/"${MY_EGO_PN}"/{README.md,docs/*}
}

pkg_postinst() {
	einfo "\nSee documentation:"
	einfo "    https://github.com/gcla/termshark/blob/master/docs/UserGuide.md"
	einfo "    ~$ bzip2 -dc usr/share/doc/termshark-${PV}/UserGuide.md.bz2 | less"
	einfo "    ~$ bzip2 -dc usr/share/doc/termshark-${PV}/FAQ.md.bz2 | less\n"
}
