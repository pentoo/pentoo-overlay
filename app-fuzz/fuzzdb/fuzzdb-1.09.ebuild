# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Attack and Discovery Pattern Database for Application Fuzz Testing"
HOMEPAGE="https://code.google.com/p/fuzzdb/"
SRC_URI="http://fuzzdb.googlecode.com/files/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodir "/usr/share/${PN}/"
	cp -R "${S}"/* "${D}"/usr/share/"${PN}"/ || die "Install failed!"
}
