# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit subversion

DESCRIPTION="EFI-Shell - provides native UDK implemenations of a UEFI Shell 2.0."
HOMEPAGE="http://sourceforge.net/apps/mediawiki/tianocore/index.php?title=UEFI_Shell"
SRC_URI=""
# ESVN_REPO_URI="http://edk2.svn.sourceforge.net/svnroot/edk2/trunk/edk2/ShellBinPkg"
ESVN_REPO_URI="http://edk2.svn.sourceforge.net/svnroot/edk2/trunk/edk2/ShellBinPkg/UefiShell/X64"

LICENSE="intel-ucode"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/share/${PN}/shell"
	newins Shell.efi Shellx64.efi
}
