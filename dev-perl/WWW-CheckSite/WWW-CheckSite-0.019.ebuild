# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Mechanize-FormFiller/WWW-Mechanize-FormFiller-0.08.ebuild,v 1.4 2007/12/27 19:39:34 ticho Exp $

inherit perl-module

MY_P="${P}"_52
DESCRIPTION="Interface to an iterator that checks a website"
SRC_URI="mirror://cpan/authors/id/A/AB/ABELTJE/snapdir/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/WWW-CheckSite/"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""
S="${WORKDIR}"/"${MY_P}"

SRC_TEST="do"

DEPEND="dev-lang/perl
	dev-perl/WWW-Mechanize
	dev-perl/HTML-Template"
