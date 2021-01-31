# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="httptoolkit"

DESCRIPTION="Intercept & view all your HTTP(S) Mock endpoints"
HOMEPAGE="https://github.com/httptoolkit/httptoolkit.tech"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}-desktop/releases/download/v${PV}/HTTPToolkit-linux-x64-${PV}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}"

src_install() {
	dodir /opt/${MY_PN}
	cp -R "${S}"/* "${D}"/opt/${MY_PN} || die "Copy files failed"
	dosym "${EPREFIX}"/opt/${MY_PN}/${MY_PN} /usr/bin/${MY_PN}
}
