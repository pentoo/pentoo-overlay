# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/linux-sources/linux-sources-2.4.ebuild,v 1.1 2011/04/30 17:05:28 ulm Exp $

EAPI=2

DESCRIPTION="Virtual for Linux kernel sources"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( =sys-kernel/vanilla-sources-2.4*
		=sys-kernel/sparc-sources-2.4* )"
