# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/oclhashcat-plus-bin/oclhashcat-plus-bin-0.13.ebuild,v 1.1 2013/02/03 01:55:07 zerochaos Exp $

EAPI=5

inherit eutils pax-utils

DESCRIPTION="An opencl multihash cracker"
HOMEPAGE="http://hashcat.net/oclhashcat-plus/"

MY_P="oclHashcat-plus-${PV}"
SRC_URI="http://hashcat.net/files/${MY_P}.7z"

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
QA_PREBUILT="*Hashcat-plus*.bin"

src_install() {
	dodoc docs/*
	rm -r *.exe docs || die
	use x86 && rm *Hashcat-plus64*
	use amd64 && rm *Hashcat-plus32*

	if ! use video_cards_fglrx; then
		rm -r kernels/4098 || die
		rm oclHashcat-plus*.bin || die
	fi
	if ! use video_cards_nvidia; then
		rm -r kernels/4318 || die
		rm cudaHashcat-plus*.bin || die
	fi
	pax-mark m *Hashcat-plus*.bin

	insinto /opt/${PN}
	doins -r "${S}"/* || die "Copy files failed"

	dodir /opt/bin

	cat <<-EOF > "${ED}"/opt/bin/oclhashcat-plus
		#! /bin/sh
		echo "oclHashcat-plus and all related files have been installed in /opt/${PN}"
		echo "Please run one of the following binaries to use gpu accelerated hashcat:"
	EOF

	for x in oclHashcat-plus64.bin oclHashcat-plus32.bin cudaHashcat-plus64.bin cudaHashcat-plus32.bin
	do
		if [ -f "${ED}"/opt/${PN}/${x} ]
		then
			case "${x}" in
				oclHashcat-plus64.bin)
					echo "echo '64 bit ATI accelerated \"oclHashcat-plus64.bin\"'" >> "${ED}"/opt/bin/oclhashcat-plus
					;;
				oclHashcat-plus32.bin)
					echo "echo '32 bit ATI accelerated \"oclHashcat-plus32.bin\"'" >> "${ED}"/opt/bin/oclhashcat-plus
					;;
				cudaHashcat-plus64.bin)
					echo "echo '64 bit NVIDIA accelerated \"cudaHashcat-plus64.bin\"'" >> "${ED}"/opt/bin/oclhashcat-plus
					;;
				cudaHashcat-plus32.bin)
					echo "echo '32 bit NVIDIA accelerated \"cudaHashcat-plus32.bin\"'" >> "${ED}"/opt/bin/oclhashcat-plus
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

	fperms +x /opt/bin/oclhashcat-plus
	fowners root:video /opt/${PN}
	touch "${ED}"/opt/${PN}/eula.accepted
	fperms 0660 /opt/${PN}/eula.accepted
	einfo "oclhashcat-plus can be run as user if you are in the video group"
}
