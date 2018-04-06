# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="An automated wireless attack tool"
HOMEPAGE="https://github.com/derv82/wifite"
SRC_URI="https://github.com/derv82/wifite/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dict extra"

DEPEND=""
RDEPEND="net-wireless/aircrack-ng
	dev-python/pexpect
	dict? ( sys-apps/cracklib-words )
	extra? ( net-wireless/pyrit
		net-wireless/cowpatty
		net-analyzer/macchanger
		net-wireless/reaver-wps-fork-t6x
		!net-wireless/reaver
	)"

src_prepare() {
	python_fix_shebang .
	eapply_user
}

src_install() {
	newsbin wifite.py wifite
}
