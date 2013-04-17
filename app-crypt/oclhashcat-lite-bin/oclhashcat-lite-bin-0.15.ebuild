# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/oclhashcat-lite-bin/oclhashcat-lite-bin-0.14.ebuild,v 1.1 2013/02/03 02:00:57 zerochaos Exp $

EAPI=5

inherit eutils pax-utils

DESCRIPTION="An opencl hash cracker"
HOMEPAGE="http://hashcat.net/oclhashcat-lite/"
MY_P="oclHashcat-lite-${PV}"
SRC_URI="http://hashcat.net/files/${MY_P}.7z"

#license applies to this version per http://hashcat.net/forum/thread-1348.html
LICENSE="hashcat"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

IUSE_VIDEO_CARDS="video_cards_fglrx
	video_cards_nvidia"

IUSE="${IUSE_VIDEO_CARDS}"

RDEPEND="sys-libs/zlib
	video_cards_nvidia? ( >=x11-drivers/nvidia-drivers-310.32 )
	video_cards_fglrx?  ( =x11-drivers/ati-drivers-13.1 )"
DEPEND="${RDEPEND}
	app-arch/p7zip"

S="${WORKDIR}/${MY_P}"

RESTRICT="strip"
QA_PREBUILT="*Hashcat-lite*.bin"

src_install() {
	dodoc docs/*
	rm -rf *.exe docs || die
	if use x86; then
		rm oclHashcat-lite64.bin || die
		rm cudaHashcat-lite64.bin || die
	fi
	if use amd64; then
		rm oclHashcat-lite32.bin || die
		rm cudaHashcat-lite32.bin || die
	fi
	if ! use video_cards_fglrx; then
		rm -r kernels/4098 || die
		rm oclHashcat-lite*.bin || die
	fi
	if ! use video_cards_nvidia; then
		rm -r kernels/4318 || die
		rm cudaHashcat-lite*.bin || die
	fi

	#I assume this is needed but I didn't check
	pax-mark m *Hashcat-lite*.bin

	insinto /opt/${PN}
	doins -r "${S}"/*

	dodir /opt/bin

	cat <<-EOF > "${ED}"/opt/bin/oclhashcat-lite
		#! /bin/sh
		echo "oclHashcat-lite and all related files have been installed in /opt/${PN}"
		echo "Please run one of the following binaries to use gpu accelerated hashcat:"
	EOF

	for x in oclHashcat-lite64.bin oclHashcat-lite32.bin cudaHashcat-lite64.bin cudaHashcat-lite32.bin
	do
		if [ -f "${ED}"/opt/${PN}/${x} ]
		then
			case "${x}" in
				oclHashcat-lite64.bin)
					echo "echo '64 bit ATI accelerated \"oclHashcat-lite64.bin\"'" >> "${ED}"/opt/bin/oclhashcat-lite
					;;
				oclHashcat-lite32.bin)
					echo "echo '32 bit ATI accelerated \"oclHashcat-lite32.bin\"'" >> "${ED}"/opt/bin/oclhashcat-lite
					;;
				cudaHashcat-lite64.bin)
					echo "echo '64 bit NVIDIA accelerated \"cudaHashcat-lite64.bin\"'" >> "${ED}"/opt/bin/oclhashcat-lite
					;;
				cudaHashcat-lite32.bin)
					echo "echo '32 bit NVIDIA accelerated \"cudaHashcat-lite32.bin\"'" >> "${ED}"/opt/bin/oclhashcat-lite
					;;
			esac

			fperms +x /opt/${PN}/${x}

			cat <<-EOF > "${ED}"/opt/bin/${x}
				#! /bin/sh
				cd /opt/${PN}
				echo "Warning: ${x} is running from /opt/${PN} so be careful of relative paths."
				exec ./${x} "\$@"
			EOF

			fperms +x /opt/bin/${x}

		fi
	done

	fperms +x /opt/bin/oclhashcat-lite
	fowners root:video /opt/${PN}
	touch "${ED}"/opt/${PN}/eula.accepted
	fperms 0660 /opt/${PN}/eula.accepted
	einfo "oclhashcat-lite can be run as user if you are in the video group"
}
