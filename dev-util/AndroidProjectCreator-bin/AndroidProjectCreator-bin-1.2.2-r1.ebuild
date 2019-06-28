# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="AndroidProjectCreator"

DESCRIPTION="Convert an APK to an Android Studio Project using multiple open-source decompilers"
HOMEPAGE="https://github.com/ThisIsLibra/AndroidProjectCreator"
SRC_URI="https://github.com/ThisIsLibra/${MY_PN}/releases/download/${PV}-stable/${MY_PN}-${PV}-stable-jar-with-dependencies.jar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

#to add:
# Fernflower, CFR, Procyon and JEB3
DEPEND="dev-util/jd-gui
	dev-util/jadx-bin"
RDEPEND="|| ( virtual/jre virtual/jdk )"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}"
}

src_install() {
	dodir /opt/"${MY_PN}"
	insinto /opt/"${MY_PN}"
	newins "${MY_PN}-${PV}-stable-jar-with-dependencies.jar" "${MY_PN}.jar"

	echo -e "#!/bin/sh\njava -jar /opt/${MY_PN}/${MY_PN}.jar \"\$@\" &\n" > "${MY_PN}"
	dobin ${MY_PN}
}
