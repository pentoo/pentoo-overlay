# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils toolchain-funcs git-2

DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net"
EGIT_REPO_URI="https://git.kernel.org/pub/scm/fs/squashfs/squashfs-tools.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+xz lz4 lzma lzo xattr"

RDEPEND="
	sys-libs/zlib
	xz? ( app-arch/xz-utils )
	lz4? ( app-arch/lz4 )
	lzo? ( dev-libs/lzo )
	lzma? ( app-arch/xz-utils )
	xattr? ( sys-apps/attr )"
DEPEND="${RDEPEND}"

EGIT_SOURCEDIR="${WORKDIR}/${P}"
S="${WORKDIR}/${P}/${PN}"

use_sed() {
	local u=$1 s="${2:-`echo $1 | tr '[:lower:]' '[:upper:]'`}_SUPPORT"
	printf '/^#?%s =/%s\n' "${s}" \
		"$( use $u && echo s:.*:${s} = 1: || echo d )"
}

src_configure() {
	tc-export CC
	sed -i -r \
		-e "$(use_sed xz XZ)" \
		-e "$(use_sed lz4)" \
		-e "$(use_sed lzo)" \
		-e "$(use_sed xattr)" \
		-e "$(use_sed lzma LZMA_XZ)" \
		Makefile || die
}

src_install() {
	dobin mksquashfs unsquashfs
	cd .. || die
	dodoc README
}

pkg_postinst() {
	ewarn "This version of mksquashfs requires a 2.6.29 kernel or better"
	use xz &&
		ewarn "XZ support requires a 2.6.38 kernel or better"
}
