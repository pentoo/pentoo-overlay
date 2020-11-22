# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/xtaci/kcptun"
EGO_VENDOR=(
	"github.com/BurntSushi/toml v0.3.1"
	"github.com/coreos/go-iptables v0.4.2"
	"github.com/golang/snappy v0.0.1"
	"github.com/google/gopacket v1.1.17"
	"github.com/klauspost/cpuid v1.2.3"
	"github.com/klauspost/reedsolomon v1.9.3"
	"github.com/pkg/errors v0.9.1"
	"github.com/templexxx/cpu v0.0.1"
	"github.com/templexxx/cpufeat cef66df"
	"github.com/templexxx/xor f85b25d"
	"github.com/templexxx/xorsimd v0.4.1"
	"github.com/tjfoc/gmsm v1.3.0"
	"github.com/urfave/cli v1.21.0"
	"github.com/xtaci/kcp-go v5.4.20"
	"github.com/xtaci/kcp-go/v5 v5.5.14 github.com/xtaci/kcp-go"
	"github.com/xtaci/lossyconn 8df528c"
	"github.com/xtaci/smux v1.5.14"
	"github.com/xtaci/tcpraw v1.2.25"
	"golang.org/x/crypto 891825f github.com/golang/crypto"
	"golang.org/x/net 118fecf github.com/golang/net"
	"golang.org/x/sys 328b4cd github.com/golang/sys"
	"golang.org/x/text v0.3.0 github.com/golang/text"
)

inherit golang-vcs-snapshot

DESCRIPTION="A Stable & Secure Tunnel Based On KCP with N:M Multiplexing"
HOMEPAGE="https://github.com/xtaci/kcptun"

SRC_URI="https://github.com/xtaci/kcptun/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64 ~mips"
LICENSE="MIT"
IUSE="+server"
SLOT="0"

RESTRICT="mirror"

src_compile() {
	for x in client $(usev server); do
		CGO_ENABLED=0 GOPATH="${S}:$(get_golibdir_gopath)" \
			go build -v -work -x -ldflags "-X main.VERSION=${PV} -w" \
				-o "bin/${PN}-${x}" "${EGO_PN}/${x}" || die
	done
}

src_install() {
	dobin bin/${PN}-*
	dodoc "src/${EGO_PN}"/{README.md,Dockerfile}

	insinto "/etc/kcptun"
	for x in client $(usev server); do
		doins "${FILESDIR}"/example-${x}.json

		newinitd "${FILESDIR}"/kcptun-${x}.initd kcptun-${x}
		newconfd "${FILESDIR}"/kcptun-${x}.confd kcptun-${x}
	done
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
