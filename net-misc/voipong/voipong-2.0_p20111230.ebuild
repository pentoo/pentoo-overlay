# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-misc/voipong/voipong-2.0.ebuild,v 1.1.1.1 2006/03/20 22:56:49 grimmlin Exp $

EAPI=8

inherit vcs-snapshot

DESCRIPTION="detect all VoIP calls on a pipeline and dump actual conversation"
HOMEPAGE="http://www.enderunix.org/voipong/"

#inherit git-r3
#EGIT_REPO_URI="https://github.com/EnderUNIX/VoIPong"
SRC_URI="https://github.com/EnderUNIX/VoIPong/archive/d52e39304842fd3662a9f35f3b51c1725320bc4f.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="media-sound/sox
	${DEPEND}"

src_prepare() {
	sed -i -e 's:/usr/local::g' *.c
	sed -i -e 's:/usr/local::g' etc/voipong.conf
	sed -i -e "s#-g -Wall#${CFLAGS}#" Makefile.linux
	default
}

src_compile() {
	emake -f Makefile.linux
}

src_install () {
	dobin voipong voipctl
	insinto /etc/voipong/
	doins etc/voipong*
	exeinto /etc/voipong/modules/
	doexe modvocoder*.so
	dodoc ALGORITHMS AUTHORS ChangeLog KNOWN_BUGS NEWS README TODO
}
