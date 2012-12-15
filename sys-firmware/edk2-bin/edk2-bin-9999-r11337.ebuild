# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Binaries for the EDK2 plattform (UEFI tools)"
HOMEPAGE="http://sourceforge.net/apps/mediawiki/tianocore"
SRC_URI="http://pentoo-uefi.googlecode.com/files/${PF}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="hello-world qemu shell"
REQUIRED_USE="|| ( hello-world qemu shell )"

DEPEND=""
RDEPEND="qemu? ( >=app-emulation/qemu-0.9.1 )"

# S="$(dirname ${S})"
S="${WORKDIR}/${PF}"

src_install(){
	if use hello-world; then
		insinto "/usr/share/${PN}/hello-world"
		doins "HelloWorld.efi"
		doins "startup.nsh"
	fi

	if use qemu; then
		insinto "/usr/share/${PN}/qemu"
		newins OVMF.fd uefibios.bin
		newins CirrusLogic5446.rom vgabios-cirrus.bin
		dosym "../${PN}/qemu/uefibios.bin" /usr/share/qemu/uefibios-bin.bin
	fi

	if use shell; then
		insinto "/usr/share/${PN}/shell"
		newins Shell.efi Shellx64.efi
	fi
}

pkg_postinst() {
	use qemu && einfo "To use uefi with qemu, start it with '-bios uefibios.bin'"
	if use hello-world; then
		einfo "A sample HelloWorld.efi was installed in /usr/share/${PN}/hello-world."
		if use qemu; then
			einfo "To test the uefi support in qemu, simply run:"
			einfo "	qemu-kvm -hda fat:/usr/share/${PN}/hello-world -bios uefibios-bin.bin"
			einfo "and await the message 'UEFI Hello World!' before the shell prompt appears."
		fi
	fi
}
