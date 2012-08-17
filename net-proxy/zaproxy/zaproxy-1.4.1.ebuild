# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MY_PN="ZAP"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="An easy to use integrated penetration testing tool for finding vulnerabilities in web applications"
HOMEPAGE="http://code.google.com/p/zaproxy/"
SRC_URI="http://zaproxy.googlecode.com/files/${MY_P}_Linux.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="|| ( virtual/jre virtual/jdk )
	app-fuzz/fuzzdb"

S=${WORKDIR}/${MY_P}

#src_prepare() {
#	rm *.bat
#	chmod a+x *.sh
#	rm *.txt

#	cd lib
#	mv dx-NOTICE dx-NOTICE.txt
#	rm *.txt
#}

src_install() {
	dodir /opt/"${PN}"
	cp -R "${S}"/* "${D}/opt/"${PN}"" || die "Install failed!"
	dosym /opt/"${PN}"/zap.sh /usr/bin/zaproxy
}
