# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="UPNP pentesting tool and library"
HOMEPAGE="http://bigbrainlabs.blogspot.com/"
SRC_URI="http://dev.pentoo.ch/~jensp/distfiles/UPnPwn-0.8.0-bh.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="=dev-lang/ruby-1.8*"

S=${WORKDIR}/UPnPwn-${PV}-bh

src_prepare(){
	# enforce ruby18
	sed -i 's|#!/usr/bin/env ruby|#!/usr/bin/env ruby18|' *.rb
}

src_install() {
	insinto /usr/share/${PN}
	insopts -m755
	doins *.rb *.bash || die
	dodir /usr/share/${PN}/stub || die
	dodoc README TODO || die
	make_wrapper upnpwn /usr/share/${PN}/UPnPwn.rb /usr/share/${PN}/ || die
}
