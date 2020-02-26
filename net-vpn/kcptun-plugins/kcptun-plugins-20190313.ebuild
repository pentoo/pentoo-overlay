# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="SIP003-compatible KCPTUN and UDP2RAW plugins for Shadowsocks"
HOMEPAGE="https://github.com/w1ndy/kcptun-plugins"

if [[ "${PV}" == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/w1ndy/kcptun-plugins"
else
	# snapshot: 20190313
	HASH_COMMIT="b3f076a4bfa99dd88ce08d9e4192feddd2b4e4ea"

	SRC_URI="https://github.com/w1ndy/kcptun-plugins/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~x86"
	S="${WORKDIR}"/${PN}-${HASH_COMMIT}
fi

LICENSE="Unlicense"
IUSE=""
SLOT="0"
RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	sed -e "s:/usr/local/kcptun_plugins:/usr/share/${PN}:" \
		-e "s:source ./lib:source /usr/share/${PN}/lib:" \
		-i kcptun-{client,server}-plugin || die 'sed failed!'

	eapply_user
}

src_compile() {
	:
}

src_install() {
	insinto "/usr/share/${PN}"
	doins lib

	exeinto "/usr/share/${PN}"
	doexe kcptun-{client,server}-plugin

	dosym "../share/${PN}/kcptun-client-plugin" "/usr/bin/kcptun-client-plugin"
	dosym "../share/${PN}/kcptun-server-plugin" "/usr/bin/kcptun-server-plugin"
	dodoc README.md
	dobin ss-proxy
}
