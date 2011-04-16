# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enable/enable-3.0.2.ebuild,v 1.2 2009/01/15 11:20:43 bicatali Exp $

EAPI=3

PYTHON_DEPEND="2"

inherit eutils distutils python

DESCRIPTION="Powerful event library enabling asyncronous and event-driven applications and system to be developed"
HOMEPAGE="http://pypi.python.org/pypi/pymills"
SRC_URI="http://pypi.inqbus.de/${PN}/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="amd64 x86"
LICENSE="BSD"

RDEPEND=""
DEPEND="dev-python/setuptools"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mv "${P}" "${PN}"
}
