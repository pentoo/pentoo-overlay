# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MY_P="oclHashcat-plus-${PV}"

inherit eutils pax-utils
DESCRIPTION="An opencl multihash cracker"
HOMEPAGE="http://hashcat.net/oclhashcat-plus/"

SRC_URI="http://hashcat.net/files/oclHashcat-plus-0.07.7z \
	http://hashcat.net/files/${MY_P}.7z"

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

#S="${WORKDIR}/${MY_P}"
S="${WORKDIR}/oclHashcat-plus-0.07"

RESTRICT="strip binchecks"

src_prepare() {
	#here we combine the 0.07 and the 0.071 patch
	mv -f "${WORKDIR}"/*.bin "${S}"
	rm -rf ${WORKDIR}/*.exe
}

src_install() {
	dodoc docs/*
	rm -rf *.exe docs
	if use x86; then
		rm oclHashcat-plus64.bin
		rm cudaHashcat-plus64.bin
		rm kernels/4098/*64* kernels/4318/*64*
		pax-mark m oclHashcat-plus32.bin
		pax-mark m cudaHashcat-plus32.bin
	else
		rm oclHashcat-plus32.bin
		rm cudaHashcat-plus32.bin
		rm kernels/4098/*32* kernels/4318/*32*
		pax-mark m oclHashcat-plus64.bin
		pax-mark m cudaHashcat-plus64.bin
	fi
	if ! use video_cards_fglrx; then
		rm -rf kernels/4098
	fi
	if ! use video_cards_nvidia; then
		rm -rf kernels/4318
	fi

	#already in aircrack-ng
	rm -rf contrib/aircrack-ng_r1959

	insinto /opt/${PN}
	doins -r "${S}"/* || die "Copy files failed"

	dodir /usr/bin
	cd "${ED}/opt/oclHashcat-plus-bin/"
	echo '#! /bin/sh' > "${ED}"/usr/bin/oclhashcat-plus
	echo 'echo "oclHashcat-plus and all related files have been installed in /opt/oclhashcat-plus-bin"' >> "${ED}"/usr/bin/oclhashcat-plus
	echo 'echo "Please run one of the following binaries to use gpu accelerated hashcat:"' >> "${ED}"/usr/bin/oclhashcat-plus
	if [ -f "${ED}"/opt/oclhashcat-plus-bin/oclHashcat-plus64.bin ]
	then
		echo '64 bit ATI accelerated "oclHashcat-plus64.bin"' >> "${ED}"/usr/bin/oclhashcat-plus
		fperms +x /opt/oclhashcat-plus-bin/oclHashcat-plus64.bin
		dosym /opt/oclhashcat-plus-bin/oclHashcat-plus64.bin /usr/bin/oclHashcat-plus64.bin
	fi
	if [ -f "${ED}"/opt/oclhashcat-plus-bin/oclHashcat-plus32.bin ]
	then
		echo '32 bit ATI accelerated "oclHashcat-plus32.bin"' >> "${ED}"/usr/bin/oclhashcat-plus
		fperms +x /opt/oclhashcat-plus-bin/oclHashcat-plus32.bin
		dosym /opt/oclhashcat-plus-bin/oclHashcat-plus32.bin /usr/bin/oclHashcat-plus32.bin
	fi
	if [ -f "${ED}"/opt/oclhashcat-plus-bin/cudaHashcat-plus64.bin ]
	then
		echo '64 bit NVIDIA accelerated "cudaHashcat-plus64.bin"' >> "${ED}"/usr/bin/oclhashcat-plus
		fperms +x /opt/oclhashcat-plus-bin/cudaHashcat-plus64.bin
		dosym /opt/oclhashcat-plus-bin/cudaHashcat-plus64.bin /usr/bin/cudaHashcat-plus64.bin
	fi
	if [ -f "${ED}"/opt/oclhashcat-plus-bin/cudaHashcat-plus32.bin ]
	then
		echo '32 bit NVIDIA accelerated "cudaHashcat-plus32.bin"' >> "${ED}"/usr/bin/oclhashcat-plus
		fperms +x /opt/oclhashcat-plus-bin/cudaHashcat-plus32.bin
		dosym /opt/oclhashcat-plus-bin/cudaHashcat-plus32.bin /usr/bin/cudaHashcat-plus32.bin
	fi
	fperms +x /usr/bin/oclhashcat-plus
	fowners -R root:root "${ED}"
}
