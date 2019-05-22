# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 multilib

DESCRIPTION="A wireless tool to do direct connection to client without passing through an AP"
HOMEPAGE="http://sid.rstack.org/index.php/Wifitap_EN"
SHA="f7ac906855cadb1c5a0a619d1e9e924802a9d6c6"
SRC_URI="https://github.com/s0lst1c3/wifitap/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"/"${PN}-${SHA}"

DEPEND="net-analyzer/scapy"

src_install() {
	python_newscript wifiarp.py wifiarp
	python_newscript wifidns.py wifidns
	python_newscript wifiping.py wifiping
	python_newscript wifitap.py wifitap
	# also install util.py, required by all scripts
	python_domodule utils.py

	dodoc AUTHORS README.md Changelog
}
