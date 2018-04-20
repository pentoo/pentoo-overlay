# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit distutils-r1 udev user linux-info gnome2-utils git-r3

DESCRIPTION="A Linux device manager for Logitech's Unifying Receiver peripherals"
HOMEPAGE="https://pwr.github.com/Solaar/"
EGIT_REPO_URI="https://github.com/pwr/Solaar.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND=">=dev-python/pyudev-0.13[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/gtk+:3[introspection]"

CONFIG_CHECK="~HID_LOGITECH_DJ ~HIDRAW"

python_prepare_all() {
	# don't autostart (bug #494608)
	sed -i '/yield autostart_path/d' setup.py || die

	# grant plugdev group rw access
	sed -i 's/#MODE=/MODE=/' rules.d/42-logitech-unify-permissions.rules || die

	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all

	udev_dorules rules.d/*.rules

	dodoc docs/devices.md
	if use doc; then
		dodoc -r docs/*
	fi
}

pkg_postinst() {
	enewgroup plugdev

	if [[ -z ${REPLACING_VERSIONS} ]] ; then
		elog "Users must be in the plugdev group to use this application."
	fi

	gnome2_icon_cache_update
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postrm() { gnome2_icon_cache_update; }
