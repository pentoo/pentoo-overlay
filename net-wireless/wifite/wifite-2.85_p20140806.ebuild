# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 eutils git-2

DESCRIPTION="An automated wireless attack tool"
HOMEPAGE="https://github.com/derv82/wifite"
#SRC_URI="http://wifite.googlecode.com/svn-history/r${AVC[1]}/trunk/wifite.py -> ${P}.py"
EGIT_REPO_URI="https://github.com/derv82/wifite.git"
EGIT_COMMIT="fd486ba7d4714cc79405eb895d3808b0f9928472"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm amd64 x86"
IUSE="dict cuda extra"

DEPEND=""
RDEPEND="net-wireless/aircrack-ng
	dev-python/pexpect
	dict? ( sys-apps/cracklib-words )
	extra? ( app-crypt/pyrit[cuda?]
		net-wireless/cowpatty
		net-analyzer/macchanger
		net-wireless/reaver )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2014_noupgrade.patch
#	epatch "${FILESDIR}"/${PN}-tshark.patch
	python_fix_shebang .
}

src_install() {
	newsbin wifite.py wifite
}
