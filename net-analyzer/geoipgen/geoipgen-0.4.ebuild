# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Generate a list of hostnames based on country"
HOMEPAGE="http://www.morningstarsecurity.com/research/geoipgen"
SRC_URI="http://geoipgen.googlecode.com/files/$P.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/ruby
		 dev-libs/geoip
		 app-arch/unzip"

src_prepare() {
	# fix db path
	sed -i 's|/usr/local/share/|/etc/maxmind/|g' ${PN} || die
}

src_install() {
	dobin ${PN} || die
	dodoc README CHANGELOG TODO || die
}

pkg_postinst() {
	elog "For ${PN} to work you have to download"
	elog "http://www.maxmind.com/download/geoip/database/GeoIPCountryCSV.zip"
	elog "save it to /etc/maxmind and unzip it"
}
