# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MY_P="oclHashcat-lite-${PV}"

inherit eutils pax-utils
DESCRIPTION="An opencl hash cracker"
HOMEPAGE="http://hashcat.net/oclhashcat-lite/"

SRC_URI="http://hashcat.net/files/${MY_P}.7z"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE_VIDEO_CARDS="video_cards_fglrx
	video_cards_nvidia"

IUSE="${IUSE_VIDEO_CARDS}"

#without the 0.071 patch nvidia should be =275.43
RDEPEND="
	video_cards_nvidia? ( >=x11-drivers/nvidia-drivers-275.43 )
	video_cards_fglrx?  ( >=x11-drivers/ati-drivers-12.2 )"
DEPEND="${RDEPEND}
	app-arch/p7zip"

S="${WORKDIR}/${MY_P}"

RESTRICT="strip binchecks"

src_install() {
	#handle docs
	dodoc docs/*
	rm -rf *.exe docs

	#remove everything we don't need based on use flags
	if use x86; then
		rm oclHashcat-lite64.bin
		rm cudaHashcat-lite64.bin
		rm kernels/4098/*64* kernels/4318/*64*
	else
		rm oclHashcat-lite32.bin
		rm cudaHashcat-lite32.bin
		rm kernels/4098/*32* kernels/4318/*32*
	fi
	if ! use video_cards_fglrx; then
		rm -rf kernels/4098
		rm -rf oclHashcat-*.bin
	fi
	if ! use video_cards_nvidia; then
		rm -rf kernels/4318
		rm -rf cudaHashcat-*.bin
	fi
	pax-mark m *Hashcat*.bin

	insinto /opt/${PN}
	doins -r "${S}"/* || die "Copy files failed"

	dodir /usr/bin
	cd "${ED}/opt/oclhashcat-lite-bin/"
	echo '#! /bin/sh' > "${ED}"/usr/bin/oclhashcat-lite
	echo 'echo "oclHashcat-lite and all related files have been installed in /opt/oclhashcat-lite-bin"' >> "${ED}"/usr/bin/oclhashcat-lite
	echo 'echo "Please run one of the following binaries to use gpu accelerated hashcat:"' >> "${ED}"/usr/bin/oclhashcat-lite
	if [ -f "${ED}"/opt/oclhashcat-lite-bin/oclHashcat-lite64.bin ]
	then
		echo 'echo "64 bit ATI accelerated \"oclHashcat-lite64.bin\""' >> "${ED}"/usr/bin/oclhashcat-lite
		fperms +x /opt/oclhashcat-lite-bin/oclHashcat-lite64.bin
		dosym /opt/oclhashcat-lite-bin/oclHashcat-lite64.bin /usr/bin/oclHashcat-lite64.bin
	fi
	if [ -f "${ED}"/opt/oclhashcat-lite-bin/oclHashcat-lite32.bin ]
	then
		echo 'echo "32 bit ATI accelerated \"oclHashcat-lite32.bin\""' >> "${ED}"/usr/bin/oclhashcat-lite
		fperms +x /opt/oclhashcat-lite-bin/oclHashcat-lite32.bin
		dosym /opt/oclhashcat-lite-bin/oclHashcat-lite32.bin /usr/bin/oclHashcat-lite32.bin
	fi
	if [ -f "${ED}"/opt/oclhashcat-lite-bin/cudaHashcat-lite64.bin ]
	then
		echo 'echo "64 bit NVIDIA accelerated \"cudaHashcat-lite64.bin\""' >> "${ED}"/usr/bin/oclhashcat-lite
		fperms +x /opt/oclhashcat-lite-bin/cudaHashcat-lite64.bin
		dosym /opt/oclhashcat-lite-bin/cudaHashcat-lite64.bin /usr/bin/cudaHashcat-lite64.bin
	fi
	if [ -f "${ED}"/opt/oclhashcat-lite-bin/cudaHashcat-lite32.bin ]
	then
		echo 'echo "32 bit NVIDIA accelerated \"cudaHashcat-lite32.bin\""' >> "${ED}"/usr/bin/oclhashcat-lite
		fperms +x /opt/oclhashcat-lite-bin/cudaHashcat-lite32.bin
		dosym /opt/oclhashcat-lite-bin/cudaHashcat-lite32.bin /usr/bin/cudaHashcat-lite32.bin
	fi
	fperms +x /usr/bin/oclhashcat-lite
}
