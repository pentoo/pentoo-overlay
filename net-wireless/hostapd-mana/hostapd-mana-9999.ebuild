# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit python-r1 toolchain-funcs savedconfig

MY_PN="hostapd"

DESCRIPTION="SensePost's modified hostapd for wifi attacks"
HOMEPAGE="https://w1f1.net https://github.com/sensepost/hostapd-mana"

if [[ $PV == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sensepost/hostapd-mana.git"
	S="${S}/${MY_PN}"
else
	HASH_COMMIT="1302a7204d9118efa0668df1924c938dbe8d1b11"
	SRC_URI="https://github.com/sensepost/hostapd-mana/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}/${MY_PN}"
fi

LICENSE="BSD"
SLOT="0"
IUSE="crda internal-tls netlink sqlite crackapd"

DEPEND="
	internal-tls? ( dev-libs/libtommath )
	!internal-tls? ( dev-libs/openssl:0=[-bindist(-)] )
	kernel_linux? (
		dev-libs/libnl:3
		crda? ( net-wireless/crda )
	)
	netlink? ( net-libs/libnfnetlink )
	sqlite? ( >=dev-db/sqlite-3 )"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"


src_prepare() {
	sed -e "s:/etc/hostapd:/etc/${PN}:g" -i ./hostapd.conf || die

	# Allow users to apply patches to src/drivers for example,
	# i.e. anything outside ${S}/${PN}
	pushd ../ >/dev/null || die
	default

	eapply "${FILESDIR}"/crackapd_pentoo.patch
	eapply "${FILESDIR}"/update_hostapd.conf.patch
	eapply "${FILESDIR}"/48.patch


	popd >/dev/null || die

}

src_configure() {
	restore_config .config
	default_src_configure
}

src_compile() {
	emake V=1
}

src_install() {
	insinto "/etc/${PN}"
	doins ${MY_PN}.{conf,accept,deny,eap_user,radius_clients,sim_db,wpa_psk}

	newsbin ${MY_PN} hostapd-mana
	newbin ${MY_PN}_cli hostapd-mana_cli

	if use crackapd; then
		insinto "/etc/${PN}"

		pushd ../crackapd >/dev/null || die
		doins "${FILESDIR}"/crackapd.conf
		python_foreach_impl python_newscript crackapd.py crackapd

		popd >/dev/null || die
	fi

	fperms -R 600 "/etc/${PN}"

	dodoc ChangeLog README

	save_config .config
}
