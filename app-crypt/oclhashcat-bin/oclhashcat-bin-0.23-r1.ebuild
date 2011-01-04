# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="oclHashcat-${PV}"

inherit eutils pax-utils
DESCRIPTION="An opencl multihash cracker"
HOMEPAGE="http://hashcat.net/oclhashcat/"
SRC_URI="http://hashcat.net/files/${MY_P}.rar"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch mirror"

RDEPEND="|| ( x11-drivers/nvidia-drivers 
	      x11-drivers/ati-drivers )
	virtual/opencl-sdk"
DEPEND="${RDEPEND}
	app-arch/unrar"
S="${WORKDIR}/${MY_P}"

src_install() {
	dodoc example.* batchcrack.sh
	rm -rf oclHashcat.exe example.* batchcrack.sh docs
	if use x86; then
		rm oclHashcat64.bin
		pax-mark m oclHashcat32.bin
	else
		rm oclHashcat32.bin
		pax-mark m oclHashcat64.bin
	fi
	dodir /opt/${PN}
	cp -R "${S}"/* "${D}"/opt/${PN} || die "Copy files failed"
	dobin ${FILESDIR}/oclhashcat  || die "dobin failed"
	chown -R root:0 "${D}"
}
