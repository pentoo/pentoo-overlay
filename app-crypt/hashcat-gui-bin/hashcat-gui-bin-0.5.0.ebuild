# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_P="hashcat-gui-${PV}"

inherit eutils pax-utils
DESCRIPTION="A gui for the *hashcat* suite of tools"
HOMEPAGE="http://hashcat.net/hashcat-gui/"

SRC_URI="http://hashcat.net/files/${MY_P}.7z"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

#fix rdep
#	libXrender.so.1 => /usr/lib64/libXrender.so.1 (0x00007f2906972000)
#	libfontconfig.so.1 => /usr/lib64/libfontconfig.so.1 (0x00007f2906742000)
#	libfreetype.so.6 => /usr/lib64/libfreetype.so.6 (0x00007f29064b7000)
#	libXext.so.6 => /usr/lib64/libXext.so.6 (0x00007f29062a6000)
#	libX11.so.6 => /usr/lib64/libX11.so.6 (0x00007f2905f83000)
#	libz.so.1 => /lib64/libz.so.1 (0x00007f2905d70000)
#	libdl.so.2 => /lib64/libdl.so.2 (0x00007f2905b6d000)
#	librt.so.1 => /lib64/librt.so.1 (0x00007f2905965000)
#	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f2905749000)
#	libstdc++.so.6 => /usr/lib/gcc/x86_64-pc-linux-gnu/4.5.3/libstdc++.so.6 (0x00007f290543d000)
#	libm.so.6 => /lib64/libm.so.6 (0x00007f29051c0000)
#	libgcc_s.so.1 => /usr/lib/gcc/x86_64-pc-linux-gnu/4.5.3/libgcc_s.so.1 (0x00007f2904faa000)
#	libc.so.6 => /lib64/libc.so.6 (0x00007f2904c21000)
#	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f2904a14000)
#	libexpat.so.1 => /usr/lib64/libexpat.so.1 (0x00007f29047f2000)
#	libxcb.so.1 => /usr/lib64/libxcb.so.1 (0x00007f29045d6000)
#	/lib64/ld-linux-x86-64.so.2 (0x00007f2906b7b000)
#	libXau.so.6 => /usr/lib64/libXau.so.6 (0x00007f29043d3000)
#	libXdmcp.so.6 => /usr/lib64/libXdmcp.so.6 (0x00007f29041cd000)

RDEPEND="app-crypt/hashcat-bin
	app-crypt/oclhashcat-plus-bin
	app-crypt/oclhashcat-lite-bin"
DEPEND="${RDEPEND}
        app-arch/p7zip"

S="${WORKDIR}/${MY_P}"

RESTRICT="strip binchecks"

src_install() {
        dodoc docs/*
	#the author of hashcat-gui would prefer that all the hashcat tools are distributed with it,
	#and people in hell want ice water
        rm -rf *.exe docs hashcat oclHashcat-lite oclHashcat-plus
        if use x86; then
                rm hashcat-gui64.bin
	fi
        if use amd64; then
                rm hashcat-gui32.bin
        fi

	#I assume this is needed but I didn't check
	pax-mark m hashcat-gui*.bin

	insinto /opt/${PN}
	doins -r "${S}"/*

	dodir /usr/bin
        if [ -f "${ED}"/opt/hashcat-gui-bin/hashcat-gui32.bin ]
        then
		fperms +x /opt/hashcat-gui-bin/hashcat-gui32.bin
		#dosym /opt/hashcat-gui-bin/hashcat-gui32.bin /usr/bin/hashcat-gui32.bin
		#workaround for need to be run from /opt/hashcat-bin
		echo '#! /bin/sh' > "${ED}"/usr/bin/hashcat-gui32.bin
		echo 'cd /opt/hashcat-bin' >> "${ED}"/usr/bin/hashcat-gui32.bin
		echo 'echo "Warning: hashcat-gui32.bin is running from $(pwd) so be careful of relative paths."' >> "${ED}"/usr/bin/hashcat-gui32.bin
		echo './hashcat-gui32.bin $@' >> "${ED}"/usr/bin/hashcat-gui32.bin
		fperms +x /usr/bin/hashcat-gui32.bin
	fi
        if [ -f "${ED}"/opt/hashcat-gui-bin/hashcat-gui64.bin ]
        then
		fperms +x /opt/hashcat-gui-bin/hashcat-gui64.bin
		#dosym /opt/hashcat-gui-bin/hashcat-gui64.bin /usr/bin/hashcat-gui64.bin
		#workaround for need to be run from /opt/hashcat-gui-bin
		echo '#! /bin/sh' > "${ED}"/usr/bin/hashcat-gui64.bin
		echo 'cd /opt/hashcat-gui-bin' >> "${ED}"/usr/bin/hashcat-gui64.bin
		echo 'echo "Warning: hashcat-gui64.bin is running from $(pwd) so be careful of relative paths."' >> "${ED}"/usr/bin/hashcat-gui64.bin
		echo './hashcat-gui64.bin $@' >> "${ED}"/usr/bin/hashcat-gui64.bin
		fperms +x /usr/bin/hashcat-gui64.bin
	fi
	dosym /opt/hashcat-bin /opt/${PN}/hashcat
	dosym /opt/oclhashcat-lite-bin /opt/${PN}/oclHashcat-lite
	dosym /opt/oclhashcat-plus-bin /opt/${PN}/oclHashcat-plus
}
