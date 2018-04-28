# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_RND_PN="dex-tools-2.1-SNAPSHOT"

DESCRIPTION="Tools to work with android .dex and java .class files"
HOMEPAGE="https://github.com/pxb1988/dex2jar/releases"
SRC_URI="https://github.com/pxb1988/dex2jar/files/1867564/${MY_RND_PN}.zip -> ${MY_RND_PN}-20180327402.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="|| ( virtual/jre virtual/jdk )"

S="${WORKDIR}/${MY_RND_PN}"

src_prepare() {
	rm *.bat
	chmod a+x *.sh
	rm *.txt
	cd lib
	rm *.txt

	eapply_user
}

src_install() {
	dodir /opt/"${PN}"
	cp -R "${S}"/* "${ED}/opt/"${PN}"" || die "Install failed!"
	for i in *.sh; do
		dosym /opt/dex2jar/${i} /usr/bin/${i##*/}
	done
}
