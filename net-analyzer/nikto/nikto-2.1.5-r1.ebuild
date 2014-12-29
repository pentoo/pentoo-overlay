# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Web Server vulnerability scanner."
HOMEPAGE="http://www.cirt.net/code/nikto.shtml"
SRC_URI="http://www.cirt.net/nikto/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ssl"

RDEPEND="dev-lang/perl
	net-analyzer/nmap
		ssl? (
			dev-libs/openssl
			dev-perl/Net-SSLeay
		)"
#we can't reuse a system libwhisker anymore because some $#$on modified it.
#see http://trac.assembla.com/Nikto_2/ticket/199 for more details
#	net-libs/libwhisker[ssl?]

src_prepare() {
	sed -i -e 's:config.txt:nikto.conf:g' \
			plugins/* || die

	sed -i -e 's:/etc/nikto.conf:/etc/nikto/nikto.conf:' \
		 nikto.pl || die

	sed -i -e 's:# EXECDIR=/opt/nikto:EXECDIR=/usr/share/nikto:' \
		 nikto.conf || die

#	sed -i -e 's:# use LW2:use LW2:' \
#		 nikto.pl || die
#	sed -i -e 's:require "$CONFIGFILE{'\''PLUGINDIR'\''}/LW2.pm":# require "$CONFIGFILE{'\''PLUGINDIR'\''}/LW2.pm":' \
#		 nikto.pl || die
#	rm plugins/LW2.pm || die "removing bundled lib LW2.pm failed"
}

src_install() {
	insinto /etc/nikto
	doins nikto.conf

	dobin nikto.pl replay.pl
	dosym /usr/bin/nikto.pl /usr/bin/nikto

	dodir /usr/share/nikto
	insinto /usr/share/nikto
	doins -r plugins templates databases

	dodoc docs/*.txt
	dohtml docs/nikto_manual.html
}
