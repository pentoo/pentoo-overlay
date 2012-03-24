# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_P="hashcat-${PV}"

inherit eutils pax-utils
DESCRIPTION="An multi-threaded multihash cracker"
HOMEPAGE="http://hashcat.net/hashcat/"

SRC_URI="http://hashcat.net/files/${MY_P}.7z"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
        app-arch/p7zip"

S="${WORKDIR}/${MY_P}"

RESTRICT="strip binchecks"

src_install() {
        dodoc docs/*
        rm -rf *.exe docs
        if use x86; then
                rm hashcat-cli64.bin
	fi
        if use amd64; then
                rm hashcat-cli32.bin
        fi

	#I assume this is needed but I didn't check
	pax-mark m hashcat-cli*.bin

	insinto /opt/${PN}
	doins -r "${S}"/*

	dodir /usr/bin
        if [ -f "${ED}"/opt/hashcat-bin/hashcat-cli32.bin ]
        then
		fperms +x /opt/hashcat-bin/hashcat-cli32.bin
		#dosym /opt/hashcat-bin/hashcat-cli32.bin /usr/bin/hashcat-cli32.bin
		#workaround for need to be run from /opt/hashcat-bin
		echo '#! /bin/sh' > "${ED}"/usr/bin/hashcat-cli32.bin
		echo 'cd /opt/hashcat-bin' >> "${ED}"/usr/bin/hashcat-cli32.bin
		echo 'echo "Warning: hashcat-cli32.bin is running from $(pwd) so be careful of relative paths."' >> "${ED}"/usr/bin/hashcat-cli32.bin
		echo './hashcat-cli32.bin $@' >> "${ED}"/usr/bin/hashcat-cli32.bin
		fperms +x /usr/bin/hashcat-cli32.bin
	fi
        if [ -f "${ED}"/opt/hashcat-bin/hashcat-cli64.bin ]
        then
		fperms +x /opt/hashcat-bin/hashcat-cli64.bin
		#dosym /opt/hashcat-bin/hashcat-cli64.bin /usr/bin/hashcat-cli64.bin
		#workaround for need to be run from /opt/hashcat-bin
		echo '#! /bin/sh' > "${ED}"/usr/bin/hashcat-cli64.bin
		echo 'cd /opt/hashcat-bin' >> "${ED}"/usr/bin/hashcat-cli64.bin
		echo 'echo "Warning: hashcat-cli64.bin is running from $(pwd) so be careful of relative paths."' >> "${ED}"/usr/bin/hashcat-cli64.bin
		echo './hashcat-cli64.bin $@' >> "${ED}"/usr/bin/hashcat-cli64.bin
		fperms +x /usr/bin/hashcat-cli64.bin
	fi
}
