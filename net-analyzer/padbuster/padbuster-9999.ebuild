# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=3

inherit git-2

DESCRIPTION="Automated script for performing Padding Oracle attacks"
HOMEPAGE="http://gdssecurity.com"
EGIT_REPO_URI="git://github.com/gw0/PadBuster.git"
#https://github.com/GDSSecurity/PadBuster

LICENSE="RPL1.5"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/LWP-UserAgent-Determined
	virtual/perl-MIME-Base64
	virtual/perl-Getopt-Long
	virtual/perl-Time-HiRes
	virtual/perl-Compress-Raw-Zlib
	dev-perl/Crypt-SSLeay"

src_install() {
	newbin autoBuster.sh autobuster
	newbin padBuster.pl padbuster
	dodoc README
}
