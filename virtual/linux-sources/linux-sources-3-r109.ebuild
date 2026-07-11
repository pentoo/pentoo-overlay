# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="Virtual for Linux kernel sources"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="firmware pentoo pentoo-lts"
REQUIRED_USE="?? ( pentoo pentoo-lts )"

RDEPEND="
	firmware? ( sys-kernel/linux-firmware )
	pentoo-lts? ( !sys-kernel/pentoo-sources[-lts(+)]
		sys-kernel/pentoo-lts-sources )
	pentoo? ( || ( sys-kernel/pentoo-sources sys-kernel/pentoo-lts-sources ) )
	|| (
		sys-kernel/pentoo-sources
		sys-kernel/pentoo-lts-sources
		sys-kernel/gentoo-sources
		sys-kernel/vanilla-sources
		sys-kernel/git-sources
		sys-kernel/mips-sources
		sys-kernel/pf-sources
		sys-kernel/rt-sources
		sys-kernel/zen-sources
		sys-kernel/raspberrypi-sources
		sys-kernel/gentoo-kernel
		sys-kernel/gentoo-kernel-bin
		sys-kernel/vanilla-kernel
		sys-kernel/linux-next
		sys-kernel/asahi-sources
		sys-kernel/gentoo-kernel-modprep
	)"
