# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

SUPPORT_PYTHON_ABIS="1"

inherit python

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="http://www.edge-security.com/theharvester.php"
SRC_URI="https://github.com/laramies/theHarvester/archive/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	python_convert_shebangs 2 theHarvester.py;
}

src_install() {
	installation() {
		insinto $(python_get_sitedir)
		doins myparser.py
		insinto $(python_get_sitedir)/discovery
		doins -r discovery/*
		insinto $(python_get_sitedir)/lib
		doins lib/*.py
	}
	python_execute_function installation
	newbin theHarvester.py theharvester
	dodoc README LICENSES
}

pkg_postinst() {
	python_mod_optimize discovery lib myparser.py
}

pkg_postrm() {
	python_mod_cleanup discovery lib myparser.py
}
