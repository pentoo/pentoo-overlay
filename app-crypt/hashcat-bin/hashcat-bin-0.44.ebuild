# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/hashcat-bin/hashcat-bin-0.42.ebuild,v 1.1 2013/01/07 04:12:18 zerochaos Exp $

EAPI=4

MY_P="hashcat-${PV}"

inherit eutils pax-utils
DESCRIPTION="An multi-threaded multihash cracker"
HOMEPAGE="http://hashcat.net/hashcat/"

SRC_URI="http://hashcat.net/files/${MY_P}.7z"

#license applies to this version per http://hashcat.net/forum/thread-1348.html
LICENSE="hashcat"
SLOT="0"
KEYWORDS="-* ~amd64 ~amd64-linux ~x64-macos ~x86 ~x86-linux"

IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/p7zip"

S="${WORKDIR}/${MY_P}"

RESTRICT="strip"
QA_PREBUILT="opt/${PN}/hashcat-cli*.bin
		opt/${PN}/hashcat-cli64.app"

src_install() {
	dodoc docs/*
	rm -r *.exe docs || die
	use x86 || { rm hashcat-cli32.bin || die; }
	use amd64 || { rm hashcat-cli64.bin || die; }
	use x64-macos || { rm hashcat-cli64.app || die; }

	#I assume this is needed but I didn't check
	pax-mark m hashcat-cli*.bin

	insinto /opt/${PN}
	doins -r "${S}"/*

	dodir /opt/bin
	if [ -f "${ED}"/opt/${PN}/hashcat-cli32.bin ]
	then
		fperms +x /opt/${PN}/hashcat-cli32.bin
		cat <<-EOF > "${ED}"/opt/bin/hashcat-cli32.bin
			#! /bin/sh
			cd "${EPREFIX}"/opt/${PN}
			echo "Warning: hashcat-cli32.bin is running from ${EPREFIX}/opt/${PN} so be careful of relative paths."
			exec ./hashcat-cli32.bin \$@
		EOF
		fperms +x /opt/bin/hashcat-cli32.bin
	fi
	if [ -f "${ED}"/opt/${PN}/hashcat-cli64.bin ]
	then
		fperms +x /opt/${PN}/hashcat-cli64.bin
		cat <<-EOF > "${ED}"/opt/bin/hashcat-cli64.bin
			#! /bin/sh
			cd "${EPREFIX}"/opt/${PN}
			echo "Warning: hashcat-cli64.bin is running from ${EPREFIX}/opt/${PN} so be careful of relative paths."
			exec ./hashcat-cli64.bin \$@
		EOF
		fperms +x /opt/bin/hashcat-cli64.bin
	fi
	if [ -f "${ED}"/opt/${PN}/hashcat-cli64.app ]
	then
		fperms +x /opt/${PN}/hashcat-cli64.app
		cat <<-EOF > "${ED}"/opt/bin/hashcat-cli64.app
			#! /bin/sh
			cd "${EPREFIX}"/opt/${PN}
			echo "Warning: hashcat-cli64.app is running from ${EPREFIX}/opt/${PN} so be careful of relative paths."
			exec ./hashcat-cli64.app \$@
		EOF
		fperms +x /opt/bin/hashcat-cli64.app
	fi
}
