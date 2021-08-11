# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="Insomnia.Core"

DESCRIPTION="REST API client, a postman alternative"
HOMEPAGE="https://github.com/Kong/insomnia https://insomnia.rest/"
SRC_URI="https://github.com/Kong/insomnia/releases/download/core%40${PV}/${MY_PN}-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}/${MY_PN}-${PV}"

QA_PREBUILT="/opt/Insomnia.Core/insomnia /opt/Insomnia.Core/chrome-sandbox
	/opt/Insomnia.Core/*.so"

src_install() {
	dodir /opt/${MY_PN}
	cp -R "${S}"/* "${D}"/opt/${MY_PN} || die "Copy files failed"
	dosym "${EPREFIX}"/opt/${MY_PN}/insomnia /usr/bin/insomnia
}
