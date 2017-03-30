# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
PYTHON_COMPAT=( python2_7 )
inherit python-r1 multilib

DESCRIPTION="A wireless tool to do direct connection to client without passing through an AP"
HOMEPAGE="http://sid.rstack.org/index.php/Wifitap_EN"
SHA="2b160883628456e64ee6663fa9d06da3715691fd"
SRC_URI="https://github.com/GDSSecurity/wifitap/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"/"${PN}-${SHA}"

DEPEND="net-analyzer/scapy
	dev-python/gnuplot-py
	dev-python/pyx"


src_install() {
	exeinto /usr/bin
	newexe wifitap.py wifitap
	newexe wifidns.py wifidns
	newexe wifiping.py wifiping

	# also install scapy as a importable python module
	insinto /usr/$(get_libdir)/python2.7/site-packages
	rm scapy.py
	doins *.py

	dodoc AUTHORS README Changelog BUGS TODO
}
