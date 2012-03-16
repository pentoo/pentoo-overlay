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

RDEPEND="
	video_cards_nvidia? ( >=x11-drivers/nvidia-drivers-275.43 )
	video_cards_fglrx?  ( >=x11-drivers/ati-drivers-12.2 )"
DEPEND="${RDEPEND}
	app-arch/p7zip"

S="${WORKDIR}/${MY_P}"

RESTRICT="strip binchecks"

src_install() {
	dodoc docs/*
	rm -rf *.exe docs
	if use x86; then
		rm oclHashcat-lite64.bin
		rm cudaHashcat-lite64.bin
		rm kernels/4098/*64* kernels/4318/*64*
	fi
	if use amd64; then
		rm oclHashcat-lite32.bin
		rm cudaHashcat-lite32.bin
		rm kernels/4098/*32* kernels/4318/*32*
	fi
	if ! use video_cards_fglrx; then
		rm -rf kernels/4098
		rm -f oclHashcat-lite*.bin
	fi
	if ! use video_cards_nvidia; then
		rm -rf kernels/4318
		rm -f cudaHashcat-lite*.bin
	fi
	pax-mark m *Hashcat-lite*.bin

	#already in aircrack-ng
	rm -rf contrib/aircrack-ng_r1959

	insinto /opt/${PN}
	doins -r "${S}"/* || die "Copy files failed"

	dodir /usr/bin
	cd "${ED}/opt/oclHashcat-lite-bin/"
	echo '#! /bin/sh' > "${ED}"/usr/bin/oclhashcat-lite
	echo 'echo "oclHashcat-lite and all related files have been installed in /opt/oclhashcat-lite-bin"' >> "${ED}"/usr/bin/oclhashcat-lite
	echo 'echo "Please run one of the following binaries to use gpu accelerated hashcat:"' >> "${ED}"/usr/bin/oclhashcat-lite
	if [ -f "${ED}"/opt/oclhashcat-lite-bin/oclHashcat-lite64.bin ]
	then
		echo 'echo "64 bit ATI accelerated \"oclHashcat-lite64.bin\""' >> "${ED}"/usr/bin/oclhashcat-lite
		fperms +x /opt/oclhashcat-lite-bin/oclHashcat-lite64.bin
		#dosym /opt/oclhashcat-lite-bin/oclHashcat-lite64.bin /usr/bin/oclHashcat-lite64.bin
		#workaround for need to be run from /opt/oclHashcat-lite-bin
		echo '#! /bin/sh' > "${ED}"/usr/bin/oclHashcat-lite64.bin
		echo 'cd /opt/oclhashcat-lite-bin' >> "${ED}"/usr/bin/oclHashcat-lite64.bin
		echo 'echo "Warning: oclHashcat-lite64.bin is running from $(pwd) so be careful of relative paths."' >> "${ED}"/usr/bin/oclHashcat-lite64.bin
		echo './oclHashcat-lite64.bin $@' >> "${ED}"/usr/bin/oclHashcat-lite64.bin
		fperms +x /usr/bin/oclHashcat-lite64.bin

	fi
	if [ -f "${ED}"/opt/oclhashcat-lite-bin/oclHashcat-lite32.bin ]
	then
		echo 'echo "32 bit ATI accelerated \"oclHashcat-lite32.bin\""' >> "${ED}"/usr/bin/oclhashcat-lite
		fperms +x /opt/oclhashcat-lite-bin/oclHashcat-lite32.bin
		#dosym /opt/oclhashcat-lite-bin/oclHashcat-lite32.bin /usr/bin/oclHashcat-lite32.bin
		#workaround for need to be run from /opt/oclHashcat-lite-bin
		echo '#! /bin/sh' > "${ED}"/usr/bin/oclHashcat-lite32.bin
		echo 'cd /opt/oclhashcat-lite-bin' >> "${ED}"/usr/bin/oclHashcat-lite32.bin
		echo 'echo "Warning: oclHashcat-lite32.bin is running from $(pwd) so be careful of relative paths."' >> "${ED}"/usr/bin/oclHashcat-lite32.bin
		echo './oclHashcat-lite32.bin $@' >> "${ED}"/usr/bin/oclHashcat-lite32.bin
		fperms +x /usr/bin/oclHashcat-lite32.bin
	fi
	if [ -f "${ED}"/opt/oclhashcat-lite-bin/cudaHashcat-lite64.bin ]
	then
		echo 'echo "64 bit NVIDIA accelerated \"cudaHashcat-lite64.bin\""' >> "${ED}"/usr/bin/oclhashcat-lite
		fperms +x /opt/oclhashcat-lite-bin/cudaHashcat-lite64.bin
		#dosym /opt/oclhashcat-lite-bin/cudaHashcat-lite64.bin /usr/bin/cudaHashcat-lite64.bin
		#workaround for need to be run from /opt/oclHashcat-lite-bin
		echo '#! /bin/sh' > "${ED}"/usr/bin/cudaHashcat-lite64.bin
		echo 'cd /opt/oclhashcat-lite-bin' >> "${ED}"/usr/bin/cudaHashcat-lite64.bin
		echo 'echo "Warning: cudaHashcat-lite64.bin is running from $(pwd) so be careful of relative paths."' >> "${ED}"/usr/bin/cudaHashcat-lite64.bin
		echo './cudaHashcat-lite64.bin $@' >> "${ED}"/usr/bin/cudaHashcat-lite64.bin
		fperms +x /usr/bin/cudaHashcat-lite64.bin

	fi
	if [ -f "${ED}"/opt/oclhashcat-lite-bin/cudaHashcat-lite32.bin ]
	then
		echo 'echo 32 bit NVIDIA accelerated \"cudaHashcat-lite32.bin\""' >> "${ED}"/usr/bin/oclhashcat-lite
		fperms +x /opt/oclhashcat-lite-bin/cudaHashcat-lite32.bin
		#dosym /opt/oclhashcat-lite-bin/cudaHashcat-lite32.bin /usr/bin/cudaHashcat-lite32.bin
		#workaround for need to be run from /opt/oclHashcat-lite-bin
		echo '#! /bin/sh' > "${ED}"/usr/bin/cudaHashcat-lite32.bin
		echo 'cd /opt/oclhashcat-lite-bin' >> "${ED}"/usr/bin/cudaHashcat-lite32.bin
		echo 'echo "Warning: cudaHashcat-lite32.bin is running from $(pwd) so be careful of relative paths."' >> "${ED}"/usr/bin/cudaHashcat-lite32.bin
		echo './cudaHashcat-lite32.bin $@' >> "${ED}"/usr/bin/cudaHashcat-lite32.bin
		fperms +x /usr/bin/oclHashcat-lite32.bin
	fi
	fperms +x /usr/bin/oclhashcat-lite
	fowners root:video /opt/oclHachcat-lite
	einfo "oclhashcat-lite can be run as user if you are in the video group"
}
