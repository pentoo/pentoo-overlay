# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 eutils git-r3

DESCRIPTION="An automated wireless attack tool, v2"
HOMEPAGE="https://github.com/derv82/wifite2"
EGIT_REPO_URI="https://github.com/derv82/wifite2.git"
#EGIT_COMMIT="293c05a80c7357498a5609ae1223579bf9a0ced0"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dict cuda extra"

DEPEND=""
RDEPEND="net-wireless/aircrack-ng
	dev-python/pexpect
	dict? ( sys-apps/cracklib-words )
	extra? ( net-wireless/pyrit[cuda?]
		net-wireless/cowpatty
		net-analyzer/macchanger
		net-wireless/reaver-wps-fork-t6x
		!net-wireless/reaver
	)"

src_prepare() {
	python_fix_shebang .
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dosym  /usr/$(get_libdir)/${PN}/Wifite.py /usr/sbin/${PN}

#	newsbin Wifite.py wifite2
}
