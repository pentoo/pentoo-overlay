# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Attack and Discovery Pattern Database for Application Fuzz Testing"
HOMEPAGE="https://code.google.com/p/fuzzdb/"
SRC_URI="http://fuzzdb.googlecode.com/files/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodir "/usr/share/${PN}/"
	cp -R "${S}"/* "${D}"/usr/share/"${PN}"/ || die "Install failed!"
}
