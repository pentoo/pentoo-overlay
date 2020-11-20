# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{6,7,8} )
inherit distutils-r1

MY_P="${PN}2-${PV}"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kimocoder/wifite2.git"
else
	SRC_URI="https://github.com/kimocoder/wifite2/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

DESCRIPTION="An automated wireless attack tool"
HOMEPAGE="https://github.com/derv82/wifite2"

LICENSE="GPL-2"
SLOT="2"
IUSE="dict opencl extra"

DEPEND=""
RDEPEND=""
PDEPEND="net-wireless/aircrack-ng[${PYTHON_USEDEP}]
	dev-python/pexpect[${PYTHON_USEDEP}]
	net-wireless/hcxdumptool
	net-wireless/hcxtools
	amd64? ( opencl? ( app-crypt/hashcat ) )
	dict? ( sys-apps/cracklib-words )
	extra? ( net-analyzer/wireshark
		net-wireless/reaver-wps-fork-t6x
		!net-wireless/reaver
		net-wireless/bully
		net-wireless/cowpatty
		net-analyzer/macchanger
	)"

#python2 only:
#net-wireless/pyrit[${PYTHON_USEDEP},opencl?]
