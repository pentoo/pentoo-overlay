# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Tools to work with android .dex and java .class files"
HOMEPAGE="http://code.google.com/p/dex2jar/"
SRC_URI="http://dex2jar.googlecode.com/files/${P}.zip"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="|| ( virtual/jre virtual/jdk )"

src_prepare() {
	rm *.bat
	chmod a+x *.sh
	rm *.txt

	cd lib
	mv dx-NOTICE dx-NOTICE.txt
	rm *.txt
}

src_install() {
	dodir /opt/"${PN}"
	cp -R "${S}"/* "${D}/opt/"${PN}"" || die "Install failed!"

#d2j-apk-sign.sh
#d2j-asm-verify.sh
#d2j-dex-asmifier.sh
#d2j-dex-dump.sh
#d2j-dex2jar.sh
#d2j-init-deobf.sh
#d2j-jar-access.sh
#d2j-jar-remap.sh
#d2j-jar2dex.sh
#d2j-jar2jasmin.sh
#d2j-jasmin2jar.sh
#dex-dump.sh
	dosym /opt/dex2jar/dex2jar.sh /usr/bin/dex2jar
}
