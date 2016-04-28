# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="Web Server vulnerability scanner"
HOMEPAGE="http://www.cirt.net/Nikto2"
EGIT_REPO_URI="https://github.com/sullo/nikto.git"
EGIT_COMMIT="f738d5f4e7a6a28a99b62e72de494c0cfd1bfd67"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~amd64-linux ~x86-linux ~x86-macos"
IUSE="ssl"

RDEPEND="dev-lang/perl
	perl-core/JSON-PP
	net-analyzer/nmap
		ssl? (
			dev-libs/openssl
			dev-perl/Net-SSLeay
		)"
#we can't reuse a system libwhisker anymore because some $#$on modified it.
#see http://trac.assembla.com/Nikto_2/ticket/199 for more details
#	net-libs/libwhisker[ssl?]

S="${WORKDIR}/${P}/program"

src_prepare() {
	sed -i -e 's:config.txt:nikto.conf:g' plugins/*
	sed -i -e 's:/etc/nikto.conf:/etc/nikto/nikto.conf:' nikto.pl
	sed -i -e 's:# EXECDIR=/opt/nikto:EXECDIR=/usr/share/nikto:' nikto.conf

#	sed -i -e 's:# use LW2:use LW2:' nikto.pl
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

#	NIKTO_PMS='JSON-PP.pm'
#	einfo "symlinking ${NIKTO_PMS} to ${VENDOR_LIB}"

#	for _PM in ${NIKTO_PMS}; do
#	_TARGET=${VENDOR_LIB}/${_PM}
#	dosym /usr/share/nikto/plugins/${_PM} ${_TARGET}
#	done

	dodoc docs/*.txt
	dohtml docs/nikto_manual.html

	insinto ${VENDOR_PERL}
}
