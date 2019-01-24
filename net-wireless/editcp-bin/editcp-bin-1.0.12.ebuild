# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="editcp"
DESCRIPTION=""
HOMEPAGE="https://www.farnsworth.org/dale/codeplug/editcp"
SRC_URI="${HOMEPAGE}/downloads/linux/${MY_PN}-${PV}.tar.xz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/libusb:1"

S="${WORKDIR}/${MY_PN}-${PV}"

QA_FLAGS_IGNORED='.*'

RESTRICT="strip"

src_prepare() {
	default
	sed -i -e "s#^dirname=#dirname=/opt/${MY_PN}#" ${MY_PN}.sh || die
	grep -q "^dirname=/opt/${MY_PN}" ${MY_PN}.sh ||
		die "sed change failed"
}

src_install() {
	rm install
	dodir /opt/${MY_PN}
	exeinto /opt/${MY_PN}
	doexe *.sh editcp
	cp -a lib plugins "${D}"/opt/${MY_PN}
	dosym  /opt/${MY_PN}/${MY_PN}.sh /opt/bin/${MY_PN}
}
