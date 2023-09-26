# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for a freedesktop.org Secret Service API provider"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~ia64 ~loong ~mips ppc ppc64 ~riscv sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"

RDEPEND="|| (
	gnome-base/gnome-keyring
	app-admin/keepassxc
	>=kde-frameworks/kwallet-5.97
)"

IUSE="kde"
# TODO: add the KDE provider here once ready, still WIP as of June 2021 though
# (see https://bugs.kde.org/show_bug.cgi?id=313216)
# https://bugs.gentoo.org/880075

pkg_postinst() {
	if use kde; then
		ewarn "KDE users (kwallet) should use the following workaround:"
		ewarn "https://invent.kde.org/frameworks/kwallet/-/merge_requests/11#note_614022"
		ewarn "or apply the following patch"
		ewarn "https://invent.kde.org/frameworks/kwallet/-/merge_requests/67"
	fi
}
