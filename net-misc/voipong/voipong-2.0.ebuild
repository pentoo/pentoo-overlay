# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-misc/voipong/voipong-2.0.ebuild,v 1.1.1.1 2006/03/20 22:56:49 grimmlin Exp $

DESCRIPTION="tool for detecting all VoIP calls on a pipeline and dumps actual conversation to seperate wav files"
HOMEPAGE="http://www.enderunix.org/voipong/"
SRC_URI="http://www.enderunix.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-sound/sox
	net-libs/libpcap"

src_compile() {
	sed -i -e 's:/usr/local::g' *.c
	sed -i -e 's:/usr/local::g' etc/voipong.conf
	make -f Makefile.linux
}

src_install () {
	dobin voipong voipctl
	insinto /etc/voipong/
	doins etc/voipong*
	insinto /etc/voipong/modules/
	insopts -m0755
	doins modvocoder*.so
	dodoc ALGORITHMS AUTHORS ChangeLog KNOWN_BUGS NEWS README TODO
}
