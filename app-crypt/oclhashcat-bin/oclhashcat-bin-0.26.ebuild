# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MY_P="oclHashcat-${PV}"
MY_A="${MY_P}".7z

inherit eutils pax-utils
DESCRIPTION="An opencl multihash cracker"
HOMEPAGE="http://hashcat.net/oclhashcat/"

SRC_URI="http://hashcat.net/files/${MY_A}"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( >=x11-drivers/nvidia-drivers-260
	      >=x11-drivers/ati-drivers-10.12 )
	virtual/opencl-sdk"
DEPEND="${RDEPEND}
	app-arch/p7zip"
S="${WORKDIR}/${MY_P}"

RESTRICT="strip binchecks"

src_install() {
	dodoc *Example.* docs/*
	rm -rf *.exe *Example.* docs
	if use x86; then
		rm oclHashcat64.bin
		rm cudaHashcat64.bin
		pax-mark m oclHashcat32.bin
		pax-mark m cudaHashcat32.bin
	else
		rm oclHashcat32.bin
		rm cudaHashcat32.bin
		pax-mark m oclHashcat64.bin
		pax-mark m cudaHashcat64.bin
	fi
	insinto /opt/${PN}
	doins -r "${S}"/* || die "Copy files failed"
	dobin "${FILESDIR}"/oclhashcat  || die "dobin failed"
	chown -R root:0 "${D}"
}
