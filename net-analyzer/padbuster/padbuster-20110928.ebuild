# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Automated script for performing Padding Oracle attacks"
HOMEPAGE="http://gdssecurity.com"
#https://github.com/GDSSecurity/PadBuster
EGIT_COMMIT="94460ff70218d39a858fb941e7936283f347cf52"
SRC_URI="https://github.com/gw0/PadBuster/archive/${EGIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/PadBuster-${EGIT_COMMIT}"

LICENSE="RPL-1.5"
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
