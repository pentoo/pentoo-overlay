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

IUSE="+minimal"

RDEPEND="minimal? ( app-crypt/hashcat-bin
	app-crypt/oclhashcat-plus-bin
	app-crypt/oclhashcat-lite-bin )
	app-arch/bzip2
	sys-libs/zlib
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libXrender
	x11-libs/libXau
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXdmcp
	x11-libs/libxcb
	dev-libs/expat
"
DEPEND="${RDEPEND}
        app-arch/p7zip"

S="${WORKDIR}/${MY_P}"

RESTRICT="strip binchecks"

src_install() {
        dodoc docs/*
        rm -rf *.exe docs

	#the author of hashcat-gui would prefer that all the hashcat tools are distributed with it,
	#and people in hell want ice water
	use minimal && rm -rf hashcat oclHashcat-lite oclHashcat-plus

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
	if use minimal; then
		dosym /opt/hashcat-bin /opt/${PN}/hashcat
		dosym /opt/oclhashcat-lite-bin /opt/${PN}/oclHashcat-lite
		dosym /opt/oclhashcat-plus-bin /opt/${PN}/oclHashcat-plus
		ewarn "hashcat-gui *requires* you to use the bundled versions of the hashcat tools,"
		ewarn "however, we are using the latest version instead. If this breaks, reinstall"
		ewarn "with USE=-minimal"
	else
		ewarn "You have disabled the minimal use flag which means the bundled versions of"
		ewarn "the hashcat tools are installed, this greatly increases size so you may"
		ewarn "wish to consider keeping the default of USE=minimal"
	fi
}
