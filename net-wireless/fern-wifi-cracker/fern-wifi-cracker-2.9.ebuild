# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite"

inherit eutils desktop python-r1 xdg-utils

DESCRIPTION="Wireless tool for WEP/WPA cracking and WPS keys recovery"
HOMEPAGE="https://github.com/savio-code/fern-wifi-cracker"
SRC_URI="https://github.com/savio-code/fern-wifi-cracker/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dict policykit"

DEPEND=""
RDEPEND="${PYTHON_DEPS}
	dev-python/PyQt5[gui,widgets,${PYTHON_USEDEP}]
	net-analyzer/macchanger
	net-wireless/aircrack-ng
	net-analyzer/scapy
	dict? ( sys-apps/cracklib-words )
	|| ( net-wireless/reaver-wps-fork-t6x net-wireless/reaver )
	policykit? ( sys-auth/polkit )"

S="${WORKDIR}/${P}/Fern-Wifi-Cracker"

pkg_setup() {
	python_setup
}

src_prepare() {
	# disable updates
	sed \
		-e "s|self.connect(self.update_button|#self.connect(self.update_button|" \
		-i core/fern.py || die
	sed \
		-e "s|thread.start_new_thread(self.update_initializtion_check|#thread.start_new_thread(self.update_initializtion_check|" \
		-i core/fern.py || die

	python_fix_shebang "${S}"

	default
}

src_install() {
	insinto "/usr/share/fern-wifi-cracker"
	doins -r *
	python_optimize "${ED%/}/usr/share/fern-wifi-cracker"

	dosym "../fern-wifi-cracker/resources/icon.png" "/usr/share/pixmaps/${PN}.png"

	make_wrapper $PN \
		"python2 /usr/share/fern-wifi-cracker/execute.py"

	if use policykit; then
		insinto "/usr/share/polkit-1/actions/"
		doins "${FILESDIR}"/com.fern-pro.pkexec.fern-wifi-cracker.policy

		make_desktop_entry \
			"pkexec /usr/bin/${PN}" \
			"Fern Wifi Cracker" \
			"${PN}" \
			"System;Security;X-Pentoo;X-Penetration;X-Wireless;"
	else
		make_desktop_entry \
			"$PN" \
			"Fern Wifi Cracker" \
			"$PN" \
			"System;Security;X-Pentoo;X-Penetration;X-Wireless;"
	fi

	dodoc ../README.md
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
