# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="An automated wireless attack tool"
HOMEPAGE="https://github.com/kimocoder/wifite2"
LICENSE="GPL-2"
SLOT="2"
IUSE="dict opencl extra"

MY_P="${PN}2-${PV}"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kimocoder/wifite2.git"
else
	SRC_URI="https://github.com/kimocoder/wifite2/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/${MY_P}"
fi

RDEPEND="
	>=dev-python/chardet-7.7.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.34.2[${PYTHON_USEDEP}]
	>=dev-python/rich-15.0.0[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}]
	extra? ( !net-wireless/reaver )
"
DEPEND="${RDEPEND}"
PDEPEND="
	>=net-wireless/hcxdumptool-7.0.0
	>=net-wireless/hcxtools-7.0.0
	net-wireless/aircrack-ng
	amd64? ( opencl? ( >=app-crypt/hashcat-8.0.0 ) )
	dict? ( sys-apps/cracklib-words )
	extra? (
		net-analyzer/wireshark
		net-wireless/reaver-wps-fork-t6x
		net-wireless/bully
		net-wireless/cowpatty
		net-analyzer/macchanger
	)
"

RESTRICT="test"
