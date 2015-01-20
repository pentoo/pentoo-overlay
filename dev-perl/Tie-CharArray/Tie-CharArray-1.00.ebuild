# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

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
