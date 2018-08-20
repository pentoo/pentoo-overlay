# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6} )
inherit distutils-r1

MY_P="${PN}2-${PV}"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/derv82/wifite2.git"
	KEYWORDS=""
else
#	SRC_URI="https://github.com/derv82/wifite2/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
#	S="${WORKDIR}/${MY_P}"
	MY_COMMIT="95798c36f6e2ff453125109fea7f220ca607ac6e"
	SRC_URI="https://github.com/derv82/wifite2/archive/${MY_COMMIT}.zip -> ${P}.zip"

	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${PN}2-${MY_COMMIT}"
fi

DESCRIPTION="An automated wireless attack tool"
HOMEPAGE="https://github.com/derv82/wifite2"

LICENSE="GPL-2"
SLOT="2"
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
