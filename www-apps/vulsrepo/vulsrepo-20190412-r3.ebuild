# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/usiusi360/vulsrepo"
EGO_VENDOR=(
	"github.com/BurntSushi/toml v0.3.0"
	"github.com/abbot/go-http-auth v0.4.0"
)

inherit golang-vcs-snapshot user

DESCRIPTION="VulsRepo is visualized based on the json report output in vuls"
HOMEPAGE="https://vuls.io https://github.com/usiusi360/vulsrepo"

HASH_COMMIT="310e6fef185581ac1f75dfe55b84fd378b7437b7" # 20190412
SRC_URI="https://github.com/usiusi360/vulsrepo/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT=0

RDEPEND="app-admin/vuls"
DEPEND="${RDEPEND}
	dev-go/go-crypto:=
	dev-go/go-net:=
	>=dev-lang/go-1.12"

pkg_setup() {
	enewgroup vuls
	enewuser vuls -1 -1 "/var/lib/vuls" vuls
}

src_prepare() {
	eapply "${FILESDIR}"/vulsrepo_minor_fixes.patch
	default
}

src_compile() {
	cd src/"${EGO_PN}"/server || die

	GOPATH="${S}:$(get_golibdir_gopath)" \
		go build -v -work -x -ldflags="-s -w" -o vulsrepo-server || die
}

src_install() {
	cd src/"${EGO_PN}" || die

	insinto "/etc/vuls"
	doins "${FILESDIR}"/vulsrepo-config.toml.sample

	insinto "/var/lib/vuls/${PN}"
	doins -r plugins dist index.html

	keepdir "/var/log/vuls"
	fowners -R vuls:vuls "/var/lib/vuls" "/var/log/vuls" "/etc/vuls"
	fperms 0750 "/var/lib/vuls" "/var/log/vuls" "/etc/vuls"

	dobin server/vulsrepo-server

	newinitd "${FILESDIR}"/vulsrepo-server.initd vulsrepo-server

	dodoc README.md "${FILESDIR}"/vulsrepo-config.toml.sample
}

pkg_postinst() {
	einfo "\nSee documentation:"
	einfo "    https://vuls.io/docs/en/vulsrepo.html"
	einfo "    https://github.com/vulsdoc/vuls/blob/master/docs/vulsrepo.md\n"
}
