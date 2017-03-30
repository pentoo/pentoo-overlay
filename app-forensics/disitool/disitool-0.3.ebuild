# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

#FIXME: migrate to new python eclass
#PYTHON_DEPEND="2"

#inherit python

MY_P="${PN}_v${PV//./_}"
SRC_URI="http://www.didierstevens.com/files/software/${MY_P}.zip"
DESCRIPTION="This tool will allow the manipulation of Authenticode digital
signatures"
HOMEPAGE="http://blog.didierstevens.com/programs/disitool/"

LICENSE="public-domain"
SLOT="0"
#KEYWORDS="amd64 ~arm x86"
IUSE=""
RDEPEND=""
DEPEND="app-arch/unzip"

S="${WORKDIR}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	newbin "${PN}.py" "${PN}"
}
