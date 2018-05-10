# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 git-r3

DESCRIPTION="An automated wireless attack tool, v2"
HOMEPAGE="https://github.com/derv82/wifite2"
EGIT_REPO_URI="https://github.com/derv82/wifite2.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dict extra"

DEPEND=""
RDEPEND="net-wireless/aircrack-ng
	dev-python/pexpect
	dict? ( sys-apps/cracklib-words )
	extra? ( net-analyzer/wireshark
		net-wireless/reaver-wps-fork-t6x
		!net-wireless/reaver
		net-wireless/bully
		net-wireless/cowpatty
		net-wireless/pyrit
		net-analyzer/macchanger
	)"

src_prepare() {
	python_fix_shebang .
	eapply_user
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dosym  "${EPREFIX}"/usr/$(get_libdir)/${PN}/Wifite.py /usr/sbin/${PN}

#	newsbin Wifite.py wifite2
}
