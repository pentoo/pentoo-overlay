# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Identifies and fingerprints Web Application Firewall (WAF) products"
HOMEPAGE="https://github.com/sandrogauci/wafw00f"
SRC_URI="mirror://pypi/$(echo ${PN} | cut -c 1)/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/beautifulsoup:4
	>=dev-python/pluginbase-0.3
	"

#src_install() {
#	dobin wafw00f.py
#	sed -i "s:libs.evillib:evillib:" "${D}"/usr/bin/wafw00f.py || die "sed failed"
#	insinto $(python_get_sitedir)
#	doins libs/evillib.py
#}
