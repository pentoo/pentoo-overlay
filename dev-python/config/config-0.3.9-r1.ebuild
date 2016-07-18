# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_3} )
inherit distutils-r1

DESCRIPTION="This module allows a hierarchical configuration scheme with support for mappings and sequences"
HOMEPAGE="http://www.red-dove.com/python_config.html"
SRC_URI="mirror://pypi/c/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""
