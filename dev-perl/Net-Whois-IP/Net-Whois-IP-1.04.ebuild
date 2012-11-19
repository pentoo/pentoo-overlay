# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit perl-module

DESCRIPTION="Perl extension for looking up the whois information for ip addresses"
HOMEPAGE="http://search.cpan.org/~bschmitz/Net-Whois-IP-1.10/IP.pm"
SRC_URI="mirror://cpan/authors/id/B/BS/BSCHMITZ/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/perl-ExtUtils-MakeMaker"
RDEPEND="${DEPEND}"

SRC_TEST="do"
