# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/linux-sources/linux-sources-0.ebuild,v 1.1 2011/08/09 06:31:59 ulm Exp $

EAPI=2

DESCRIPTION="Virtual for Linux kernel sources"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND="|| (
		sys-kernel/gentoo-sources
		sys-kernel/pentoo-sources
		sys-kernel/vanilla-sources
		sys-kernel/cell-sources
		sys-kernel/ck-sources
		sys-kernel/cluster-sources
		sys-kernel/git-sources
		sys-kernel/hardened-sources
		sys-kernel/mips-sources
		sys-kernel/mm-sources
		sys-kernel/openvz-sources
		sys-kernel/pf-sources
		sys-kernel/sparc-sources
		sys-kernel/tuxonice-sources
		sys-kernel/usermode-sources
		sys-kernel/vserver-sources
		sys-kernel/xbox-sources
		sys-kernel/xen-sources
		sys-kernel/zen-sources
	)"
