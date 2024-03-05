# Copyright 2024-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="udev rules to assist in some way with hardware commonly used in pentoo"
HOMEPAGE="https://github.com/pentoo/pentoo-overlay"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
S="${WORKDIR}"

# No tests
RESTRICT="test"

RDEPEND="
	virtual/udev
"

src_install() {
	udev_dorules "${FILESDIR}"/99-pentoo.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
