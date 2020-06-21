# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV=( $(ver_cut 1-2) )
MY_PV_PRE="20150601.060031-26"

DESCRIPTION="Tools to work with android .dex and java .class files"
HOMEPAGE="https://github.com/pxb1988/dex2jar/releases"
SRC_URI="https://github.com/pxb1988/dex2jar/releases/download/${MY_PV}-nightly-26/dex-tools-${MY_PV}-${MY_PV_PRE}.zip"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="|| ( virtual/jre virtual/jdk )"

S="${WORKDIR}/${PN}-${MY_PV}-SNAPSHOT"

src_prepare() {
	rm *.bat
	chmod a+x *.sh
	rm *.txt

	cd lib
	rm *.txt
}

src_install() {
	dodir /opt/"${PN}"
	cp -R "${S}"/* "${ED}/opt/"${PN}"" || die "Install failed!"
	for i in *.sh; do
		dosym ${i} /usr/bin/${i##*/}
	done
}
