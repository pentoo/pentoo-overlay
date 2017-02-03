# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=6

inherit git-r3

DESCRIPTION="Automated script for performing Padding Oracle attacks"
HOMEPAGE="http://gdssecurity.com"
#https://github.com/GDSSecurity/PadBuster
EGIT_REPO_URI="https://github.com/gw0/PadBuster.git"
EGIT_COMMIT="94460ff70218d39a858fb941e7936283f347cf52"

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
