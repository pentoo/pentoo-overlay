# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="SocketCAN userspace utilities and tools"
HOMEPAGE="https://github.com/linux-can/can-utils"
SRC_URI="https://github.com/linux-can/can-utils/archive/v${PV}.tar.gz -> can-utils-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

src_prepare() {
	default

	eautoreconf
}

src_install() {

	emake DESTDIR="${D}" install

	einstalldocs
}
