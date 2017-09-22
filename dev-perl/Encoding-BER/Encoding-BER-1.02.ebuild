# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit perl-module versionator

DESCRIPTION="Perl module for encoding/decoding data using ASN.1 Basic Encoding Rules (BER)"
HOMEPAGE="https://github.com/jaw0/Encoding-BER"
SRC_URI="mirror://cpan/authors/id/J/JA/JAW/${P}.tar.gz"
#http://search.cpan.org/CPAN/authors/id/J/JA/JAW/Encoding-BER-0.01.tar.gz

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
