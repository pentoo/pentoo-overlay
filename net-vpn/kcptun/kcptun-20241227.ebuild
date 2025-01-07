# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGO_PN="github.com/xtaci/kcptun"

inherit go-module

DESCRIPTION="A Stable & Secure Tunnel Based On KCP with N:M Multiplexing"
HOMEPAGE="https://github.com/xtaci/kcptun"

SRC_URI="https://github.com/xtaci/kcptun/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~arm64"
LICENSE="MIT"
IUSE="+server"
SLOT="0"

src_compile() {
#	for x in client $(usev server); do
#		CGO_ENABLED=0 GOPATH="${S}:$(get_golibdir_gopath)" \
#			go build -v -work -x -ldflags "-X main.VERSION=${PV} -w" \
#				-o "bin/${PN}-${x}" "${EGO_PN}/${x}" || die
#	done
	./build-release.sh
}

src_install() {
#	dodoc "src/${EGO_PN}"/{README.md,Dockerfile}

	use amd64 && newbin build/client_linux_amd64 ${PN}-client
	use arm64 && newbin build/client_linux_arm64 ${PN}-client

	use amd64 && use server && newbin build/server_linux_amd64 ${PN}-server
	use arm64 && use server && newbin build/server_linux_arm64 ${PN}-server

	insinto "/etc/kcptun"
	for x in client $(usev server); do
		doins "${FILESDIR}"/example-${x}.json

		newinitd "${FILESDIR}"/kcptun-${x}.initd kcptun-${x}
		newconfd "${FILESDIR}"/kcptun-${x}.confd kcptun-${x}
	done
	default
}

pkg_postinst() {
	ewarn "\nSuggested \"/etc/sysctl.conf\" parameters for better handling of UDP packets:"
	ewarn "    net.core.rmem_max=26214400 // BDP - bandwidth delay product"
	ewarn "    net.core.rmem_default=26214400"
	ewarn "    net.core.wmem_max=26214400"
	ewarn "    net.core.wmem_default=26214400"
	ewarn "    net.core.netdev_max_backlog=2048 // proportional to -rcvwnd"

	einfo "\nSee documentation:"
	einfo "    https://github.com/xtaci/kcptun#quickstart"
	einfo "    https://github.com/skywind3000/kcp/blob/master/README.en.md\n"
}
