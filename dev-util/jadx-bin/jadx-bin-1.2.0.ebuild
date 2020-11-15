# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="jadx"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A standalone graphical utility that displays Java source codes of .class file"
HOMEPAGE="https://github.com/skylot/jadx"
SRC_URI="https://github.com/skylot/jadx/releases/download/v${PV}/${MY_P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/jre"

S="${WORKDIR}"

src_prepare() {
	sed -e 's|APP_HOME="`pwd -P`"|APP_HOME="/opt/jadx-bin/"|' -i bin/${MY_PN} || die "sed failed"
	sed -e 's|APP_HOME="`pwd -P`"|APP_HOME="/opt/jadx-bin/"|' -i bin/${MY_PN}-gui || die "sed failed"
	eapply_user
}

src_install() {
	dodir /opt/"${PN}"
	insinto /opt/"${PN}"
	doins -r lib/

#	doicon jd_icon_128.png
#	domenu jd-gui.desktop

#	echo -e "#!/bin/sh\njava -jar /opt/${MY_PN}/${MY_P}.jar >/dev/null 2>&1 &\n" > "${MY_PN}"
	dobin "bin/${MY_PN}"
	dobin "bin/${MY_PN}-gui"
}
