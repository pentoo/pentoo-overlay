# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="set of tools to audit VoIP servers and devices using SIP protocol"
HOMEPAGE="https://github.com/Pepelux/sippts"
SRC_URI="https://github.com/Pepelux/sippts/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/IO-Socket-Timeout
	dev-perl/NetAddr-IP
	dev-perl/String-HexConvert
	dev-perl/Net-Pcap
	dev-perl/Net-Address-IP-Local
	dev-perl/DBD-SQLite"
DEPEND="${RDEPEND}
	dev-lang/perl[ithreads]"
