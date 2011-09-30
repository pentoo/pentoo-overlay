# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MY_P="oclHashcat-plus-${PV}"
MY_A="${MY_P}".7z

inherit eutils pax-utils
DESCRIPTION="An opencl multihash cracker"
HOMEPAGE="http://hashcat.net/oclhashcat-plus/"

SRC_URI="http://hashcat.net/files/${MY_A}"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE_VIDEO_CARDS="video_cards_fglrx
	video_cards_nvidia"

IUSE="opencl ${IUSE_VIDEO_CARDS}"

RDEPEND="
	video_cards_nvidia? ( >=x11-drivers/nvidia-drivers-260 )
	video_cards_fglrx?  ( >=x11-drivers/ati-drivers-10.12 )
	opencl? ( virtual/opencl-sdk )"
DEPEND="${RDEPEND}
	app-arch/p7zip
"
S="${WORKDIR}/${MY_P}"

RESTRICT="strip binchecks"

src_install() {
	dodoc docs/*
	rm -rf *.exe docs
	if use x86; then
		rm oclHashcat-plus64.bin
		rm cudaHashcat-plus64.bin
		pax-mark m oclHashcat-plus32.bin
		pax-mark m cudaHashcat-plus32.bin
	else
		rm oclHashcat-plus32.bin
		rm cudaHashcat-plus32.bin
		pax-mark m oclHashcat-plus64.bin
		pax-mark m cudaHashcat-plus64.bin
	fi
	insinto /opt/${PN}
	doins -r "${S}"/* || die "Copy files failed"
	dobin "${FILESDIR}"/oclhashcat-plus  || die "dobin failed"
	chown -R root:0 "${D}"
}
