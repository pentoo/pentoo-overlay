# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="oclHashcat-${PV}"

inherit eutils
DESCRIPTION="An opencl multihash cracker"
HOMEPAGE="http://hashcat.net/oclhashcat/"
SRC_URI="http://hashcat.net/files/${MY_P}.rar"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch mirror"

DEPEND="virtual/opencl-sdk
		app-arch/unrar"
RDEPEND="x11-drivers/nvidia-drivers"
S="${WORKDIR}/${MY_P}"

src_install() {
	dodoc example.*
	rm -f oclHashcat.exe example.* batchcrack.sh docs
	if use x86; then
		rm oclHashcat64.bin
	else
		rm oclHashcat32.bin
	fi
	dodir /usr/lib/${PN}
	cp -R "${S}"/* "${D}"/usr/lib/${PN} || die "Copy files failed"
	dobin ${FILESDIR}/oclhashcat  || die "dobin failed"
	chown -R root:0 "${D}"
}
