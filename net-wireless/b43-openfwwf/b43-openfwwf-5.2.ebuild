# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

DESCRIPTION="OpenBroadcom Firmware"
HOMEPAGE="http://www.ing.unibs.it/openfwwf/"
SRC_URI="http://netweb.ing.unibs.it/~openfwwf/firmware/openfwwf-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-wireless/b43-tools[assembler]"
S="${WORKDIR}/openfwwf-${PV}"

src_install() {
	emake PREFIX="${ED}"/lib/firmware/b43-open install
}
