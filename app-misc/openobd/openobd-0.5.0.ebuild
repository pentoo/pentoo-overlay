# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="OBD-II Scan Tool supporting ELM327 devices"
HOMEPAGE="https://sourceforge.net/projects/openobd/"
SRC_URI="mirror://sourceforge/project/${PN}/Sources/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
