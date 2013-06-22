# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/linux-sources/linux-sources-1.ebuild,v 1.2 2013/02/14 15:21:59 jer Exp $

EAPI=5

DESCRIPTION="Virtual for Linux kernel sources"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~x86"
IUSE="firmware"

DEPEND="firmware? ( sys-kernel/linux-firmware )"
RDEPEND="|| (
		sys-kernel/pentoo-sources:=
		sys-kernel/gentoo-sources
		sys-kernel/vanilla-sources
		sys-kernel/ck-sources
		sys-kernel/git-sources
		sys-kernel/hardened-sources
		sys-kernel/mips-sources
		sys-kernel/openvz-sources
		sys-kernel/pf-sources
		sys-kernel/rsbac-sources
		sys-kernel/rt-sources
		sys-kernel/tuxonice-sources
		sys-kernel/usermode-sources
		sys-kernel/vserver-sources
		sys-kernel/xbox-sources
		sys-kernel/zen-sources
		sys-kernel/aufs-sources
		sys-kernel/odroid-sources
		sys-kernel/chromeos-sources
	)"
