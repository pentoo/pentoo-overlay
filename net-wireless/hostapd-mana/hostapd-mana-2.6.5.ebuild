# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit python-r1 toolchain-funcs systemd savedconfig

DESCRIPTION="SensePost's modified hostapd for wifi attacks"
HOMEPAGE="https://w1f1.net https://github.com/sensepost/hostapd-mana"

if [[ $PV == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sensepost/hostapd-mana.git"
else
	SRC_URI="https://github.com/sensepost/hostapd-mana/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"
IUSE="+crackapd"

DEPEND="
	crackapd? ( ${PYTHON_DEPS} )
	dev-libs/openssl:0=[-bindist]
	dev-libs/libnl:3"

RDEPEND="${DEPEND}"

MY_PN="${PN%-mana}"
S="${S}/${MY_PN}"

src_prepare() {
	#sed -e "s:/etc/hostapd:/etc/${PN}:g" \
	#	-i "${S}/hostapd.conf" || die

	if use crackapd; then
		sed -e "s/THEPATH + str('crackapd.conf')/str('\/etc\/mana-toolkit\/crackapd.conf')/" \
			-i ../crackapd/crackapd.py || die
	fi

	# Allow users to apply patches to src/drivers for example,
	# i.e. anything outside ${S}/${MY_PN}
	pushd ../ >/dev/null || die
	default
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
	#insinto "/etc/${PN}"
	#doins ${MY_PN}.{conf,accept,deny,eap_user,radius_clients,sim_db,wpa_psk}

	newsbin ${MY_PN} hostapd-mana
	newbin ${MY_PN}_cli hostapd-mana_cli

	if use crackapd; then
		insinto "/etc/${PN}"

		pushd ../crackapd >/dev/null || die
		doins crackapd.conf
		python_foreach_impl python_newscript crackapd.py crackapd

		popd >/dev/null || die
	fi

	fperms -R 600 "/etc/${PN}"

	doman ${MY_PN}{.8,_cli.1}

	dodoc ChangeLog README

	docinto examples
	dodoc wired.conf

	save_config .config
}
