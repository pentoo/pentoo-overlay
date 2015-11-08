# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="An enhanced HTTP URL Scanner and fuzzer"
HOMEPAGE="http://www.scrt.ch/pages/outils.html"
SRC_URI="http://www.scrt.ch/outils/${PN}/ws110.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~arm"
IUSE="nmap"

RDEPEND="dev-lang/python
	>=dev-python/wxpython-2.8.9.0
	nmap? ( net-analyzer/nmap )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	elog "Running unattendend config"
	sed -i -e "s/raw_input.*/\'\'/" setup.linux.py
	sed -i -e "/^path_prefix/ s:=.*:= \'/usr/lib/webshag/\':" setup.linux.py
	sed -i -e "/codecs.open/ s:(cfg_file:(u\'config/webshag.conf\':g" setup.linux.py
	sed -i -e "/codecs.open/ s:(core_file:(u\'webshag/core/core_file.py\':g" setup.linux.py
}

src_configure() {
	python setup.linux.py
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R "${S}"/* "${ED}"/usr/$(get_libdir)/${PN}
	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}
	dosym "/usr/lib/${PN}/${PN}_cli.py" "/usr/sbin/${PN}_cli.py"
	dosym "/usr/lib/${PN}/${PN}_gui.py" "/usr/sbin/${PN}_gui.py"
	einfo "You can register a live ID at live.com and use it inside"
	einfo "webshag for special features"
}
