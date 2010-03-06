# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit python flag-o-matic

DESCRIPTION="a tool for generic packet injection on 802.11"
HOMEPAGE="http://airpwn.sf.net"
SRC_URI="mirror://sourceforge/airpwn/$P.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+examples"

DEPEND=""
RDEPEND="net-wireless/lorcon-old
		 net-libs/libnet
		 dev-lang/python"

src_configure() {
	append-ldflags $(no-as-needed)
	econf
	# this is a huge mess...
	sed -i "s/python2.4/python$(python_get_version)/g" conf.h || die "sed failed"
	sed -i "s|-lssl -lorcon -lpthread -lpcre -lpcap -lnet|-lssl -lorcon -lpthread -lpcre -lpcap -lnet -lpython$(python_get_version)|g" Makefile || die "sed failed"
}

src_install() {
	DESTDIR="${D}" emake install
	dodoc README
	if use examples; then
		docinto sample-configs
		dodoc conf/*
	fi
}
