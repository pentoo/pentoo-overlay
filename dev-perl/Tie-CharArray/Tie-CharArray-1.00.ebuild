# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-Array-Sorted/Tie-Array-Sorted-1.4.1.ebuild,v 1.4 2007/03/05 12:35:24 ticho Exp $

inherit perl-module versionator

DESCRIPTION="Manipulate perl strings through tied array"
HOMEPAGE="http://search.cpan.org/~iltzu/"
SRC_URI="mirror://cpan/authors/id/I/IL/ILTZU/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
