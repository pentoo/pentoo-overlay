# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# TODO: it's a deprecated package

EAPI=7

MY_PV="$(ver_rs 3 '-')"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A SQL Server injection & takeover tool"
HOMEPAGE="https://sqlninja.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	dev-lang/perl:0=
	dev-perl/NetPacket
	dev-perl/Net-Pcap
	dev-perl/Net-DNS
	dev-perl/Net-RawIP
	dev-perl/IO-Socket-SSL
	dev-perl/List-MoreUtils
	dev-perl/DBI"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -e "s:require \"lib/:require \"/usr/share/sqlninja/lib/:g" \
		-i sqlninja || die

	default
}

src_install () {
	dodoc sqlninja-howto.html ChangeLog README
	if use doc; then
		dodoc -r sources
		docompress -x "/usr/share/doc/${P}/sources"
	fi

	insinto "/etc/${PN}"
	newins sqlninja.conf sqlninja.conf.example

	rm -r sources sqlninja-howto.html ChangeLog README LICENSE || die 'removing docs failed'
	rm -r apps || die 'removing bundles apps failed'
	rm sqlninja.conf || die 'removing config failed'

	insinto "/usr/share/${PN}"
	doins -r *
	dobin sqlninja
}
