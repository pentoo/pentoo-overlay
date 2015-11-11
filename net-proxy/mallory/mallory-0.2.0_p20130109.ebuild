# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1 multilib

DESCRIPTION="An TCP/UDP transparent proxy that can be used to intercept network streams"
HOMEPAGE="https://intrepidusgroup.com/insight/mallory/"
SRC_URI="https://bitbucket.org/IntrepidusGroup/mallory/get/tip.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="dev-python/pynetfilter_conntrack
	dev-python/m2crypto
	dev-python/twisted-web
	dev-python/pyasn1
	dev-python/paramiko
	dev-python/pillow"
#pillow: 508266

DEPEND="${RDEPEND}"
#dev-python/pyro: the bundled Pyro-2.10 is too old

S="${WORKDIR}/IntrepidusGroup-mallory-4c3ea86c5679"

src_prepare(){
	epatch "${FILESDIR}/mallory-pillow.patch"
	#add shebang
	sed -e '1s|^|#!/usr/bin/env python\n\n|' -i src/mallory.py src/launchgui.py

	#TODO: change .log file location, sed src/config.py
}

src_install(){
	dodir /usr/$(get_libdir)/${PN}

	cp -R src/* "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"

	#The python line is in wrong place. We patch it manually
#	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}/${PN}.py

	fperms +x /usr/$(get_libdir)/${PN}/${PN}.py
	fperms +x /usr/$(get_libdir)/${PN}/launchgui.py

	#TODO
	#dodesktop sudo -E python2.7 ./launchgui.py
	dobin "${FILESDIR}"/{malloryd,mallory_gui}

	dodoc README SETUP CONTRIB
}
